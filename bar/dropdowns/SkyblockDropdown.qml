import Quickshell
import Quickshell.Io
import QtQuick
import QtQuick.Layouts
import qs.components
import qs.widgets.skyblock

Rectangle {
  id: sb

  anchors {
    top: parent.top
    margins: 40
  }

  //color: theme.surface
  color: 'transparent'

  property bool vertical: parent.vertical

  //minimumSize: vertical ? Qt.size(400, 800) : Qt.size(800, 400)
  //maximumSize: vertical ? Qt.size(400, 800) : Qt.size(800, 400)
  implicitWidth: vertical ? 400 : 800
  implicitHeight: vertical ? 800 : 400


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

  GridLayout {
    anchors.fill: parent
    anchors.margins: sb.spacing
    rowSpacing: sb.spacing
    columnSpacing: sb.spacing
    columns: sb.vertical ? 1 : 2

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
        SbPerks { mayor: electData.success ? sb.viewedMayor : null }
      }
    }
  }
}
