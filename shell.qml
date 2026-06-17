//@ pragma DropExpensiveFonts

import Quickshell
import Quickshell.Io
import QtQuick
import qs.bar
import qs.desktop
import qs.globals

ShellRoot {
    id: root

    property string configDir: "/home/" + user.name + "/.config/qualia-shell"

    FileView {
        id: themeFile
        path: root.configDir + "/theme.json"
        watchChanges: true
        onFileChanged: reload()
        blockLoading: true
    }

    FileView {
      id: settingsFile
      path: root.configDir + "/settings.json"
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
          property bool animationsEnabled: true
          property real animationSpeed: 1
          property bool filledIcons: false

          property string font: ""

          property int rounding: 0
        }

        property JsonObject bar: JsonObject {

          property int side: 1

          property bool moduleShadows: false
          property list<int> moduleShadowOffset: [ 0, 0 ]

          property list<string> leftModules: [
            "CurrentApp",
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

        property JsonObject weather: JsonObject {
          property JsonObject location: JsonObject {
            property bool useCoords: true
            property JsonObject coordinates: JsonObject {
              property string latitude: ""
              property string longitude: ""
            }
          }
        }

        property JsonObject lockscreen: JsonObject {
          property JsonObject widgets: JsonObject {
            property JsonObject left: JsonObject {
              property bool top: true
              property list<string> widgets: []
            }
            property JsonObject right: JsonObject {
              property bool top: false
              property list<string> widgets: []
            }
          }
        }
      }
    }

    property bool settingsLoaded: settingsFile.loaded
    // MAKE SURE settings are loaded before changing them PLEASE 🙏🙏
    // it will reset ALL THE USER'S SETTINGS
    // dw reading from settings is fine, but may report incorrect values for
    // anything ran in the first couple secs

    Music {
      id: music
    }

    Weather {
      id: weather
    }

    Tasks {
      id: tasks
    }

    Desktop {}

    Bar {}

    property var theme: JSON.parse(themeFile.text())

    property var electData: reloadSkyblockData()

    function reloadSkyblockData() {
      var req = new XMLHttpRequest();
      req.open("GET", "https://api.hypixel.net/v2/resources/skyblock/election"); // No api key required.

      root.electData = {
        success: false
      }

      req.onreadystatechange = function() {

        if (req.readyState == 4) {
          root.electData = JSON.parse(req.responseText);

          console.log("Skyblock data reloaded!");
          //console.log(req.responseText);
          //console.log(electData.mayor.name);
        }
      }

      req.send()
      console.log("Reloading skyblock data...");
    }

    property var easingOvershoot: [ 0.38, 1.21, 0.22, 1, 1 ,1 ]
    property var easingBezier: [ 0.38, 1, 0.22, 1, 1 ,1 ]

    property var user
    Process {
        id: usrGet
        running: true
        command: ["sh", "-c", "userdbctl user $USER -j"]
        stdout: StdioCollector {
          onStreamFinished: {
            var data = JSON.parse(this.text);

            // all this JUST to get the pfp i couldnt think of a better way x.x
            let pfpPaths = [
              data.homeDirectory + "/.face",
              data.homeDirectory + "/.face.icon",
              "/var/lib/AccountsService/icons/ + user.name"
            ];

            var returnData = {
              name: data.userName,
              prettyName: data.realName
            }
            root.user = returnData
          }
        }
    }
}
