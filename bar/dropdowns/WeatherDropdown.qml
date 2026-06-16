import Quickshell
import QtQuick
import QtQuick.Layouts
import qs.components
import qs.widgets.weather

Rectangle {
  id: root

  color: 'transparent'

  implicitWidth: vertical ? 500 : 950
  implicitHeight: vertical ? 700 : 350

  anchors {
    top: parent.top
    margins: 40
  }

  property bool vertical: parent.vertical

  SystemClock {
    id: time
    precision: SystemClock.Seconds
  }

  GridLayout {
    anchors.fill: parent
    anchors.margins: 8
    columns: root.vertical ? 1 : 2

    Rectangle {
     Layout.fillHeight: true
     Layout.fillWidth: true
     color: 'transparent'

     ColumnLayout {
       anchors.fill: parent

       CurrentWeather {
         Layout.fillWidth: true
         implicitHeight: parent.height * 0.53
       }

       HourlyWeather {
         Layout.fillWidth: true
         Layout.fillHeight: true
         background: false
       }
     }
    }
    CurrentConditions {
      Layout.fillHeight: true
      Layout.fillWidth: true
    }
  }
}
