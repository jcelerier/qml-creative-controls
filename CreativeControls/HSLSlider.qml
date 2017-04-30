import QtQuick 2.6
import CreativeControls 1.0
import QtQuick.Layouts 1.3

// Sliders to control hue, saturation, luminance, alpha, of a color
// Properties:
// * color: the current color
// * enableAlpha: show the alpha channel slider

Rectangle
{

    id: hslSlider

    color : Qt.hsla(h.value,s.value,l.value,alphaValue)
    border.color: Styles.base
    border.width: 2

    // vertical or horizontal slider
    property int orientation : Qt.Vertical

    property bool enableAlpha : false
    property real alphaValue : enableAlpha ? a.value : 1.0

    property real sliderWidth : enableAlpha ? width/4. : width/3.

    RowLayout
    {
        width : parent.width
        height : parent.height * 2/3
        anchors.centerIn: parent
        spacing : 0.

        Slider
        {
            id : h

            text : "H"
            orientation : hslSlider.orientation
            border.width : 0

            Layout.fillHeight: true
            Layout.alignment: Qt.AlignHCenter
            Layout.preferredWidth: hslSlider.sliderWidth - 10

            initialValue: 120. / 360.

            color: Qt.hsla(value, 0.5, 0.5, 1.)
        }

        Slider
        {
            id : s

            text: "S"
            orientation : hslSlider.orientation
            border.width : 0

            Layout.fillHeight: true
            Layout.alignment: Qt.AlignHCenter
            Layout.preferredWidth: hslSlider.sliderWidth - 10

            initialValue: 0.2

            color: Qt.hsla(h.value, value, 0.5, 1.)
        }

        Slider
        {
            id : l

            text : "L"
            orientation : hslSlider.orientation
            border.width : 0

            Layout.fillHeight: true
            Layout.alignment: Qt.AlignHCenter
            Layout.preferredWidth: hslSlider.sliderWidth - 10

            initialValue: 0.667

            color : Qt.hsla(0,0,value,1.)
        }

        Slider
        {
            id : a

            visible : enableAlpha

            text : "A"
            orientation : hslSlider.orientation
            border.width : 0

            Layout.fillHeight: true
            Layout.alignment: Qt.AlignHCenter
            Layout.preferredWidth: hslSlider.sliderWidth - 10

            initialValue: 0.7

            color : Qt.hsla(0,0,0,value)
        }
    }

}
