import Quickshell
import Quickshell.Io
import QtQuick
import QtQuick.Layouts
import qs.components

FloatingWindow {
  id: sb

  color: theme.surface

  //anchors {
  //  top: true
  //}

  minimumSize: Qt.size(800, 400)
  maximumSize: Qt.size(800, 400)
  //implicitWidth: 800
  //implicitHeight: 400

  FileView {
      id: electionTestData
      path: Qt.resolvedUrl("./testdata.json")
      watchChanges: true
      onFileChanged: reload()
      blockLoading: true
  }

  property var electData//: JSON.parse(electionTestData.text())

  Component.onCompleted: {
    var req = new XMLHttpRequest();
    req.open("GET", "https://api.hypixel.net/v2/resources/skyblock/election"); // No api key required.

    req.onreadystatechange = function() {
      electData = JSON.parse(req.responseText);
      console.log(req.responseText);
      console.log(electData.mayor.name);
    }

    req.send()
    skyblockTime()
  }

  property list<string> months: [
    "Early Spring", "Spring", "Late Spring",
    "Early Summer", "Summer", "Late Summer",
    "Early Autumn", "Autumn", "Late Autumn",
    "Early Winter", "Winter", "Late Winter"
  ]

  property var sbTime: skyblockTime()

  Timer {
    interval: 833
    running: true
    repeat: true
    onTriggered: sb.sbTime = sb.skyblockTime()
  }

  function skyblockTime() {
    const EPOCH = 1560275700000
    const MINUTE = 833.333333333
    const MONTH_LENGTH = 31

    let now = Date.now()
    let totalMins = Math.floor((now - EPOCH) / MINUTE)

    let minute = totalMins % 60;
    let hour = Math.floor(totalMins / 60) % 24

    let totalDays = Math.floor(totalMins / (60 * 24))
    let day = (totalDays % MONTH_LENGTH) + 1

    let month = Math.floor(totalDays / MONTH_LENGTH) % 12 + 1
    let year = Math.floor(totalDays / (MONTH_LENGTH * 12)) + 1

    let totalDaysToMonth = totalDays - (totalDays % 31)

    return {
      year: year,
      month: month,
      day: day,
      hour: hour,
      minute: minute,
      daysToMonthStart: totalDaysToMonth,
      totalDays: totalDays
    }
  }

  function mcToMarkdown(input) {
    let output = input.replace(/§./g, "");
    return output;
  }

  property var spacing: 8

  property var viewedMayor: electData.mayor

  RowLayout {
    anchors.fill: parent
    anchors.margins: sb.spacing
    spacing: sb.spacing

    SbCalendar {}

    Rectangle {
      Layout.fillHeight: true
      Layout.fillWidth: true
      color: 'transparent'

      ColumnLayout {
        anchors.fill: parent
        spacing: sb.spacing

        Rectangle {
          Layout.fillWidth: true
          implicitHeight: parent.height * 0.4
          color: 'transparent'

          RowLayout {
            anchors.fill: parent
            spacing: sb.spacing

            SbMayorInfo {}
            SbElectionInfo {}
          }
        }
        SbPerks { mayor: sb.viewedMayor }
      }
    }
  }
}
