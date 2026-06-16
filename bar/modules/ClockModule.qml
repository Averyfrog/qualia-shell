import Quickshell
import QtQuick
import QtQuick.Layouts
import qs.components

Module {
  id: cl

  dropdownItem: clockDropdown

  ModuleRow {
    GoogleIcon {
      font {
        pixelSize: 18
        bold: true
      }
      text: "schedule"
      color: cl.active ? cl.activeTextColor : theme.primary
    }

    StyledLabel {
      font {
        pixelSize: 18
        bold: true
      }
      text: Qt.formatTime(time.date, "hh:mm")
      color: cl.appliedTextColor
    }
  }

  SystemClock {
    id: time
    precision: SystemClock.Seconds
  }
  ModuleButton {}
}
