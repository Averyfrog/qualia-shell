import QtQuick

Text {
  id: root
  color: theme.on_surface
  width: Math.min(implicitWidth, parent.width - 16)
  elide: Text.ElideRight

  font.pixelSize: 12
  font.family: settings.general.font
  //textFormat: Text.MarkdownText

  Behavior on color {
    ColorAnimation {
      duration: 100
    }
  }

  property bool noAnim: true

  property int textLength: text.length

  onTextLengthChanged: {
    if (!noAnim) {
      opacity = 0
      opc.running = true
    }
  }

  OpacityAnimator {
    id: opc
    target: root
    from: 0
    to: 1
  }

  function maxLength(text, length) {
    let out = text
    if (text.length > length) {
      out = text.substring(0,length-3) + "..."
    }
    return out
  }
}
