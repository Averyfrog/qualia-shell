import Quickshell
import QtQuick
import QtQuick.Layouts
import QtQuick.Effects
import qs.bar.modules
import qs.bar.dropdowns
import qs.components

PanelWindow {
  id: section

  mask: Region { item: barRect }

  anchors {
    top: true
    left: barPos == "left"
    right: barPos == "right"
    bottom: true
  }

  margins {
    top: 8
    left: 8
    right: 8
    bottom: 8
  }

  color: 'transparent'
  exclusionMode: ExclusionMode.Ignore

  implicitWidth: barSpacer.width * 0.6

  required property var barPos

  required property list<string> modules

  onModulesChanged: {
    barRect.dropdownChoice = undefined
    closeDropdown.start()
  }

  RoundCorner {
    anchors {
      left: section.barPos == "left" ? parent.left : undefined
      right: section.barPos == "right" ? parent.right : undefined
      top: parent.top
    }
    corner: section.barPos == "left" ? 4 : 1
    radius: section.barPos == "center" ? 0 : 16
    color: theme.background
  }

  Rectangle {
    id: barRect

    opacity: 0

    anchors {
      top: parent.top
      left: barPos == "left" ? parent.left : undefined
      right: barPos == "right" ? parent.right : undefined
      horizontalCenter: barPos == "center" ? parent.horizontalCenter : undefined
    }

    RoundCorner {
      anchors {
        left: barPos == "left" ? parent.left : undefined
        right: barPos == "right" ? parent.right : undefined
        top: parent.bottom
      }
      corner: barPos == "left" ? 4 : 1
      radius: barPos == "center" ? 0 : 16
      color: theme.background
    }

    RoundCorner {
      anchors {
        left: barRect.right
        top: parent.top
      }
      corner: 4
      radius: 16
      color: theme.background
    }

    RoundCorner {
      anchors {
        right: barRect.left
        top: parent.top
      }
      corner: 1
      radius: 16
      color: theme.background
    }

    Component {
      id: skyblockDropdown
      SkyblockDropdown {}
    }
    Component {
      id: batteryDropdown
      BatteryDropdown {}
    }
    Component {
      id: connectionsDropdown
      ConnectionsDropdown {}
    }
    Component {
      id: musicDropdown
      MusicDropdown {}
    }
    Component {
      id: clockDropdown
      ClockDropdown {}
    }

    Component {
      id: weatherDropdown
      WeatherDropdown {}
    }

    Loader {
      id: dropdownLoader
      opacity: 0
      property bool vertical: barPos != "center"
      anchors.horizontalCenter: parent.horizontalCenter

      sourceComponent: null // Avz do NOT set this to null. you WILL regret it.
    }

    property var dropdownChoice
    property var dropdownOpen: false

    SequentialAnimation {
      id: openDropdown

      PropertyAnimation {
        target: dropdownLoader
        property: "opacity"
        to: 0
        duration: 0
      }
      PropertyAction {
        target: dropdownLoader
        property: "sourceComponent"
        value: barRect.dropdownChoice
      }
      ParallelAnimation {
        PropertyAnimation {
          target: barRect
          property: "implicitWidth"
          to: Math.max(dropdownLoader.item ? dropdownLoader.item.implicitWidth : leftModules.implicitWidth + 8, leftModules.implicitWidth + 8)
          duration: 250 * settings.general.animationSpeed
          easing.bezierCurve: easingOvershoot
        }
        PropertyAnimation {
          target: barRect
          property: "implicitHeight"
          to: Math.max(dropdownLoader.item ? dropdownLoader.item.implicitHeight + 40 : 40, 40)
          duration: 250 * settings.general.animationSpeed
          easing.bezierCurve: easingOvershoot
        }
      }
      PropertyAction {
        target: barRect
        property: "dropdownOpen"
        value: true
      }
      PropertyAnimation {
        target: dropdownLoader
        property: "opacity"
        to: 1
        duration: 100 * settings.general.animationSpeed
      }
    }

    SequentialAnimation {
      id: closeDropdown

      PropertyAnimation {
        target: dropdownLoader
        property: "opacity"
        to: 0
        duration: 100 * settings.general.animationSpeed
      }
      PropertyAction {
        target: barRect
        property: "dropdownOpen"
        value: false
      }
      PropertyAction {
        target: dropdownLoader
        property: "sourceComponent"
        value: undefined
      }
      ParallelAnimation {
        PropertyAnimation {
          target: barRect
          property: "implicitWidth"
          to: leftModules.implicitWidth + 8
          duration: 250 * settings.general.animationSpeed
          easing.bezierCurve: easingBezier
        }
        PropertyAnimation {
          target: barRect
          property: "implicitHeight"
          to: 40
          duration: 250 * settings.general.animationSpeed
          easing.bezierCurve: easingBezier
        }
      }
    }

    Binding on implicitWidth {
      when: (!openDropdown.running && dropdownLoader.item != null)
      value: Math.max(dropdownLoader.item != null ? dropdownLoader.item.implicitWidth : leftModules.implicitWidth + 8, leftModules.implicitWidth + 8)
    }
    Binding on implicitWidth {
      when: (!dropdownLoader.item) && !closeDropdown.running
      value: leftModules.implicitWidth + 8
    }


    bottomRightRadius: barPos != "right" ? 16 : 0
    bottomLeftRadius: barPos != "left" ? 16 : 0
    color: barColor
    antialiasing: false

    implicitHeight: 40

    RowLayout {
      id: leftModules
      anchors {
        left: section.barPos == "left" ? parent.left : undefined
        right: section.barPos == "right" ? parent.right : undefined
        top: parent.top
        horizontalCenter: section.barPos == "center" ? parent.horizontalCenter : undefined

        margins: 4
      }

      implicitHeight: 32

      Repeater {
        model: section.modules

        delegate: Loader {
          Component {
            id: batteryModule
            BatteryModule {}
          }

          Component {
            id: clockModule
            ClockModule {}
          }

          Component {
            id: connectionsModule
            ConnectionsModule {}
          }

          Component {
            id: musicModule
            MusicModule {}
          }

          Component {
            id: skyblockModule
            SkyblockModule {}
          }

          Component {
            id: weatherModule
            WeatherModule {}
          }

          Component {
            id: currentAppModule
            CurrentAppModule {}
          }

          sourceComponent: {
            switch(modelData) {
              case "Battery": return batteryModule
              case "Clock": return clockModule
              case "Connections": return connectionsModule
              case "Music": return musicModule
              case "Skyblock": return skyblockModule
              case "Weather": return weatherModule
              case "CurrentApp": return currentAppModule
              default: return batteryModule
            }

          }

          MultiEffect {
            source: parent.item
            anchors.fill: parent.item

            shadowEnabled: settings.bar.moduleShadows
            shadowBlur: 0.2
            shadowOpacity: theme.mode == "dark" ? 1 : 0.2
            shadowHorizontalOffset: settings.bar.moduleShadowOffset[0]
            shadowVerticalOffset: settings.bar.moduleShadowOffset[1]
          }
        }
      }
    }
  }

  MultiEffect {
    source: barRect
    anchors.fill: barRect

    visible: section.modules.length > 0

    shadowEnabled: true
    shadowBlur: 0.8
  }
}
