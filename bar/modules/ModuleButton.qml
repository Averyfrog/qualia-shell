import QtQuick
import qs.components

ButtonArea {
  acceptedButtons: Qt.LeftButton | Qt.RightButton
  onClicked: mouse => {
    if (mouse.button === Qt.LeftButton) {
      if (barRect.dropdownChoice != parent.dropdownItem && !closeDropdown.running && !openDropdown.running) {
        barRect.dropdownChoice = parent.dropdownItem
        openDropdown.start()
      }
      else if (!openDropdown.running && !closeDropdown.running) {
        barRect.dropdownChoice = undefined
        closeDropdown.start()
      }
    }
  }

  defColor: parent.active ? parent.activeColor : parent.defaultColor
  hoverColor: parent.active ? parent.activeColor : parent.hoverColor
}
