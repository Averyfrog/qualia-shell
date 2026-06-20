import Quickshell
import Quickshell.Wayland
import QtQuick
import QtQuick.Layouts
import QtQuick.Effects

Scope {
  PanelWindow {
    id: notifPanel

    width: 440
    height: 800

    WlrLayershell.layer: WlrLayer.Overlay
    mask: Region { item: notifColumn }
    color: 'transparent'

    anchors {
      bottom: true
      right: true
    }

    ColumnLayout {
      id: notifColumn
      width: 420
      anchors.bottom: parent.bottom
      anchors.horizontalCenter: parent.horizontalCenter
      anchors.margins: 10

      Repeater {
        model: notifServer.shownNotifs

        delegate: Notif {}
      }

      onHeightChanged: {
        if (height > parent.height * 0.8) {
          children[0].store()
        }
      }
    }

    MultiEffect {
      source: notifColumn
      anchors.fill: notifColumn

      shadowEnabled: true
      shadowBlur: 0.6
      shadowOpacity: 0.7
    }
  }
}
