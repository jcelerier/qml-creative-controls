pragma Singleton

import QtQuick 2.6
import CreativeControls 1.0
QtObject
{   

    property color base: "#561C49"
    property color baseLighter: "#561C49"
    property color detail: "#3d1233"
    property color borderColor: "#6d3160"
    property color background: "#ffffff"

    // slider colors
    property color sliderBackgroundColor: background
    property color handleColor: colorOn
    property color pressedHandleColor: colorOnLighter

    // switch, leds, matrix color
    property color colorOn:  "orange"
    property color colorOff:  "#8c5580"
    property color colorOnLighter: "#ffb20c"

    // keyboard colors
    property color keyBorder: detail
    property color whiteKeyColor: background
    property color blackKeyColor: detail
    property color whiteKeyDetail: colorOn
    property color blackKeyDetail: colorOn

    // label text color (e.g. sliders)
    property color labelColor:  "#561C49"

    property real cornerRadius : 0.

    function randomDetailColor()
    {
      return CppUtils.setHSVHue(detail, Math.random());
    }
}
