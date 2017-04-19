import QtQuick 2.6
import CreativeControls 1.0
import QtQuick.Layouts 1.3

// Sliders to control hue, saturation, luminance, alpha, of a color
// Properties:
// * enableAlpha: show the alpha channel slider
// * color: the current color
Rectangle
{
    property bool enableAlpha : false
    property real alphaValue : enableAlpha ? a.value : 1.0

    color : Qt.hsla(h.value,s.value,l.value,alphaValue)

    RowLayout
    {
        id: hslSlider
        width : parent.width
        height : parent.height * 2/3
        anchors.centerIn: parent
        spacing : 0.

        property real sliderWidth : enableAlpha ?
                                        parent.width/4.
                                      : parent.width/3.

        Slider
        {
            id : h
            sliderName : "H"

            bVertical : true

            Layout.fillHeight: true
            Layout.preferredWidth: hslSlider.sliderWidth

            initialValue: 120./ 360.

            color : Qt.hsla(value ,0.5,0.5,1.)
            handleColor : Qt.hsla((1.-value),0.5,0.5,1.)
        }

        Slider
        {
            id : s
            sliderName : "S"

            bVertical : true

            Layout.fillHeight: true
            Layout.preferredWidth: hslSlider.sliderWidth

            initialValue: 0.2

            color : Qt.hsla(1.0 ,value,0.5,1.)
            handleColor : Qt.hsla(1.0,1.-value,0.5,1.)
        }

        Slider
        {
            id : l
            sliderName : "L"

            Layout.fillHeight: true
            Layout.preferredWidth: hslSlider.sliderWidth

            initialValue: 0.667

            color : Qt.hsla(0,0,value,1.)
            handleColor : Qt.hsla(0.,0.,1.-value,1.)
        }

        Slider
        {
            id : a
            sliderName : "A"

            Layout.fillHeight: true
            Layout.preferredWidth: hslSlider.sliderWidth

            initialValue: 0.7

            color : Qt.hsla(0,0,0,value)
            handleColor : Qt.hsla(value,value,value,1.)
            visible : enableAlpha
        }
    }

}
