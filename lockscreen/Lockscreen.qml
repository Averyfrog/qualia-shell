import Quickshell
import Quickshell.Widgets
import QtQuick
import QtQuick.Layouts
import QtQuick.Effects
import qs.components
import qs.widgets.weather

Rectangle { // Whole lockscreen
  anchors.fill: parent

  color: theme.shadow

  Image { // Lockscreen wallpaper!
    id: background
    anchors.fill: parent
    source: `/home/${user.name}/.cache/current_wallpaper`
    fillMode: Image.PreserveAspectCrop
    layer.enabled: true
    opacity: 0.8
    layer.effect: MultiEffect {
      blurEnabled: true
      blur: 1.0
      //contrast: -0.2
    }
  }

  SystemClock {
    id: time
    precision: SystemClock.Seconds
  }

  Rectangle {
    anchors {
      top: parent.top
      horizontalCenter: parent.horizontalCenter
      margins: 64
    }
    color: 'transparent'
    width: 800
    height: 800
    ColumnLayout {
      width: parent.width
      anchors.horizontalCenter: parent.horizontalCenter

      Rectangle {
        implicitWidth: parent.width
        implicitHeight: 32
        color: 'transparent'

        StyledLabel {
          id: dateLabel
          anchors.centerIn: parent
          text: Qt.formatDate(time.date, "ddd dd MMM")
          font {
            pixelSize: 32
          }
          color: theme.secondary_fixed
        }
      }

      Rectangle {
        implicitWidth: parent.width
        implicitHeight: 164
        color: 'transparent'

        StyledLabel {
          id: timeLabel
          anchors.centerIn: parent
          text: Qt.formatTime(time.date, "hh:mm")
          font {
            pixelSize: 128 + 32
            weight: 400
          }
          color: theme.primary_fixed

          horizontalAlignment: Text.AlignHCenter
        }
      }
    }
  }

  StyledRect { // Temporary until password input works
    id: closeButton
    anchors {
      top: parent.top
      topMargin: 8
      right: parent.right
      rightMargin: 8
    }

    width: 40
    height: width
    radius: 20

    MouseArea {
      anchors.fill: parent

      onClicked: lockRoot.unlocked();
    }

    GoogleIcon {
      anchors.centerIn: parent
      text: 'close'
      color: theme.error
      font.pixelSize: 24
    }
  }

  Rectangle {
    anchors {
      left: parent.left
      top: parent.top
      bottom: parent.bottom
      margins: 16
    }

    width: 500
    color: 'transparent'

    ColumnLayout {
      anchors {
        bottom: !settings.lockscreen.widgets.left.top ? parent.bottom : undefined
      }
      width: parent.width

      HourlyWeather {
        Layout.fillWidth: true
        implicitHeight: 170
      }
    }
  }
}
