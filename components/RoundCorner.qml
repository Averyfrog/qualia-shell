import QtQuick
import QtQuick.Shapes

Shape {
    required property int corner
    required property int radius
    required property color color


    preferredRendererType: Shape.CurveRenderer
    rotation: corner * 90

    //anchors {
    //  left: corner === 0 || corner === 3 ? parent.left : undefined
    //  top: corner === 0 || corner === 1 ? parent.top : undefined
    //  right: corner === 1 || corner === 2 ? parent.right : undefined
    //  bottom: corner === 2 || corner === 3 ? parent.bottom : undefined
    //}

    ShapePath {
      strokeWidth: 0
      fillColor: color

      //Behavior on fillColor { CAnim {} }

      PathLine {
        relativeX: radius
        relativeY: 0
      }

      PathArc {
        relativeX: -radius
        relativeY: radius
        radiusX: radius
        radiusY: radius
        direction: PathArc.Counterclockwise
      }

      PathLine {
        relativeX: 0
        relativeY: -radius
      }
    }
  }
