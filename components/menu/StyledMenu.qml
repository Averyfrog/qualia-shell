import QtQuick
import QtQuick.Controls
import qs.components

Menu {
  id: menu
  popupType: Popup.Window
  implicitWidth: 180
  background: StyledRect {
    topLeftRadius: 4
  }

  property string name: title

  onOpened: console.log(title)

  delegate: StyledMenuItem {
    id: menuItem

    contentItem: Rectangle {
      color: 'transparent'
      StyledLabel {
        anchors.verticalCenter: parent.verticalCenter
        text: menuItem.text
        anchors.left: parent.left
        anchors.leftMargin: 8
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
