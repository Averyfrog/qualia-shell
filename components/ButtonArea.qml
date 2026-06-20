import QtQuick

MouseArea {
  id: ma
  anchors.fill: parent
  hoverEnabled: true
  onEntered: {
    hover.start()
    hovered = true
  }
  onExited: {
    unhover.start()
    hovered = false
  }

  property color defColor: theme.surface_container
  property color hoverColor: theme.surface_variant
  property bool hovered: false

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
