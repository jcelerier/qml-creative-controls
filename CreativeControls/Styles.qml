pragma Singleton

import QtQuick 2.6
import CreativeControls 1.0
QtObject
{
    property color base: "#727472"//"#666666"
    property color detail: "#99BB99"
    property color dark: "#779977"
    property color background: "#aabb99"

    property color whiteKeyColor: "#777777"
    property color blackKeyColor: "#444444"
    property color whiteKeyDetail: "#99BB99"
    property color blackKeyDetail: "#99BB99"

    property real cornerRadius : 0.

    function randomDetailColor()
    {
      return CppUtils.setHSVHue(detail, Math.random());
    }
}
