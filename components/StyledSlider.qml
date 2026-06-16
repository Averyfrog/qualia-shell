import QtQuick
import QtQuick.Controls
import qs.components

Slider {
  id: slider

  property int radius: 8
  //property int gap: 16
  property color foregroundColor: theme.primary
  property color backgroundColor: theme.surface
  property color behindColor: theme.surface
  property color handleColor: theme.on_surface

  property string gIcon

  leftPadding: gIcon ? 40 : 0

  background: Rectangle {
    id: sliderBar
    x: slider.leftPadding// + (slider.gIcon ? 40 : 0)
    y: slider.topPadding + slider.availableHeight / 2 - height / 2

    width: parent.width - (slider.gIcon ? 40 : 0)
    height: parent.height - 16

    color: slider.backgroundColor
    radius: slider.radius



    Rectangle {
      height: parent.height
      width: slider.visualPosition * parent.width
      radius: parent.radius

      color: slider.foregroundColor
    }
  }

  handle: Rectangle {
    x: slider.leftPadding + (slider.visualPosition * sliderBar.width) - width/2 // + (slider.gIcon ? 30 : 0)
    y: slider.topPadding + slider.availableHeight / 2 - height / 2

    color: slider.handleColor

    height: slider.enabled ? slider.height : 0// - slider.gap / 2
    width: slider.pressed ? 12 : (slider.hovered ? 24 : 16)
    Behavior on width {
      PropertyAnimation {
        duration: 100
      }
    }
    radius: slider.radius
    border {
      color: slider.behindColor
      width: 4
    }
  }

  GoogleIcon {
    id: icon
    anchors.verticalCenter: parent.verticalCenter
    anchors.left: parent.left

    rotation: -parent.rotation

    text: slider.gIcon
    font.pixelSize: slider.height / 1.8

  }
}
