import QtQuick
import QtQuick.Layouts
import QtQuick.Effects
import qs.components

StyledRect {
  id: root
  implicitHeight: 32
  radius: 12
  implicitWidth: children[0].implicitWidth + 16

  property color defaultColor: theme.surface_container
  property color hoverColor: theme.surface_variant
  property color activeColor: theme.primary
  property color textColor: theme.on_surface
  property color activeTextColor: theme.on_primary
  property var dropdownItem: null

  readonly property bool active: dropdownLoader.sourceComponent == dropdownItem && dropdownLoader.opacity == 1
  color: active ? activeColor : defaultColor
  property color appliedTextColor: active ? activeTextColor : textColor

}
