import QtQuick

MouseArea {
  id: ma
  anchors.fill: parent
  hoverEnabled: true
  onEntered: hover.start()
  onExited: unhover.start()

  property color defColor: theme.surface_container
  property color hoverColor: theme.surface_variant

  ColorAnimation {
    id: hover
    target: ma.parent
    property: "color"
    to: ma.hoverColor
    duration: 100
  }
  ColorAnimation {
    id: unhover
    target: ma.parent
    property: "color"
    to: ma.defColor
    duration: 100
  }
}
