import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import qs.components

MenuItem {
  id: item
  property string gIcon: "add_circle"
  height: 40
  property color color: colors.base05
  property color hoverColor: colors.accent  

  font.family: menu.font.family

  background: StyledRect {
    color: item.highlighted ? colors.base02 : 'transparent'

    anchors {
      fill: parent
      margins: 4
    }
    radius: 8
  }
  contentItem: RowLayout {
    anchors.margins: 10
    anchors.fill: parent
    anchors.leftMargin: item.highlighted ? 16 : 8
    Behavior on anchors.leftMargin {
      NumberAnimation {
        duration: 100
      }
    }
    Rectangle {
      color: 'transparent'
      Layout.fillHeight: true
      width: 24
      GoogleIcon {
        text: item.gIcon
        anchors.centerIn: parent
        color: item.highlighted ? item.hoverColor : item.color
        opacity: item.highlighted ? 1 : 0.8
      }
    }
    Rectangle {
      color: 'transparent'
      Layout.fillWidth: true
      Layout.fillHeight: true
      StyledLabel {
        font.family: item.font.family
        font.pixelSize: 11
        text: item.text
        color: item.highlighted ? item.hoverColor : item.color
        //verticalAlignment: Text.AlignVCenter
        anchors.verticalCenter: parent.verticalCenter
      }
    }
  }
}
