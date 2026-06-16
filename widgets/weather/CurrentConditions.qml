import Quickshell
import Quickshell.Widgets
import QtQuick
import QtQuick.Layouts
import QtQuick.Effects
import qs.components

Rectangle {
  color: 'transparent'

  SystemClock {
    id: time
    precision: SystemClock.Seconds
  }

  RowLayout {
    anchors.fill: parent

    Rectangle {
      Layout.fillHeight: true
      implicitWidth: parent.width * 0.6
      color: 'transparent'

      ColumnLayout {
        anchors.fill: parent

        StyledRect {
          Layout.fillWidth: true
          implicitHeight: parent.height * 0.3
        }

        StyledRect {
          Layout.fillHeight: true
          Layout.fillWidth: true
          color: theme.surface_container_low

          StyledLabel {
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.top
            anchors.topMargin: 8

            font.pixelSize: 13
            opacity: 0.8
            text: "Total precipitation today"
          }

          RowLayout {
            anchors {
              fill: parent
              margins: 16
              topMargin: 40
            }

            Rectangle {
              Layout.fillHeight: true
              Layout.fillWidth: true
              color: 'transparent'

              RowLayout {
                id: rainLabel
                height: 20
                anchors {
                  horizontalCenter: parent.horizontalCenter
                }

                GoogleIcon {
                  text: 'rainy'
                  color: theme.primary
                }

                StyledLabel {
                  text: 'Rain'
                  color: theme.primary
                  font.bold: true
                }
              }

              StyledLabel {
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: rainLabel.bottom
                font.pixelSize: 13
                opacity: 0.8
                text: weather.data.daily.rain_sum[0] + 'mm'
                horizontalAlignment: Text.AlignHCenter
              }

              ClippingRectangle {
                id: rainBox
                width: parent.width
                height: parent.height * 0.7
                anchors.bottom: parent.bottom
                color: theme.mode == "dark" ? theme.surface_container_lowest : theme.surface_container_highest
                radius: 16


                Rectangle {
                  id: rainMeter
                  anchors.bottom: parent.bottom
                  width: parent.width
                  color: theme.primary
                  height: weather.data.daily.rain_sum[0] != 0 ? Math.max(rainLeft / weather.data.daily.rain_sum[0], 0) * parent.height : 0

                  property real rainLeft

                  Component.onCompleted: {
                    let total = 0;
                    for (let i = time.hours - 1; i < 24; i++) {
                      total += weather.data.hourly.rain[i];
                    }
                    rainLeft = total;
                  }
                }

                StyledLabel {
                  anchors.horizontalCenter: parent.horizontalCenter
                  anchors.bottom: parent.bottom
                  anchors.margins: 8

                  color: theme.on_primary
                  text: rainMeter.rainLeft + 'mm left'
                }
              }
            }

            Rectangle {
              Layout.fillHeight: true
              Layout.fillWidth: true
              color: 'transparent'

              RowLayout {
                id: showerLabel
                height: 20
                anchors {
                  horizontalCenter: parent.horizontalCenter
                }

                GoogleIcon {
                  text: 'rainy_light'
                  color: theme.secondary
                }

                StyledLabel {
                  text: 'Showers'
                  color: theme.secondary
                  font.bold: true
                }
              }

              StyledLabel {
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: showerLabel.bottom
                font.pixelSize: 13
                opacity: 0.8
                text: weather.data.daily.showers_sum[0] + 'mm'
                horizontalAlignment: Text.AlignHCenter
              }

              ClippingRectangle {
                id: showerBox
                width: parent.width
                height: parent.height * 0.7
                anchors.bottom: parent.bottom
                color: theme.mode == "dark" ? theme.surface_container_lowest : theme.surface_container_highest
                radius: 16

                Rectangle {
                  id: showerMeter
                  anchors.bottom: parent.bottom
                  width: parent.width
                  color: theme.secondary
                  height: weather.data.daily.showers_sum[0] != 0 ? Math.max(showersLeft / weather.data.daily.showers_sum[0], 0) * parent.height : 0

                  property real showersLeft

                  Component.onCompleted: {
                    let total = 0;
                    for (let i = time.hours - 1; i < 24; i++) {
                      total += weather.data.hourly.showers[i];
                    }
                    showersLeft = total;
                  }
                }

                StyledLabel {
                  anchors.horizontalCenter: parent.horizontalCenter
                  anchors.bottom: parent.bottom
                  anchors.margins: 8

                  color: theme.on_secondary
                  text: showerMeter.showersLeft + 'mm left'
                }
              }
            }

            Rectangle {
              Layout.fillHeight: true
              Layout.fillWidth: true
              color: 'transparent'

              RowLayout {
                id: snowLabel
                height: 20
                anchors {
                  horizontalCenter: parent.horizontalCenter
                }

                GoogleIcon {
                  text: 'mode_cool'
                  color: theme.tertiary
                }

                StyledLabel {
                  text: 'Snow'
                  color: theme.tertiary
                  font.bold: true
                }
              }

              StyledLabel {
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: snowLabel.bottom
                font.pixelSize: 13
                opacity: 0.8
                text: weather.data.daily.snowfall_sum[0] + 'cm'
                horizontalAlignment: Text.AlignHCenter
              }

              ClippingRectangle {
                id: snowBox
                width: parent.width
                height: parent.height * 0.7
                anchors.bottom: parent.bottom
                color: theme.mode == "dark" ? theme.surface_container_lowest : theme.surface_container_highest
                radius: 16

                Rectangle {
                  id: snowMeter
                  anchors.bottom: parent.bottom
                  width: parent.width
                  color: theme.tertiary
                  height: weather.data.daily.snowfall_sum[0] != 0 ? Math.max(snowLeft / weather.data.daily.snow_sum[0], 0) * parent.height : 0

                  property real snowLeft

                  Component.onCompleted: {
                    let total = 0;
                    for (let i = time.hours - 1; i < 24; i++) {
                      total += weather.data.hourly.snowfall[i];
                    }
                    snowLeft = total;
                  }

                }

                StyledLabel {
                  anchors.horizontalCenter: parent.horizontalCenter
                  anchors.bottom: parent.bottom
                  anchors.margins: 8

                  color: theme.on_tertiary
                  text: snowMeter.snowLeft + 'cm left'
                }
              }
            }
          }
        }
      }
    }

    Rectangle {
      Layout.fillHeight: true
      Layout.fillWidth: true
      color: 'transparent'

      ColumnLayout {
        anchors.fill: parent

        StyledRect {
          Layout.fillWidth: true
          implicitHeight: parent.height * 0.4
        }

        StyledRect {
          Layout.fillHeight: true
          Layout.fillWidth: true
        }

        StyledRect {
          Layout.fillHeight: true
          Layout.fillWidth: true
        }
      }
    }
  }
}
