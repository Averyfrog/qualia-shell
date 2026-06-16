import Quickshell
import QtQuick
import QtQuick.Layouts
import qs.components


Rectangle {
  Layout.fillHeight: true
  implicitWidth: sb.vertical ? parent.width : parent.width * 0.6
  color: 'transparent'

  ColumnLayout {
    anchors.fill: parent
    spacing: sb.spacing

    Rectangle {
      Layout.fillWidth: true
      Layout.fillHeight: true
      color: 'transparent'

      RowLayout {
        anchors.fill: parent

        StyledRect {
          Layout.fillHeight: true
          Layout.fillWidth: true

          StyledLabel {
            anchors {
              margins: 4
              top: parent.top
              horizontalCenter: parent.horizontalCenter
            }
            color: theme.on_secondary_container
            text: "Year"
          }
          StyledLabel {
            anchors {
              centerIn: parent
            }
            font {
              pixelSize: 18
              bold: true
            }
            text: sb.sbTime.year
          }
        }

        StyledRect {
          Layout.fillHeight: true
          implicitWidth: parent.width * 0.6

          StyledLabel {
            anchors {
              margins: 4
              top: parent.top
              horizontalCenter: parent.horizontalCenter
            }
            color: theme.on_secondary_container
            text: "Date"
          }
          StyledLabel {
            anchors {
              centerIn: parent
            }
            font {
              pixelSize: 18
              bold: true
            }
            text: sb.months[sb.sbTime.month-1]
          }
        }

        StyledRect {
          Layout.fillHeight: true
          Layout.fillWidth: true

          StyledLabel {
            anchors {
              margins: 4
              top: parent.top
              horizontalCenter: parent.horizontalCenter
            }
            color: theme.on_secondary_container
            text: "Time"
          }
          StyledLabel {
            anchors {
              centerIn: parent
            }
            font {
              pixelSize: 18
              bold: true
            }
            text: ("0" + sb.sbTime.hour).slice(-2) + ":" + ("0" + sb.sbTime.minute).slice(-2)
          }
        }
      }
    }
    StyledRect {
      Layout.fillWidth: true
      implicitHeight: parent.height * 0.8
      color: theme.surface_bright

      Rectangle {
        color: 'transparent'
        anchors {
          bottom: parent.bottom
          right: parent.right
          margins: 16
        }
        implicitWidth: parent.width * 0.5
        height: parent.height * 0.15

        GoogleIcon {
          id: nextMonthIcon
          anchors {
            verticalCenter: parent.verticalCenter
            left: parent.left
          }
          color: theme.on_secondary_container
          text: 'arrow_forward'
        }

        StyledLabel {
          anchors {
            leftMargin: 16
            verticalCenter: parent.verticalCenter
            left: nextMonthIcon.right
          }
          font {
            pixelSize: 18
          }
          color: theme.on_secondary_container
          text: sb.sbTime.month < 12 ? sb.months[sb.sbTime.month] : sb.months[0] + " " + sb.sbTime.year
        }
      }

      GridLayout {
        anchors.fill: parent
        //anchors.bottomMargin: 64
        anchors.margins: 16
        columns: 7

        Repeater {
          model: 31

          delegate: Rectangle {
            id: calendarItem
            Layout.fillHeight: true
            Layout.fillWidth: true
            color: 'transparent'

            property int day: index + 1

            opacity: day < sb.sbTime.day ? 0.4 : 1.0

            StyledRect {
              anchors.fill: parent
              //implicitWidth: 44
              //implicitHeight: implicitWidth
              //radius: 40

              color: index == sb.sbTime.day - 1 ? theme.primary : theme.surface_variant
              StyledLabel {
                anchors {
                  margins: 4
                  top: parent.top
                  right: parent.right
                }

                font {
                  pixelSize: 14
                  bold: true
                }
                color: calendarItem.day == sb.sbTime.day ? theme.on_primary : theme.on_surface
                text: index + 1
              }

              GridLayout {
                rowSpacing: 0
                columnSpacing: 0

                anchors {
                  margins: 4
                  fill: parent
                  topMargin: 24
                }

                columns: 3

                function getEvents() {
                  let out = [];
                  if (index == 0) {
                    out.push("money_bag")
                  }
                  if ((sb.sbTime.daysToMonthStart + index) % 3 == 0) {
                    out.push("psychiatry")
                  }
                  if ((sb.sbTime.daysToMonthStart + index) % 3 == 2) {
                    out.push("gavel")
                  }
                  if ((index+1) % 7 == 0) {
                    out.push("diversity_3")
                  }
                  if ((sb.sbTime.daysToMonthStart + index - ((sb.sbTime.year-1)*372)) == 88) {
                    out.push("how_to_vote")
                  }
                  return out
                }

                property list<string> events: getEvents()

                Repeater {
                  model: parent.events

                  delegate: Rectangle {
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    color: 'transparent'

                    GoogleIcon {
                      anchors.centerIn: parent

                      font.pixelSize: sb.vertical ? 12 : 14
                      color: calendarItem.day == sb.sbTime.day ? theme.on_primary : theme.on_primary_container
                      text: modelData
                    }
                  }
                }
              }
            }
          }
        }
      }
    }
  }
}
