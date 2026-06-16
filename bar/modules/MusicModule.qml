import Quickshell.Services.Mpris
import QtQuick
import QtQuick.Layouts
import qs.components

Rectangle {
  implicitHeight: 32
  implicitWidth: mrow.implicitWidth
  color: 'transparent'

  RowLayout {
    id: mrow
    anchors.fill: parent
    Module {
      id: m

      defaultColor: theme.on_secondary
      hoverColor: theme.secondary_container
      activeColor: theme.secondary
      textColor: theme.secondary
      activeTextColor: theme.on_secondary
      dropdownItem: musicDropdown

      ModuleRow {
        StyledLabel {
          font {
            bold: true
          }
          color: m.appliedTextColor
          text: maxLength(music.activePlayer ? music.activePlayer.trackTitle : "nothing", 24)
          noAnim: false
        }
        GoogleIcon {
          color: m.appliedTextColor
          text: "music_note"
        }
        StyledLabel {
          font {
            bold: true
          }
          opacity: 0.7
          color: m.appliedTextColor
          text: maxLength(music.activePlayer ? music.activePlayer.trackArtist : "nobody", 18)
          noAnim: false
        }
      }

      ModuleButton {}
    }

    Module {
      radius: 40
      color: theme.on_secondary
      ModuleRow {
        GoogleIcon {
          color: m.textColor
          text: music.activePlayer && music.activePlayer.isPlaying ? "pause" : "play_arrow"
        }
      }
      CircularProgress {
        width: 30
        circleWidth: 2
        value: music.accuratePosition / music.accurateLength
        backgroundColor: 'transparent'
      }
      ButtonArea {
        onClicked: music.activePlayer.togglePlaying()

        defColor: theme.on_secondary
        hoverColor: theme.secondary_container
      }
    }
  }
}
