import Quickshell
import QtQuick
import qs.lockscreen

PanelWindow {
    anchors {
        top: true
        left: true
        bottom: true
        right: true
    }

    aboveWindows: false
    exclusionMode: ExclusionMode.Ignore

    color: 'transparent'

    Locker {
        id: lock
    }

    ContextMenu {
      id: cMenu
    }

    Rectangle {
      // Stupid 'evil mode' thing.
      anchors.fill: parent
      color: theme.source_color
      opacity: theme.source_color == "#ff0000" ? 0.3 : 0
    }

    MouseArea {
        anchors.fill: parent
        acceptedButtons: Qt.LeftButton | Qt.RightButton
        onClicked: mouse => {
            if (mouse.button === Qt.RightButton) {
                cMenu.popup();
            }
        }
    }
}
