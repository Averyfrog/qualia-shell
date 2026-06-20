import Quickshell
import Quickshell.Io
import Quickshell.Networking
import Quickshell.Bluetooth
import Quickshell.Services.Pipewire
import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import Qt.labs.folderlistmodel
import qs.components
import qs.notifications

Rectangle {
  id: con

  property bool vertical: parent.vertical
  implicitWidth: vertical ? 450 : 900
  implicitHeight: vertical ? section.height * 0.8 : 500

  property var connectedDevices: Networking.devices.values.filter(n => n.connected)
  property var networkDevice: connectedDevices[0]
  property var wifiNetwork: networkDevice ? networkDevice.networks.values.filter(n => n.connected)[0] : null

  property BluetoothAdapter bt: Bluetooth.defaultAdapter
  property var connectedBtDevices: bt.devices.values.filter(n => n.connected)

  anchors {
    top: parent.top
    margins: 40
  }

  color: 'transparent'

  GridLayout {
    anchors.fill: parent
    anchors.margins: 8

    columns: con.vertical ? 1 : 2

    StyledRect {
      implicitWidth: parent.width * (con.vertical ? 1 : 0.4)
      implicitHeight: con.vertical ? settingsTiles.height + 8 : parent.height
      color: theme.surface_container_low



      ColumnLayout {
        id: settingsTiles
        implicitWidth: parent.width

        spacing: 0

        GridLayout {
          Layout.alignment: Qt.Horizontal
          Layout.margins: 8
          implicitWidth: parent.width - 16
          implicitHeight: implicitWidth * 0.3

          columns: 2

          SettingTile {
            id: wifi
            icon: on ? "signal_wifi_4_bar" : "signal_wifi_0_bar"
            text: con.wifiNetwork ? con.wifiNetwork.name : "Wifi"

            on: Networking.wifiEnabled

            onToggle: {
              Networking.wifiEnabled = !Networking.wifiEnabled
            }
          }
          SettingTile {
            id: bluetooth
            icon: on ? (con.connectedBtDevices.length > 0 ? "bluetooth_connected" : "bluetooth") : "bluetooth_disabled"
            text: con.connectedBtDevices.length > 0 ? con.connectedBtDevices[0].name :"Bluetooth"
            on: con.bt.enabled
            onToggle: {
              con.bt.enabled = !con.bt.enabled
            }
          }
          SettingTile {
            id: dnd
            icon: on ? "do_not_disturb_on" : "do_not_disturb_off"
            text: on ? "Do Not Disturb" : "Notifications"

            on: false
          }
          SettingTile {
            id: darkMode
            icon: on ? "light_mode" : "moon_stars"
            text: on ? "Light Mode" : "Dark Mode"

            on: theme.mode == "light"

            onToggle: {
              //if( evilTile.on )Quickshell.execDetached(["matugen", "color", "hex", "#FF0000", "-t", "scheme-vibrant", "-m", darkMode.on ? "light" : "dark" ])
              themeSetter.running = true
            }

            Process {
              id: themeSetter
              command: [ "sh", "-c", "./scripts/matugen.sh " + (darkMode.on ? "scheme-tonal-spot " : "scheme-tonal-spot " ) + (darkMode.on ? "light" : "dark") ]
            }
          }
          /*
          SettingTile {
            id: evilTile
            icon: on ? "skull" : "sunny"
            text: on ? "I am Evil" : "I am nice"
            on: theme.source_color == '#ff0000'
            onToggle: {
              console.log(on ? "I am Evil" : "I am Nice")
              if( on )Quickshell.execDetached(["matugen", "color", "hex", "#FF0000", "-t", "scheme-vibrant", "-m", darkMode.on ? "light" : "dark" ])
              else {
                themeSetter.running = true
              }
            }
            activeColor: theme.error
            onColor: theme.error_container
          }
          */
        }
        Repeater {

          model: FolderListModel {
            folder: "file:/sys/class/backlight/"
          }

          delegate: StyledSlider {
            id: brightnessSlider

            Layout.alignment: Qt.AlignHCenter
            implicitWidth: parent.width - 32
            implicitHeight: 40

            gIcon: "brightness_" + Math.max(Math.ceil(brightness/max * 4 + 3), 4)

            Behavior on brightness {
              enabled: !brightnessSlider.pressed
              PropertyAnimation {
                duration: 100
              }
            }

            behindColor: theme.surface_container_low

            property int brightness
            property int max

            value: brightness
            to: max

            required property string fileName

            //onBrightnessChanged: console.log(brightness + " " + max)

            onMoved: {
              setter.running = true
            }

            FileView {
              // Gets actively updated current brightness
              id: backlight
              path: "/sys/class/backlight/" + brightnessSlider.fileName + "/brightness"
              watchChanges: true
              onFileChanged: this.reload()
              onLoaded: brightnessSlider.brightness = text()
            }

            FileView {
              // Gets max brightness once
              path: "/sys/class/backlight/" + brightnessSlider.fileName + "/max_brightness"
              onLoaded: brightnessSlider.max = text()
            }

            Process {
              // Set brightness
              id: setter
              command: [ "brightnessctl", "-d", brightnessSlider.fileName, "s", brightnessSlider.value ]
            }
          }
        }

        StyledSlider {
          id: masterVolumeSlider
          Layout.alignment: Qt.AlignHCenter
          implicitWidth: parent.width - 32
          implicitHeight: 40

          foregroundColor: theme.tertiary

          Behavior on value {
            enabled: !masterVolumeSlider.pressed
            PropertyAnimation {
              duration: 100
            }
          }

          gIcon: {
            let volume = Pipewire.defaultAudioSink.audio.volume;

            if (volume == 0) return "volume_off";
            if (volume < 0.3) return "volume_mute";
            if (volume < 0.6) return "volume_down";
            return "volume_up"
          }

          PwObjectTracker {
            objects: [ Pipewire.defaultAudioSink ]
          }

          value: Pipewire.defaultAudioSink ? Pipewire.defaultAudioSink.audio.volume : 0

          onMoved: {
            Pipewire.defaultAudioSink.audio.volume = value
          }
        }

      }

    }

    StyledRect {
      Layout.fillWidth: true
      Layout.fillHeight: true
      color: theme.surface_container_lowest

      Flickable {
        anchors.fill: parent
        anchors.margins: 8
        clip: true

        contentWidth: width
        contentHeight: notifColumn.height

        ColumnLayout {
          id: notifColumn
          width: parent.width
          Repeater {
            model: notifServer.storedNotifs

            delegate: Notif { stored: true }
          }

        }
      }
    }
  }
}
