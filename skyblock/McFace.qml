import Quickshell.Widgets
import QtQuick
import qs.components

StyledRect {
  required property int size
  property string face
  implicitHeight: size
  implicitWidth: implicitHeight
  radius: 4

  GoogleIcon {
    anchors.centerIn: parent
    text: "person"
    font.pixelSize: size / 1.5
  }

  Image {
    anchors.fill: parent
    fillMode: Image.PreserveAspectFit
    source: "./assets/" + face + ".png"
  }
}
