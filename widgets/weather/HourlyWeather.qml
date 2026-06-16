import Quickshell
import Quickshell.Widgets
import QtQuick
import QtQuick.Layouts
import qs.components

Rectangle {
  id: root
  color: background ? theme.surface_container : 'transparent'
  radius: 16

  property bool background: false

  SystemClock {
    id: time
    precision: SystemClock.Seconds
  }

  ClippingRectangle {
    anchors.fill: parent
    anchors.margins: root.background ? 8 : 0
    color: 'transparent'
    radius: 16
    Flickable {
      id: flicker
      anchors {
        fill: parent
      }

      contentWidth: weatherRow.width
      contentHeight: height
      clip: true

      flickDeceleration: 2000
      maximumFlickVelocity: 3000

      flickableDirection: Flickable.HorizontalFlick
      interactive: true

      RowLayout {
        id: weatherRow
        height: parent.height

        Repeater {
          property int totalWeathers: weather.data.hourly.time.length - time.hours -1
          model: totalWeathers

          delegate: StyledRect {
            Layout.fillHeight: true
            implicitWidth: 100
            color: theme.surface_container_low

            property var modelInfo: {
              let i = modelData + time.hours + 1
              return {
                index: i,
                time: weather.data.hourly.time[i],
                weather_code: weather.data.hourly.weather_code[i],
                temp: weather.data.hourly.temperature_2m[i],
                rain_chance: weather.data.hourly.precipitation_probability[i]
              }
            }

            StyledLabel {
              anchors {
                horizontalCenter: parent.horizontalCenter
                top: parent.top
                margins: 4
              }

              text: Qt.formatDateTime(modelInfo.time, "ddd hh:mm")
            }

            GoogleIcon {
              anchors {
                horizontalCenter: parent.horizontalCenter
                top: parent.top
                margins: 16
              }
              text: weather.getWmoInfo(Qt.formatDateTime(modelInfo.time, "h"), modelInfo.weather_code).icon
              font {
                pixelSize: 48
                variableAxes: {
                  "wght": 300,
                  "FILL": settings.general.filledIcons
                }
              }
              color: theme.tertiary
              opacity: theme.mode == "dark" ? 0.7 : 0.9
            }

            StyledLabel {
              anchors {
                horizontalCenter: parent.horizontalCenter
                top: parent.top
                margins: 68
              }

              font.pixelSize: 24
              text: modelInfo.temp + '°c'
            }

            StyledLabel {
              anchors {
                horizontalCenter: parent.horizontalCenter
                top: parent.top
                margins: 96
              }
              text: weather.getWmoInfo(Qt.formatDateTime(modelInfo.time, "h"), modelInfo.weather_code).label
              width: parent.width - 8
              wrapMode: Text.WrapAtWordBoundaryOrAnywhere
              horizontalAlignment: Text.AlignHCenter
              lineHeight: 0.8
            }

            RowLayout {
              anchors {
                horizontalCenter: parent.horizontalCenter
                bottom: parent.bottom
                margins: 4
              }

              GoogleIcon {
                text: 'rainy_light'
              }
              StyledLabel {
                text: modelInfo.rain_chance + "%"
              }
            }
          }
        }
      }
    }
  }
}
