import Quickshell
import QtQuick
import qs.components

Rectangle {
  anchors.fill: parent


  Image {
    source: ''
  }

  StyledRect { // Temporary until password input works
    id: closeButton
    anchors {
      top: parent.top
      topMargin: 8
      right: parent.right
      rightMargin: 8
    }

    width: 40
    height: width
    radius: 20
    
    MouseArea {
      anchors.fill: parent

      onClicked: lockRoot.unlocked();
    }

    GoogleIcon {
      anchors.centerIn: parent
      text: 'close'
      color: colors.red
      font.pixelSize: 24
    }
  }
} 
