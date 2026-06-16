import Quickshell
import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import qs.components
import qs.widgets.weather

Rectangle {
  id: root
  color: 'transparent'

  implicitWidth: vertical ? 450 : 900
  implicitHeight: vertical ? 900 : 450

  anchors {
    top: parent.top
    margins: 40
  }

  property bool vertical: parent.vertical

  property var time: time

  SystemClock {
    id: time
    precision: SystemClock.Seconds
  }

  GridLayout {
    anchors.fill: parent
    anchors.margins: 8
    columns: parent.vertical ? 1 : 2

    Rectangle {
      color: 'transparent'
      Layout.fillHeight: true
      implicitWidth: parent.width * (root.vertical ? 1 : 0.5)

      ColumnLayout {
        anchors.fill: parent

        StyledRect {
          Layout.fillWidth: true
          Layout.fillHeight: true
          color: theme.surface_container_lowest

          ColumnLayout {
            anchors.fill: parent

            Rectangle {
              Layout.fillWidth: true
              implicitHeight: 48
              color: 'transparent'

              StyledLabel {
                anchors.centerIn: parent
                text: Qt.formatDateTime(time.date, "MMMM yyyy")
                font {
                  pixelSize: 20
                  bold: true
                }
              }
            }

            DayOfWeekRow {
              Layout.fillWidth: true
              implicitHeight: parent.height * 0.1
            }

            MonthGrid {
              id: calendarDays
              Layout.fillWidth: true
              Layout.fillHeight: true

              delegate: Rectangle {
                Layout.fillWidth: true
                Layout.fillHeight: true
                color: 'transparent'

                StyledRect {
                  anchors.centerIn: parent
                  width: parent.width * 0.6
                  height: width

                  color: model.today ? theme.primary : 'transparent'
                  radius: 40

                  StyledLabel {
                    anchors.centerIn: parent
                    text: model.month == calendarDays.month ? model.day : ""
                    color: model.today ? theme.on_primary : theme.on_surface
                    opacity: model.day < Qt.formatDateTime(time.date, "d") ? 0.3 : 1
                    font.pixelSize: 14
                  }
                }
              }
            }
          }
        }
      }
    }
    Rectangle {
      Layout.fillHeight: true
      Layout.fillWidth: true
      color: 'transparent'

      ColumnLayout {
        anchors.fill: parent

        StyledRect {
          Layout.fillWidth: true
          implicitHeight: parent.height * 0.4
          color: theme.surface_container_low
        }

        StyledRect {
          Layout.fillWidth: true
          Layout.fillHeight: true
          color: theme.surface_container_low

          ColumnLayout {
            anchors.fill: parent
            Flickable {
              Layout.fillWidth: true
              Layout.fillHeight: true
              Layout.margins: 8

              contentHeight: tasksColumn.height
              clip: true

              ColumnLayout {
                id: tasksColumn
                width: parent.width

                Repeater {
                  id: taskRepeater
                  property int totalItems: tasks.data.tasks.length
                  model: 0

                  delegate: StyledRect {
                    Layout.fillWidth: true
                    implicitHeight: 40
                    color: taskCheckbox.checkState == Qt.Checked ? theme.surface_container : theme.surface_container_high
                    radius: 4
                    topLeftRadius: index == 0 ? 16 : 4
                    topRightRadius: index == 0 ? 16 : 4
                    bottomLeftRadius: index == taskRepeater.totalItems - 1 ? 16 : 4
                    bottomRightRadius: index == taskRepeater.totalItems - 1 ? 16 : 4

                    RowLayout {
                      anchors.fill: parent

                      CheckBox {
                        id: taskCheckbox
                        checkState: modelData.checked ? Qt.Checked : Qt.Unchecked

                        onCheckStateChanged: {
                          if (checkState == Qt.Checked) modelData.checked = true
                          else modelData.checked = false
                        }
                      }

                      StyledLabel {
                        Layout.fillWidth: true
                        text: modelData.name
                      }
                    }

                  }
                }
              }
            }
            StyledRect {
              Layout.fillWidth: true
              Layout.margins: 8
              implicitHeight: 48
              color: theme.surface_container_low
            }
          }
        }
      }
    }
  }
}
