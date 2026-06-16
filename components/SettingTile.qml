import QtQuick
import QtQuick.Layouts

StyledRect {
  id: tile
  Layout.fillWidth: true
  //Layout.fillHeight: true
  implicitHeight: 64

  property color defaultColor: theme.surface_container
  property color onColor: theme.secondary_container
  property color activeColor: theme.secondary
  property color textColor: theme.on_surface
  property color activeTextColor: theme.on_secondary_container
  property color activeIconColor: theme.on_secondary

  required property string icon
  required property string text

  color: on ? onColor : defaultColor

  property bool on: true

  signal toggle

  onToggle: {
    on = !on
  }


  StyledRect {
    anchors {
      top: parent.top
      left: parent.left
      bottom: parent.bottom
      margins: parent.height * 0.15
    }

    implicitWidth: parent.height * 0.7
    implicitHeight: parent.height * 0.7
    radius: 50

    color: tile.on ? tile.activeColor : tile.activeIconColor

    GoogleIcon {
      anchors.centerIn: parent

      font {
        bold: false
        pixelSize: 24
      }
      text: tile.icon
      color: tile.on ? tile.activeIconColor : tile.activeColor
    }

    ButtonArea {
      defColor: tile.on ? tile.activeColor : tile.activeIconColor
      hoverColor: tile.on ? tile.activeColor : tile.onColor

      onClicked: tile.toggle()
    }
  }

  StyledLabel {
    anchors {
      verticalCenter: parent.verticalCenter
      left: parent.left
      leftMargin: parent.height
    }
    width: parent.width - parent.height - 8
    font {
      bold: true
      pixelSize: 14
    }
    //color: tile.on ? tile.activeIconColor : tile.activeColor
    color: tile.on ? tile.activeTextColor : tile.textColor
    text: tile.text
  }
}
