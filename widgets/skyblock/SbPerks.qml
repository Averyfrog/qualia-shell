import Quickshell
import Quickshell.Widgets
import QtQuick
import QtQuick.Layouts
import qs.components

ClippingRectangle {
  id: perks
  Layout.fillHeight: true
  Layout.fillWidth: true
  color: theme.surface_container_high
  radius: 16

  required property var mayor

  McFace {
    anchors {
      margins: 10
      top: parent.top
      left: parent.left
    }
    size: 16
    face: mayor.key
  }

  StyledLabel {
    anchors {
      margins: 8
      leftMargin: 32
      left: parent.left
      top: parent.top
    }
    font {
      pixelSize: 14
      bold: true
    }
    color: theme.on_surface_variant
    text: electData.success ? perks.mayor.name + "'s Perks" : "...'s Perks"
  }
  StyledLabel {
    anchors {
      right: parent.right
      top: parent.top
      margins: 8
    }
    color: theme.on_surface_variant
    text: mayor == electData.success ? (sb.electData.mayor ? "current" : "potential") : ""
  }

  Flickable {
    anchors.fill: parent
    anchors.topMargin: 40
    contentHeight: perksList.height
    clip: true
    ColumnLayout {
      id: perksList
      width: parent.width
      Repeater {
        model: electData.success ? perks.mayor.perks : 0

        delegate: StyledRect {
          id: perkInfo
          Layout.fillWidth: true
          //Layout.fillHeight: true
          implicitHeight: showPerks ? 48 + perkDescription.height : 32
          color: theme.surface_container_high
          radius: 8

          property bool showPerks: false

          GoogleIcon {
            anchors {
              margins: 8
              left: parent.left
              top: parent.top
              topMargin: 6
            }
            text: "keyboard_arrow_down"
            rotation: showPerks ? 0 : -90
          }

          StyledLabel {
            anchors {
              margins: 8
              left: parent.left
              top: parent.top
              leftMargin: 32
            }
            font {
              pixelSize: 13
              bold: true
            }
            text: modelData.name
          }
          StyledLabel {
            id: perkDescription
            anchors {
              margins: 8
              left: parent.left
              top: parent.top
              topMargin: 32
            }
            text: perkInfo.showPerks ? sb.mcToMarkdown(modelData.description) : ""
            wrapMode: Text.WordWrap
          }

          ButtonArea {
            onClicked: perkInfo.showPerks = !perkInfo.showPerks
            defColor: theme.surface_container_high
          }
        }
      }
    }
  }
}
