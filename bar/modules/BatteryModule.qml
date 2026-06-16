import Quickshell.Services.UPower
import QtQuick
import qs.components

Module {
  id: bat

  property int charge: Math.floor(UPower.displayDevice.percentage * 100)
  //property int charge: 16

  //textColor: charge < 21 ? (dropdownLoader.sourceComponent == battery && dropdownLoader.opacity == 1 ? theme.error : theme.on_error) : theme.tertiary
  defaultColor: charge < 21 ? theme.on_error : theme.on_tertiary
  hoverColor: charge < 21 ? theme.error_container : theme.tertiary_container
  activeColor: charge < 21 ? theme.error : theme.tertiary
  textColor: charge < 21 ? theme.error : theme.tertiary
  activeTextColor: charge < 21 ? theme.on_error : theme.on_tertiary

  //color: charge < 21 ? (dropdownLoader.sourceComponent == battery && dropdownLoader.opacity == 1 ? theme.on_error : theme.error) : theme.on_tertiary
  dropdownItem: batteryDropdown

  ModuleRow {
    GoogleIcon {
      id: batteryIcon

      font.pixelSize: 20
      color: bat.appliedTextColor
      text: {
        if (UPower.displayDevice.state == UPowerDeviceState.Charging ||
            UPower.displayDevice.state == UPowerDeviceState.FullyCharged) {
          return "battery_android_frame_bolt"
        }
        let state = Math.ceil((charge/100) * 7)
        if (state == 7) {
          return "battery_android_frame_full"
        }
        return "battery_android_frame_" + state
      }
    }

    StyledLabel {
      font {
        bold: true
      }
      color: bat.appliedTextColor
      text: bat.charge + "%"
    }
  }

  ModuleButton {}
}
