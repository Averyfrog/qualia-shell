import Quickshell
import QtQuick
import QtQuick.Effects

Variants {
  model: Quickshell.screens
  delegate: Scope {
    id: bar

    property color barColor: theme.surface

    required property var modelData


    ScreenEdges { screen: bar.modelData }

    PanelWindow {
      id: barSpacer

      screen: bar.modelData

      mask: Region { item: topEdge }

      anchors {
        top: true
        left: true
        right: true
      }
      color: 'transparent'

      implicitHeight: leftSection.modules.length == 0 && rightSection.modules.length == 0 && centerSection.modules.length == 0 ? 8 : 48

      MultiEffect {
        source: topEdge
        anchors.fill: topEdge
        shadowEnabled: true
      }

      Rectangle {
        id: topEdge
        anchors {
          top: parent.top
          left: parent.left
          right: parent.right
        }
        implicitHeight: 8
        color: theme.surface
      }


    }

    BarSection {
      id: leftSection
      barPos: "left"
      screen: bar.modelData

      modules: settings.bar.leftModules
    }

    BarSection {
      id: centerSection
      barPos: "center"
      screen: bar.modelData

      modules: settings.bar.centerModules

    }

    BarSection {
      id: rightSection
      barPos: "right"
      screen: bar.modelData

      modules: settings.bar.rightModules
    }
  }
}
