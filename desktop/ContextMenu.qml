import Quickshell.Hyprland
import QtQuick
import qs.components.menu

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
