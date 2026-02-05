//import Quickshell
import QtQuick

Text {
  color: colors.base05
  width: implicitWidth

  font.pixelSize: 12

  Behavior on color {
    ColorAnimation {
      duration: 100
    }
  }
}
