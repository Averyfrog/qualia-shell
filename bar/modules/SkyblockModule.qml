import QtQuick
import qs.components
import qs.components.menu
import qs.widgets.skyblock

Module {
  id: module

  //defaultColor: theme.on_primary
  //hoverColor: theme.primary_container
  //activeColor: theme.primary
  //textColor: theme.primary
  //activeTextColor: theme.on_primary
  dropdownItem: skyblockDropdown

  ModuleRow {
    McFace {
      size: 16
      face: electData.success ? electData.mayor.key : ""
    }
    StyledLabel {
      text: electData.success ? electData.mayor.name : "Skyblock"
      //color: dropdownLoader.sourceComponent == skyblock && dropdownLoader.opacity == 1 ? theme.on_primary : theme.on_surface
      color: module.appliedTextColor
    }
  }
  ModuleButton {
    onClicked: mouse => {
      if (mouse.button === Qt.RightButton) {
        sbContext.popup()
      }
    }
  }

  StyledMenu {
    id: sbContext
    StyledMenuItem {
      text: "Reload Election Data"
      gIcon: "autorenew"
      onClicked: {
        reloadSkyblockData()
      }
    }
  }
}
