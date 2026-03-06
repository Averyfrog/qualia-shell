import QtQuick
import QtQuick.Layouts
import qs.components

StyledRect {
  id: mayorVotes
  Layout.fillHeight: true
  implicitWidth: parent.width * 0.5
  color: theme.surface_container_high

  StyledLabel {
    anchors {
      margins: 8
      top: parent.top
      horizontalCenter: parent.horizontalCenter
    }
    font {
      pixelSize: 13
      bold: true
    }
    color: theme.on_surface_variant
    text: "Upcoming Election"
  }

  ColumnLayout {
    anchors.fill: parent
    anchors.topMargin: 32
    anchors.bottomMargin: 8
    spacing: 0

    Repeater {
      model: sb.electData.current.candidates
      //model: 5

      delegate: StyledRect {
        Layout.fillHeight: true
        Layout.fillWidth: true
        color: theme.surface_container_high
        radius: 4

        McFace {
          anchors {
            leftMargin: 4
            verticalCenter: parent.verticalCenter
            left: parent.left
          }
          size: 16
          face: modelData.key
        }

        StyledLabel {
          anchors {
            left: parent.left
            leftMargin: 24
            verticalCenter: parent.verticalCenter
          }
          font {
            bold: true
          }

          text: modelData.name
        }
        StyledLabel {
          anchors {
            right: parent.right
            margins: 8
            verticalCenter: parent.verticalCenter
          }

          text: modelData.votes
        }
        ButtonArea {
          onClicked: sb.viewedMayor = sb.electData.current.candidates[index]
          defColor: theme.surface_container_high
        }
      }
    }
  }
}
