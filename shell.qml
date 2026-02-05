import Quickshell
import Quickshell.Io
import QtQuick
import qs.components.menu

ShellRoot {
  id: root

  FileView {
    id: themeFile
    path: Qt.resolvedUrl("./theme-constellate.json")
    watchChanges: true
    onFileChanged: reload()
    blockLoading: true
  }

  property var colors: JSON.parse(themeFile.text())

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

    StyledMenu { 
      id: testMenu
      StyledMenuItem { text: 'Lock'; gIcon: 'lock'; hoverColor: colors.green }
      StyledMenuItem { text: 'Sleep'; gIcon: 'moon_stars'; hoverColor: colors.yellow; onClicked: sleep.running = true }
      Process { id: sleep; running: false; command: ["systemctl", "suspend" ] }
      StyledMenuItem { text: 'Log Out'; gIcon: 'logout'; hoverColor: colors.blue }
      StyledMenuItem { text: 'Power Off'; gIcon: 'power_settings_new'; color: colors.red; hoverColor: color }
      StyledMenuSeperator {}
        StyledMenu {
          title: 'More..'

          StyledMenuItem { text: 'New terminal Session'; gIcon: 'terminal'; hoverColor: colors.blue; onClicked: termExec.running = true }
          Process { id: termExec; running: false; command: ["hyprctl", "dispatch", "exec", "kitty"] }
          StyledMenuItem { text: 'Exit Quickshell'; gIcon: 'computer_cancel'; color: colors.red; hoverColor: color; onClicked: killQs.running = true }
          Process { id: killQs; running: false; command: ["kill", Quickshell.processId] }
        }
    }

    MouseArea {
      anchors.fill: parent
      acceptedButtons: Qt.LeftButton | Qt.RightButton
      onClicked: mouse => {
        if (mouse.button === Qt.RightButton) {
          testMenu.popup()
        }
      }
    }
  }
}
