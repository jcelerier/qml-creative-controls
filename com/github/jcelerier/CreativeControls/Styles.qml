pragma Singleton

import QtQuick 2.6
import com.github.jcelerier.CreativeControls 1.0
QtObject
{   
    property bool defaultTheme: true // default = dark, other = light

    property color base: defaultTheme ?"#b4c889" : "#561C49"
    property color baseLighter: defaultTheme ?"#b4c889" : "#561C49"

    property color detail: "#3a4407"
    property color colorOn: defaultTheme ? "#7b9a4a" : "orange"
    property color colorOff:  "#7f8287"
    property color background: defaultTheme ? "#424041" : "#ffffff"

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
