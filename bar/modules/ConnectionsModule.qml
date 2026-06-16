import Quickshell.Bluetooth
import Quickshell.Networking
import QtQuick
import qs.components

Module {
  id: con

  property var connectedDevices: Networking.devices.values.filter(n => n.connected)
  property var networkDevice: connectedDevices[0]
  property var wifiNetwork: networkDevice ? networkDevice.networks.values.filter(n => n.connected)[0] : null

  property BluetoothAdapter bt: Bluetooth.defaultAdapter
  property var connectedBtDevices: bt ? bt.devices.values.filter(n => n.connected) : undefined

  property list<string> wifiSymbols: [
    "signal_wifi_0_bar",
    "network_wifi_1_bar",
    "network_wifi_2_bar",
    "network_wifi_3_bar",
    "signal_wifi_4_bar"
  ]

  defaultColor: theme.on_secondary
  hoverColor: theme.secondary_container
  activeColor: theme.secondary
  textColor: theme.secondary
  activeTextColor: theme.on_secondary
  dropdownItem: connectionsDropdown

  ModuleRow {
    GoogleIcon {
      id: wifiIcon
      text: {
        if (!Networking.wifiEnabled) {
          return "signal_wifi_off"
        }
        if (!con.networkDevice) {
          return "wifi_add"
        }
        switch (con.networkDevice.state) {
          case ConnectionState.Connected:
            return con.wifiNetwork ? con.wifiSymbols[Math.round(con.wifiNetwork.signalStrength * 4)] : "signal_wifi_statusbar_not_connected";
          default:
            return "signal_wifi_bad"
        }

      }
      color: con.appliedTextColor
    }
    GoogleIcon {
      id: bluetoothIcon
      text: Bluetooth.defaultAdapter && Bluetooth.defaultAdapter.state == BluetoothAdapterState.Enabled ? (connectedBtDevices.length > 0 ? "bluetooth_connected" : "bluetooth") : "bluetooth_disabled"
      color: con.appliedTextColor
    }
    GoogleIcon {
      id: notifIcon
      text: "notifications"
      color: con.appliedTextColor
    }
  }

  ModuleButton {}
}
