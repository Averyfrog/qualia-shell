import QtQuick

StyledLabel {
  width: implicitWidth
  font {
    pixelSize: 18
    family: "Material Symbols Rounded"
  }

  color: theme.on_surface_variant
  text: "add_circle"

  Behavior on rotation {
    PropertyAnimation {
      duration: 50
    }
  }
}
