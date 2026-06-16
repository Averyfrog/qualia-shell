import Quickshell
import QtQuick
import QtQuick.Effects
import qs.components

// Get ready for the messiest code of the project!!

Scope {
  id: scope

  required property var screen

  PanelWindow {
    // Left
    screen: scope.screen
    aboveWindows: true
    anchors {
      top: true
      left: true
      bottom: true
    }
    implicitWidth: 16

    color: 'transparent'

    Rectangle {
      id: leftEdge
      anchors {
        top: parent.top
        left: parent.left
        bottom: parent.bottom
      }
      color: theme.surface
      implicitWidth: 8
    }

    MultiEffect {
      source: leftEdge
      anchors.fill: leftEdge
      shadowEnabled: true
      shadowBlur: 0.8
    }

    Rectangle {
      //fixes gap
      anchors {
        top: parent.top
        right: parent.right
        left: parent.left
      }
      implicitHeight: 8
      color: theme.surface
    }
    Rectangle {
      //fixes another gap. this thing is held together with sellotape
      anchors {
        bottom: parent.bottom
        right: parent.right
        left: parent.left
      }
      implicitHeight: 8
      color: theme.surface
    }
  }

  PanelWindow {
    // Right
    screen: scope.screen
    aboveWindows: true
    anchors {
      top: true
      right: true
      bottom: true
    }
    implicitWidth: 16

    color: 'transparent'

    Rectangle {
      id: rightEdge
      anchors {
        top: parent.top
        right: parent.right
        bottom: parent.bottom
      }
      color: theme.surface
      implicitWidth: 8
    }

    MultiEffect {
      source: rightEdge
      anchors.fill: rightEdge
      shadowEnabled: true
      shadowBlur: 0.8
    }

    Rectangle {
      //fixes more gap
      anchors {
        top: parent.top
        right: parent.right
        left: parent.left
      }
      implicitHeight: 8
      color: theme.surface
    }

    Rectangle {
      //fixes yet ANOTHER gap. this thing is full of holes jesus
      anchors {
        bottom: parent.bottom
        right: parent.right
        left: parent.left
      }
      implicitHeight: 8
      color: theme.surface
    }
  }

  PanelWindow {
    // Right
    screen: scope.screen
    aboveWindows: true
    anchors {
      left: true
      right: true
      bottom: true
    }
    implicitHeight: 16

    color: 'transparent'

    Rectangle {
      id: bottomEdge
      anchors {
        left: parent.left
        right: parent.right
        bottom: parent.bottom
      }
      color: theme.surface
      implicitHeight: 8
    }

    MultiEffect {
      source: bottomEdge
      anchors.fill: bottomEdge
      shadowEnabled: true
      shadowBlur: 0.8
    }
  }

  PanelWindow {
    //Left corner
    screen: scope.screen
    anchors {
      bottom: true
      left: true
    }

    exclusionMode: ExclusionMode.Ignore

    margins {
      bottom: 8
      left: 8
    }

    color: 'transparent'

    implicitWidth: 48
    implicitHeight: 48

    mask: Region { item: leftCorner }

    RoundCorner {
      id: leftCorner
      anchors {
        bottom: parent.bottom
        left: parent.left
      }

      corner: 3
      radius: 32
      color: theme.background
    }

    MultiEffect {
      source: leftCorner
      anchors.fill: leftCorner
      shadowEnabled: true
      shadowBlur: 0.8
      rotation: 270
    }
  }

  PanelWindow {
    //Right corner
    screen: scope.screen
    anchors {
      bottom: true
      right: true
    }

    exclusionMode: ExclusionMode.Ignore

    margins {
      bottom: 8
      right: 8
    }

    color: 'transparent'

    implicitWidth: 48
    implicitHeight: 48

    mask: Region { item: rightCorner }

    RoundCorner {
      anchors {
        bottom: parent.bottom
        right: parent.right
      }

      id: rightCorner
      corner: 2
      radius: 32
      color: theme.background

    }

    MultiEffect {
      source: rightCorner
      anchors.fill: rightCorner
      shadowEnabled: true
      shadowBlur: 0.8
      rotation: 180
    }
  }
}
