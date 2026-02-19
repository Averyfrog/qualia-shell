import Quickshell
import QtQuick
import QtQuick.Controls

PanelWindow {
  anchors {
    top: true
    left: true
  }

  implicitWidth: 200
  implicitHeight: 200

  property string mayorName: "Loading.."

  Component.onCompleted: {
    var req = new XMLHttpRequest();
    req.open("GET", "https://api.hypixel.net/v2/resources/skyblock/election"); // No api key required.

    req.onreadystatechange = function() {
      var res = JSON.parse(req.responseText);
      mayorName = (res.success && res.mayor) ? res.mayor.name : "Error fetching mayor";
      console.log(mayorName)
    }

    req.send()
  }
}
