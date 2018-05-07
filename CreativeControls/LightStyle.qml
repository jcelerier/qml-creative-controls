pragma Singleton

import QtQuick 2.6
import CreativeControls 1.0
QtObject
{   

    property color base: "#561C49"
    property color baseLighter: "#561C49"

    property color detail: "#3a4407"
    property color colorOn:  "orange"
    property color colorOff:  "#7f8287"
    property color background: "#ffffff"

    property color whiteKeyColor: colorOff
    property color blackKeyColor: background
    property color whiteKeyDetail: base
    property color blackKeyDetail: colorOn

    property color labelColor:  "#CCCCCC"

    property real cornerRadius : 0.

    function randomDetailColor()
    {
      return CppUtils.setHSVHue(detail, Math.random());
    }
}