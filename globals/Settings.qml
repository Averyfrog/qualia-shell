import Quickshell
import Quickshell.Io
import QtQuick

Scope {
  FileView {
    path: Qt.resolvedUrl("../settings.json")
    watchChanges: true
    onFileChanged: reload()
    blockLoading: true

    onAdapterUpdated: {
      console.log("setting changed!");
      writeAdapter()
    }

    JsonAdapter {
      id: settings

      property JsonObject general: JsonObject {
        property bool animations: true
        property real animationSpeed: 1
      }

      property JsonObject bar: JsonObject {
        property list<string> leftModules: [
          "Skyblock",
        ]

        property list<string> centerModules: [
          "Clock",
          "Music",
        ]

        property list<string> rightModules: [
          "Connections",
          "Battery",
        ]
      }
    }
  }
}
