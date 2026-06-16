import Quickshell
import QtQuick
import qs.components

Module {
  id: root

  property var wmoInfo: weather.getWmoInfo(time.hours, weather.data.current.weather_code)

  dropdownItem: weatherDropdown

  defaultColor: theme.surface_container
  hoverColor: theme.tertiary_container
  activeColor: theme.tertiary
  textColor: theme.on_surface
  activeTextColor: theme.on_tertiary

  ModuleRow {
    GoogleIcon {
      text: root.wmoInfo.icon
      color: root.active ? root.activeTextColor : theme.tertiary
    }

    StyledLabel {
      text: root.wmoInfo.label
      color: root.appliedTextColor
      font.pixelSize: 13
      font.weight: 600
    }
  }

  SystemClock {
    id: time
    precision: SystemClock.Seconds
  }

  ModuleButton {}
}
