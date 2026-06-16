import Quickshell
import Quickshell.Widgets
import Quickshell.Services.Mpris
import Quickshell.Services.Pipewire
import QtQuick
import QtQuick.Layouts
import qs.components

Rectangle {
  id: mdd
  implicitWidth: vertical ? 500 : 750
  implicitHeight: vertical ? 600 : 350

  property bool vertical: parent.vertical

  property color accent: theme.secondary

  anchors {
    top: parent.top
    margins: 40
  }

  color: 'transparent'

  GridLayout {
    anchors.fill: parent
    anchors.margins: 8

    columns: mdd.vertical ? 1 : 2

    Rectangle {
      implicitHeight: parent.height * (mdd.vertical ? 0.65 : 1)
      implicitWidth: parent.width * (mdd.vertical ? 1 : 0.65)
      color: 'transparent'

      ColumnLayout {
        anchors.fill: parent


        StyledRect {
          Layout.fillWidth: true
          implicitHeight: parent.height * (mdd.vertical ? 0.45 : 0.5)
          color: theme.surface_container_lowest

          RowLayout {
            anchors.fill: parent
            anchors.margins: 8

            StyledRect {
              Layout.fillHeight: true
              implicitWidth: height
              color: mdd.accent
              radius: 32

              StyledRect {
                anchors.centerIn: parent
                width: parent.width - 8
                height: width
                radius: parent.radius - 4

                GoogleIcon {
                  anchors.centerIn: parent
                  font.pixelSize: parent.width * 0.7
                  text: "art_track"
                  color: theme.surface_container_lowest
                }

                ClippingWrapperRectangle {
                  anchors.fill: parent
                  anchors.margins: 8

                  radius: parent.radius - 8
                  opacity: albumArt.status == Image.Ready ? 1 : 0
                  Image {
                    id: albumArt
                    source: music.activePlayer.trackArtUrl
                    fillMode: Image.PreserveAspectCrop
                  }
                }
              }
            }

            Rectangle {
              Layout.fillWidth: true
              Layout.fillHeight: true
              color: 'transparent'

              ColumnLayout {
                anchors.fill: parent


                StyledRect {
                  Layout.fillWidth: true
                  Layout.fillHeight: true
                  radius: 8
                  color: 'transparent'

                  ColumnLayout {
                    anchors {
                      fill: parent
                    }
                    anchors.margins: 4

                    Rectangle {
                      // Song Name
                      Layout.fillWidth: true
                      implicitHeight: 20
                      color: 'transparent'

                      RowLayout {
                        height: parent.height

                        GoogleIcon {
                          text: 'music_note'
                          color: mdd.accent
                        }
                        StyledLabel {
                          text: music.activePlayer ? music.activePlayer.trackTitle : "Nothing"
                          font {
                            pixelSize: 14
                            bold: true
                          }
                          Layout.maximumWidth: parent.parent.width - 32
                          color: mdd.accent
                        }
                      }
                    }

                    Rectangle {
                      // Album Name
                      Layout.fillWidth: true
                      implicitHeight: 20
                      color: 'transparent'

                      RowLayout {
                        height: parent.height

                        GoogleIcon {
                          text: 'album'
                          opacity: 0.7
                        }
                        StyledLabel {
                          text: music.activePlayer ? music.activePlayer.trackAlbum : "Nowhere"
                          Layout.maximumWidth: parent.parent.width - 32
                          opacity: 0.7
                        }
                      }
                    }

                    Rectangle {
                      // Artist Name
                      Layout.fillWidth: true
                      implicitHeight: 20
                      color: 'transparent'

                      RowLayout {
                        height: parent.height

                        GoogleIcon {
                          text: 'artist'
                        }
                        StyledLabel {
                          text: music.activePlayer ? music.activePlayer.trackArtist : "Nobody"
                          Layout.maximumWidth: parent.parent.width - 32
                        }
                      }
                    }
                  }
                }


                StyledRect {
                  Layout.fillWidth: true
                  Layout.fillHeight: true
                  color: theme.surface_container_low
                  radius: 8

                  StyledSlider {
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.top: parent.top

                    anchors.margins: 4
                    width: parent.width - 32

                    foregroundColor: mdd.accent
                    behindColor: theme.surface_container_low

                    height: 28

                    value: !pressed ? music.accuratePosition : null
                    to: music.accurateLength

                    onPressedChanged: {
                      if (!pressed) {
                        music.accuratePosition = value
                        music.activePlayer.position = value
                      }
                    }
                  }

                  Rectangle {
                    anchors {
                      left: parent.left
                      right: parent.right
                      bottom: parent.bottom
                      margins: 8
                    }
                    color: 'transparent'

                    implicitHeight: parent.height * 0.5

                    RowLayout {
                      anchors.fill: parent

                      Rectangle {
                        Layout.fillWidth: true
                        Layout.fillHeight: true
                        color: 'transparent'

                        StyledLabel {
                          anchors.centerIn: parent
                          text: {
                            var position = Math.floor(music.accuratePosition)
                            var secs = position % 60
                            var mins = (position - secs)/60
                            return mins + ":" + ("0" + secs).slice(-2)
                          }
                          elide: Text.ElideNone
                        }
                      }

                      StyledRect {
                        implicitWidth: 32
                        implicitHeight: 24
                        radius: 4

                        topLeftRadius: 16
                        bottomLeftRadius: 16

                        color: theme.secondary_container

                        GoogleIcon {
                          anchors.centerIn: parent
                          color: theme.on_secondary_container
                          text: 'skip_previous'
                        }

                        ButtonArea {
                          defColor: theme.secondary_container
                          hoverColor: theme.on_secondary
                          onClicked: music.activePlayer.previous()
                        }
                      }

                      StyledRect {
                        implicitWidth: 32
                        implicitHeight: 24
                        radius: 4

                        color: theme.secondary_container

                        GoogleIcon {
                          anchors.centerIn: parent
                          color: theme.on_secondary_container
                          text: 'replay_10'
                        }

                        ButtonArea {
                          defColor: theme.secondary_container
                          hoverColor: theme.on_secondary
                          onClicked: music.activePlayer.seek(-10)
                        }
                      }

                      StyledRect {
                        implicitWidth: 32
                        implicitHeight: width
                        radius: 40

                        color: mdd.accent

                        GoogleIcon {
                          anchors.horizontalCenter: parent.horizontalCenter
                          anchors.top: parent.top
                          anchors.topMargin: -0.5
                          color: theme.surface
                          font.pixelSize: 28
                          text: music.activePlayer ? (music.activePlayer.isPlaying ? "pause_circle" : "play_circle") : "play_circle"
                        }

                        ButtonArea {
                          defColor: theme.secondary
                          hoverColor: theme.secondary_container
                          onClicked: music.activePlayer.togglePlaying()
                        }
                      }

                      StyledRect {
                        implicitWidth: 32
                        implicitHeight: 24
                        radius: 4

                        color: theme.secondary_container

                        GoogleIcon {
                          anchors.centerIn: parent
                          color: theme.secondary
                          text: 'forward_10'
                        }

                        ButtonArea {
                          defColor: theme.secondary_container
                          hoverColor: theme.on_secondary
                          onClicked: music.activePlayer.seek(10)
                        }
                      }

                      StyledRect {
                        implicitWidth: 32
                        implicitHeight: 24
                        radius: 4

                        topRightRadius: 16
                        bottomRightRadius: 16

                        color: theme.secondary_container

                        GoogleIcon {
                          anchors.centerIn: parent
                          color: theme.secondary
                          text: 'skip_next'
                        }

                        ButtonArea {
                          defColor: theme.secondary_container
                          hoverColor: theme.on_secondary
                          onClicked: music.activePlayer.next()
                        }
                      }

                      Rectangle {
                        Layout.fillWidth: true
                        Layout.fillHeight: true
                        color: 'transparent'

                        StyledLabel {
                          anchors.centerIn: parent
                          text: {
                            var position = Math.floor(music.accurateLength)
                            var secs = position % 60
                            var mins = (position - secs)/60
                            return mins + ":" + ("0" + secs).slice(-2)
                          }
                          elide: Text.ElideNone
                        }
                      }
                    }
                  }
                }
              }
            }
          }
        }

        StyledRect {
          Layout.fillWidth: true
          Layout.fillHeight: true

          RowLayout {
            anchors.top: parent.top
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.margins: 8
            width: parent.width - 32
            height: 32

            StyledLabel {
              text: "Lyrics"
              font.bold: true
              Layout.alignment: Qt.AlignVCenter
            }
          }

          Flickable {
            anchors.fill: parent
            anchors.leftMargin: 16
            anchors.rightMargin: 16
            anchors.topMargin: 32
            anchors.bottomMargin: 2
            contentHeight: lyrics.height
            clip: true

            onContentHeightChanged: contentY = 0

            StyledLabel {
              id: lyrics
              opacity: 0.8
              text: {
                music.lyricData && music.lyricData.name != "TrackNotFound" ?
                  ( music.lyricData.instrumental ? "\n♪ Instrumental ♪" :
                  "♪\n" + music.lyricData.plainLyrics + "\n♪" )
                  : "\n No lyrics found, sorry!"
              }
              font.pixelSize: 18
              wrapMode: Text.WordWrap
              anchors.centerIn: parent
              horizontalAlignment: Text.AlignHCenter
            }
          }

          Rectangle {
            anchors {
              top: parent.top
              margins: 32
            }
            height: 16
            width: parent.width
            gradient: Gradient {
              GradientStop { position: 1; color: 'transparent' }
              GradientStop { position: 0; color: theme.surface_container }
            }
          }

          Rectangle {
            anchors {
              bottom: parent.bottom
              horizontalCenter: parent.horizontalCenter
            }
            height: 16
            width: parent.width - 32
            gradient: Gradient {
              GradientStop { position: 0; color: 'transparent' }
              GradientStop { position: 1; color: theme.surface_container }
            }
          }
        }
      }
    }

    Rectangle {
      Layout.fillWidth: true
      Layout.fillHeight: true
      color: 'transparent'

      GridLayout {
        anchors.fill: parent

        columns: mdd.vertical ? 1 : 2

        StyledRect {
          implicitWidth: parent.width * (mdd.vertical ? 1 : 0.35)
          implicitHeight: parent.height * (mdd.vertical ? 0.4 : 1)

          GridLayout {
            anchors.fill: parent

            columns: mdd.vertical ? 1 : 2
            rowSpacing: 0
            columnSpacing: 0

            Rectangle {
              implicitWidth: parent.width * (mdd.vertical ? 1 : 0.5)
              implicitHeight: parent.height * (mdd.vertical ? 0.5 : 1)
              color: 'transparent'

              StyledSlider {
                id: masterVolumeSlider

                rotation: mdd.vertical ? 0 : -90

                anchors.centerIn: parent

                implicitWidth: mdd.vertical ? parent.width - 32 : parent.parent.height - 32
                implicitHeight: 40

                foregroundColor: theme.mode == "dark" ? music.colors[5] : music.colors[1]
                behindColor: theme.surface_container

                Behavior on value {
                  enabled: !masterVolumeSlider.pressed
                  PropertyAnimation {
                    duration: 100
                  }
                }

                gIcon: {
                  let volume = Pipewire.defaultAudioSink ? Pipewire.defaultAudioSink.audio.volume : 0;

                  if (volume == 0) return "volume_off";
                  if (volume < 0.3) return "volume_mute";
                  if (volume < 0.6) return "volume_down";
                  return "volume_up"
                }

                PwObjectTracker {
                  objects: [ Pipewire.defaultAudioSink ]
                }

                value: Pipewire.defaultAudioSink ? Pipewire.defaultAudioSink.audio.volume : 0

                onMoved: {
                  Pipewire.defaultAudioSink.audio.volume = value
                }
              }
            }
            Rectangle {
              Layout.fillHeight: true
              Layout.fillWidth: true
              color: 'transparent'


              StyledSlider {
                id: musicVolumeSlider

                rotation: mdd.vertical ? 0 : -90

                anchors.centerIn: parent

                behindColor: theme.surface_container

                implicitWidth: mdd.vertical ? parent.width - 32 : parent.parent.height - 32
                implicitHeight: 40

                foregroundColor: theme.mode == "dark" ? music.colors[6] : music.colors[2]

                Behavior on value {
                  enabled: !musicVolumeSlider.pressed
                  PropertyAnimation {
                    duration: 100
                  }
                }

                gIcon: {
                  let volume = value;

                  if (volume == 0) return "music_off";
                  return "music_note"
                }

                value: music.activePlayer ? music.activePlayer.volume : 0

                enabled: music.activePlayer ? music.activePlayer.volumeSupported : false
                opacity: music.activePlayer && music.activePlayer.volumeSupported ? 1 : 0.3

                onMoved: {
                  music.activePlayer.volume = value
                }
              }
            }
          }
        }

        StyledRect {
          Layout.fillWidth: true
          Layout.fillHeight: true

          GridLayout {
            anchors.fill: parent
            anchors.margins: 8

            columns: mdd.vertical ? 8 : 1

            Repeater {
              model: music.colors

              delegate: StyledRect {
                Layout.fillHeight: true
                Layout.fillWidth: true

                radius: 12
                opacity: ma.containsMouse ? 1 : 0.7

                Behavior on opacity {
                  OpacityAnimator {
                    duration: 100
                  }
                }

                MouseArea {
                  id: ma
                  anchors.fill: parent
                  hoverEnabled: true
                }

                color: modelData
              }
            }
          }
        }
      }
    }
  }
}
