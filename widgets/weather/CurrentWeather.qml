import Quickshell
import QtQuick
import QtQuick.Layouts
import qs.components

StyledRect {
  id: root
  Layout.fillWidth: true
  implicitHeight: parent.height * 0.25

  SystemClock {
    id: time
    precision: SystemClock.Seconds
  }

  property var wmoInfo: weather.getWmoInfo(time.hours, String(weather.data.current.weather_code))

  property string timeName: getTimeName(time.hours)

  function getTimeName(hour: int) : string {
    if (5 <= hour && hour < 12) return "Morning"
    if (5 <= hour && hour < 19) return "Afternoon"
    if (5 <= hour && hour < 22) return "Evening"
    return "Night"
  }


  StyledLabel {
    anchors {
      top: parent.top
      left: parent.right
      margins: 12
      leftMargin: -180
    }
    font {
      bold: false
      pixelSize: 26
    }
    color: theme.tertiary
    text: Qt.formatDateTime(time.date, "ddd hh:mm:ss")
  }

  StyledLabel {
    anchors {
      top: parent.top
      left: parent.left
      margins: 8
    }

    font {
      pixelSize: 20
      bold: true
    }
    text: `Good ${root.timeName}, ${user.prettyName}. `

    StyledLabel {
      anchors {
        left: parent.left
        top: parent.bottom
      }
      font.pixelSize: 16
      text: "The weather is currently.."
    }
  }

  StyledRect {
    anchors.fill: parent
    anchors.margins: 8
    anchors.topMargin: 64
    color: theme.surface_container_low

    GoogleIcon {
      id: weatherIcon
      anchors {
        left: parent.left
        verticalCenter: parent.verticalCenter
        leftMargin: 16
      }
      font {
        pixelSize: 64
        variableAxes: {
          "wght": 300,
          "FILL": settings.general.filledIcons
        }
      }
      text: root.wmoInfo.icon
      color: theme.tertiary
      opacity: theme.mode == "dark" ? 0.7 : 0.9
    }
    ColumnLayout {
      anchors {
        top: parent.top
        left: weatherIcon.right
        margins: 8
      }
      spacing: 0

      StyledLabel {
        font.pixelSize: 32
        text: weather.data.current.temperature_2m + '°c'
      }

      StyledLabel {
        font.pixelSize: 16
        opacity: 0.8
        text: 'Feels like: ' + weather.data.current.apparent_temperature + '°c'
      }

      StyledLabel {
        font.pixelSize: 16
        text: root.wmoInfo.label
      }
    }
  }
}
