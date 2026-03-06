import Quickshell
import Quickshell.Widgets
import QtQuick
import QtQuick.Layouts
import QtQuick.Effects
import qs.components

Rectangle { // Whole lockscreen
  anchors.fill: parent

  color: theme.surface

  Image { // Lockscreen wallpaper!
    id: background
    anchors.fill: parent
    source: `/home/${user}/.cache/current_wallpaper`
    fillMode: Image.PreserveAspectCrop
    layer.enabled: true
    opacity: 0.7
    layer.effect: MultiEffect {
      blurEnabled: true
      blur: 1.0
      //contrast: -0.2
    }
  }

  Rectangle {
    id: center
    color: 'transparent'
    implicitWidth: 1000
    implicitHeight: 800
    anchors.centerIn: parent
    ColumnLayout {
      anchors {
        horizontalCenter: parent.horizontalCenter
      }
      Rectangle {
        color: 'transparent'
        Layout.fillWidth: true
        implicitHeight: 30
        StyledLabel {
          anchors.centerIn: parent
          width: 100
          text: `Welcome back **${user}**! The time is currently:`
          font {
            pixelSize: 24
            bold: false
          }
          horizontalAlignment: Text.AlignHCenter
          elide: Text.ElideNone
        }
      }
      StyledLabel {
        Layout.alignment: Qt.AlignCenter
        SystemClock {
          id: time
          precision: SystemClock.Seconds
        }
        text: Qt.formatDateTime(time.date, "hh:mm AP")
        font {
          pixelSize: 120
          bold: true
        }
      }
      StyledRect {
        id: imgContainer
        color: colors.base00
        Layout.alignment: Qt.AlignHCenter
        implicitWidth: 200
        implicitHeight: width
        radius: 200
        Rectangle {
          anchors.centerIn: parent
          width: imgContainer.width - 16
          height: width
          radius: parent.radius
          ClippingWrapperRectangle { // Rounds the user pfp:W
            radius: parent.radius - 8
            width: imgContainer.width - 16
            height: width
            Image { //User pfp!!
              fillMode: Image.PreserveAspectCrop
              source: "/var/lib/AccountsService/icons/" + user
            }
          }
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
}
