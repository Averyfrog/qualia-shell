import QtQuick

Rectangle {
  radius: 16
  color: theme.surface_container

  //anchors.fill: parent

  Behavior on color {
    ColorAnimation {
      duration: 100
    }
  }

  Behavior on implicitWidth {
    PropertyAnimation {
      duration: 100
    }
  }

  Behavior on implicitHeight {
    PropertyAnimation {
      duration: 100
    }
  }
}
