pragma Singleton

import QtQuick 2.6
import com.github.jcelerier.CreativeControls 1.0

QtObject {
    property color base: "#b4c889"
    property color baseLighter: "#bec889"
    property color detail: "#3a4407"
    property color borderColor: "#666666"
    property color background: "#424041"

    // container properties
    property real containerCornerRadius: 3

    // slider colors
    property color sliderBackgroundColor: background
    property color handleColor: colorOn
    property color pressedHandleColor: colorOnLighter

    // range slider colors
    property color handlesColor: detail
    property color pressedHandlesColor: borderColor
    property color handlesValueColor: colorOnLighter

    // switch, leds, matrix color
    property color colorOn: "#7b9a4a"
    property color colorOff: "#7f8287"
    property color colorOnLighter: "#93a54d"
    property color colorOffDarker: "#4c4e51"

    // step properties
    property real stepRectCornerRadius: 8

    // CosInfluence text color
    property color textPressedColor: base

    // keyboard colors
    property color keyBorder: detail
    property color whiteKeyColor: colorOff
    property color blackKeyColor: background
    property color whiteKeyDetail: base
    property color blackKeyDetail: colorOn

    // label text color (e.g. sliders)
    property color labelColor: "#cccfbf"

    property real cornerRadius: 0.

    function randomDetailColor() {
        return CppUtils.setHSVHue(colorOn, Math.random())
    }
}
