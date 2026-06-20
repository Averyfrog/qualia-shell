import Quickshell
import Quickshell.Widgets
import Quickshell.Services.Notifications
import QtQuick
import QtQuick.Layouts
import qs.components

Rectangle {
  id: notifRoot

  opacity: 0
  x: stored ? 0 : 1000

  radius: 16

  property bool stored: false

  color: theme.surface_container_highest

  ParallelAnimation {
    id: openerAnim
    PropertyAnimation {
      property: "x"
      target: notifRoot
      to: 0
      duration: 300
      easing.bezierCurve: easingOvershoot
    }
    PropertyAnimation {
      property: "opacity"
      target: notifRoot
      to: 1
      duration: 200
    }
  }
  required property var modelData
  property Notification notification: modelData.notification

  implicitWidth: parent.width
  implicitHeight: notifContent.height + 16

  Component.onCompleted: {
    notification.closed.connect(instantClose)
    x = modelData.timeLeft == modelData.totalTime ? 1000 : 0
    opacity = modelData.timeLeft == modelData.totalTime ? 0 : 1

    if (modelData.timeLeft == modelData.totalTime) {
      openerAnim.start()
    }
  }

  function close() {
    closerAnim.start()
  }

  function store() {
    storerAnim.start()
  }

  function instantClose() {
    notifServer.remove(notification.id, stored)
  }
  PropertyAnimation {
    id: closerAnim
    property: "opacity"
    target: notifRoot
    to: 0
    duration: 150
    onFinished: {
      notifServer.remove(notification.id, stored)
    }
  }
  PropertyAnimation {
    id: storerAnim
    property: "x"
    target: notifRoot
    to: 1000
    duration: 350
    onFinished: {
      notifServer.store(notification.id)
    }
  }

  Timer {
    interval: 100
    running: !notifArea.containsMouse && !stored
    repeat: true
    onTriggered: {
      notifRoot.modelData.timeLeft -= 0.1
      if (notifRoot.modelData.timeLeft <= 0) {
        notifRoot.store()
      }
    }
  }

  RowLayout {
    id: notifContent
    width: parent.width - 16
    anchors.centerIn: parent
    spacing: 0

    ClippingWrapperRectangle {
      id: notifImage
      color: 'transparent'

      implicitWidth: notifRoot.notification.image ? 72 : 0
      implicitHeight: width

      radius: 16
      opacity: nimg.status == Image.Ready ? 1 : 0
      Image {
        id: nimg
        source: notifRoot.notification.image
        fillMode: Image.PreserveAspectCrop
      }
    }

    Rectangle {
      implicitHeight: notifTextStuff.height
      Layout.fillWidth: true
      Layout.leftMargin: notifRoot.notification.image ? 8 : 8
      color: 'transparent'


      ColumnLayout {
        id: notifTextStuff
        width: parent.width
        anchors.top: parent.top

        Rectangle {
          implicitHeight: summary.height + 8
          implicitWidth: parent.width
          color: 'transparent'

          RowLayout {
            anchors.fill: parent

            StyledLabel {
              id: summary
              Layout.fillWidth: true

              text: notifRoot.notification.summary

              font {
                pixelSize: 14
                bold: true
              }

              textFormat: Text.MarkdownText
            }

            Rectangle {
              Layout.fillHeight: true
              implicitWidth: 32
              color: 'transparent'

              CircularProgress {

                value: notifRoot.modelData.timeLeft / notifRoot.modelData.totalTime
                foregroundColor: notifArea.hovered ? theme.error_container : theme.error
                opacity: !notifRoot.stored || notifArea.hovered

                Rectangle {
                  anchors.fill: parent
                  anchors.margins: -2
                  color: parent.foregroundColor
                  radius: 100
                  opacity: notifArea.hovered
                  Behavior on opacity {
                    PropertyAnimation {
                      duration: 100
                    }
                  }

                  GoogleIcon {
                    anchors.centerIn: parent
                    text: "close"
                    color: theme.error
                    font.weight: 700
                  }

                  ButtonArea {
                    id: closeButtonArea
                    onClicked: {
                      notifRoot.close()
                    }
                    defColor: parent.color
                    hoverColor: parent.color
                  }
                }
              }
            }
          }
        }
        Rectangle {
          implicitHeight: body.height + 8
          implicitWidth: parent.width
          color: 'transparent'

          StyledLabel {
            id: body
            text: notifRoot.notification.body

            textFormat: Text.MarkdownText
            wrapMode: Text.Wrap
          }
        }

      }
    }
  }

  ButtonArea {
    id: notifArea
    propagateComposedEvents: true
    defColor: theme.surface_container_highest
  }

}
