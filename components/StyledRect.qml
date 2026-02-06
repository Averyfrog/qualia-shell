import QtQuick
import QtQuick.Layouts

Rectangle {
  radius: 16
  color: colors.base00

  //anchors.fill: parent

  Behavior on color {
    ColorAnimation {
      duration: 100
    }
  }

}
