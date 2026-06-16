import QtQuick

StyledLabel {
  width: implicitWidth
  font {
    hintingPreference: Font.PreferNoHinting
    pixelSize: 18
    family: "Material Symbols Rounded"
    variableAxes: {
      // Will probably break.
      // Yep i was right
      "FILL": settings.general.filledIcons
    }
  }
  renderType: Text.NativeRendering

  color: theme.on_surface_variant
  text: "add_circle"



  Behavior on rotation {
    PropertyAnimation {
      duration: 50
    }
  }
}
