import Quickshell.Services.UPower
import QtQuick
import qs.components

Rectangle {
  implicitWidth: 500
  implicitHeight: 400

  anchors {
    top: parent.top
    margins: 40
  }

  color: 'transparent'

  StyledRect {
    width: 100
    height: 40

    anchors.centerIn: parent

    StyledLabel {
      text: PowerProfile.toString(PowerProfiles.profile)
      anchors.centerIn: parent
    }

    ButtonArea {
      onClicked: settings.bar.leftModules = [ "Weather" ]
    }
  }
}
