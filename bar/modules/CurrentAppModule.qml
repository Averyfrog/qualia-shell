import Quickshell.Wayland
import QtQuick
import qs.components

Module {
  id: root

  defaultColor: theme.surface_container
  hoverColor: theme.primary_container
  activeColor: theme.primary
  textColor: theme.primary
  activeTextColor: theme.on_primary

  ModuleRow {
    StyledLabel {
      text: ToplevelManager.activeToplevel ? maxLength(ToplevelManager.activeToplevel.title, 40) : "~"
      font.bold: true
      color: root.appliedTextColor
      noAnim: false
    }
  }
}
