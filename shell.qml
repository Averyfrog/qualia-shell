import Quickshell
import Quickshell.Io
import Quickshell.Hyprland
import QtQuick
import qs.components.menu
import qs.lockscreen
import qs.skyblock

ShellRoot {
    id: root

    FileView {
        id: themeFile
        path: Qt.resolvedUrl("./theme.json")
        watchChanges: true
        onFileChanged: reload()
        blockLoading: true
    }

    property var theme: JSON.parse(themeFile.text())

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

        SbInfo {}

        StyledMenu {
            id: testMenu
            StyledMenuItem {
                text: 'Lock'
                gIcon: 'lock'
                onClicked: lock.lock()
            }
            StyledMenuItem {
                text: 'Sleep'
                gIcon: 'moon_stars'
                hoverColor: theme.secondary
                onClicked: Hyprland.dispatch("exec systemctl suspend")
            }
            StyledMenuItem {
                text: 'Log Out'
                gIcon: 'logout'
                hoverColor: theme.tertiary
                onClicked: Hyprland.dispatch("exec exit")
            }
            StyledMenuItem {
                text: 'Restart'
                gIcon: 'restart_alt'
                hoverColor: theme.error
                onClicked: Hyprland.dispatch("exec reboot")
            }
            StyledMenuItem {
                text: 'Power Off'
                gIcon: 'power_settings_new'
                hoverColor: theme.error
                onClicked: Hyprland.dispatch("exec poweroff")
            }

            StyledMenuSeperator {}
            StyledMenu {
                title: 'More..'

                StyledMenuItem {
                    text: 'New terminal Session'
                    gIcon: 'terminal'
                    onClicked: Hyprland.dispatch("exec kitty")
                }
                StyledMenuItem {
                    text: 'Exit Quickshell'
                    gIcon: 'computer_cancel'
                    hoverColor: theme.error
                    onClicked: Qt.quit()
                }
            }
        }

        MouseArea {
            anchors.fill: parent
            acceptedButtons: Qt.LeftButton | Qt.RightButton
            onClicked: mouse => {
                if (mouse.button === Qt.RightButton) {
                    testMenu.popup();
                }
            }
        }
    }

    property string user
    Process {
        id: usrGet
        running: true
        command: ["whoami"]
        stdout: StdioCollector {
            onStreamFinished: root.user = this.text.split('\n')[0]
        }
    }
}
