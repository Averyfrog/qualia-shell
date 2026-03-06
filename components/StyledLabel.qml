//import Quickshell
import QtQuick

Text {
  color: theme.on_surface
  width: Math.min(implicitWidth, parent.width - 16)
  elide: Text.ElideRight

  font.pixelSize: 12
  //font.family: "Roboto Mono"
  textFormat: Text.MarkdownText

  Behavior on color {
    ColorAnimation {
      duration: 100
    }
  }
}
