import QtQuick
import QtQuick.Layouts
import qs.components

StyledRect {
  id: currentMayorCard
  Layout.fillHeight: true
  Layout.fillWidth: true
  color: theme.surface_container_high

  ColumnLayout {
    anchors.fill: parent
    anchors.margins: 8

    Rectangle {
      Layout.fillWidth: true
      implicitHeight: 24
      color: 'transparent'

      StyledLabel {
        text: "Mayor"
        font {
          pixelSize: 14
          bold: true
        }
        opacity: 0.6
      }
      StyledLabel {
        anchors.right: parent.right
        anchors.leftMargin: 10
        text: "current"
        font {
          pixelSize: 12
        }
        color: theme.on_surface_variant
      }
    }

    Rectangle {
      Layout.fillHeight: true
      Layout.fillWidth: true
      color: 'transparent'

      StyledLabel {
        anchors {
          top: parent.top
          left: parent.left
        }
        font {
          pixelSize: 18
          bold: false
        }
        text: electData.success ? electData.mayor.name : "..."
      }

      McFace {
        anchors {
          top: parent.top
          right: parent.right
        }
        size: 32
        face: electData.mayor.key
      }

      StyledLabel {
        id: ministerLabel
        anchors {
          verticalCenter: parent.verticalCenter
          left: parent.left
        }
        color: theme.on_surface_variant
        text: "Minister"
      }

      McFace {
        id: ministerFace
        anchors {
          verticalCenter: parent.verticalCenter
          right: ministerName.left
          margins: 8
        }
        size: 16
        face: electData.mayor.minister.key
      }

      StyledLabel {
        id: ministerName
        anchors {
          verticalCenter: parent.verticalCenter
          right: parent.right
          leftMargin: 8
        }
        text: electData.success ? electData.mayor.minister.name : "..."
      }

      StyledLabel {
        anchors {
         bottom: parent.bottom
         horizontalCenter: parent.horizontalCenter
         margins: 8
        }
        text: {
          var daysToElection = ((sb.sbTime.year-1) * 372) + 88 - sb.sbTime.totalDays
          if (daysToElection < 0) {
            daysToElection += 372
          }
          return daysToElection + " Days Left."
        }
      }
    }
  }
  ButtonArea {
    onClicked: sb.viewedMayor = electData.success ? electData.mayor : null
    defColor: theme.surface_container_high
  }
}
