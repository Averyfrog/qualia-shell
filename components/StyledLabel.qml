//import Quickshell
import QtQuick

Text {
  color: colors.base05
  width: parent.width - 16
  elide: Text.ElideRight

  font.pixelSize: 12

  Behavior on color {
    ColorAnimation {
      duration: 100
    }
  }
}
