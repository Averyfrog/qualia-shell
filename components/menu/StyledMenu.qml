import QtQuick
import QtQuick.Controls
import QtQuick.Effects
import qs.components

Menu {
  id: menu
  popupType: Popup.Window
  implicitWidth: 220
  background: Item {
    RectangularShadow {
      anchors.fill: back
      radius: back.radius
      opacity: 0.7
    }
    StyledRect {
      id: back
      topLeftRadius: 4
      radius: 12
      anchors.margins: menu.padding
    }
  }

  padding: 5

  property string name: title

  font.family: 'Roboto Mono'

  delegate: StyledMenuItem {
    id: menuItem

    contentItem: Rectangle {
      color: 'transparent'
      StyledLabel {
        anchors.verticalCenter: parent.verticalCenter
        text: menuItem.text
        anchors.left: parent.left
        anchors.leftMargin: 8
        font.family: menu.font.family
      }
    }

    arrow: GoogleIcon {
      height: parent.height
      text: 'keyboard_arrow_right'
      font.pixelSize: 20
      anchors {
        right: parent.right 
        rightMargin: 8
      }
      verticalAlignment: Text.AlignVCenter
    }
  }
  
  transformOrigin: Item.TopLeft

  exit: Transition {
    NumberAnimation { property: "opacity"; from: 1.0; to: 0.0; duration: 100
      easing.bezierCurve: [ .59,.07,.18,1.37 ] }
    NumberAnimation { property: "scale"; from: 1.0; to: 0.9; duration: 100
      easing.bezierCurve: [ .59,.07,.18,1.37 ] }
  }
  enter: Transition {
    NumberAnimation { property: "opacity"; from: 0.0; to: 1.0; duration: 100
      easing.bezierCurve: [ .59,.07,.18,1.37 ] }
    NumberAnimation { property: "scale"; from: 0.9; to: 1.0; duration: 100
      easing.bezierCurve: [ .59,.07,.18,1.37 ] }
  }
  
}
