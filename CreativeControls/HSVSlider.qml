import QtQuick 2.6
import CreativeControls 1.0
import QtQuick.Layouts 1.3

// Sliders to control hue, saturation, value, alpha, of a color
// Properties:
// * enableAlpha: show the alpha channel slider
// * color: the current color
Rectangle
{
    // add an alpha slider
    property bool bAlpha : false
    property real alphaValue : bAlpha ? a.value : 1.0

    color : Qt.hsva(h.value,s.value,v.value,alphaValue)

    RowLayout
    {
        id: hsvSlider
        width : parent.width
        height : parent.height * 2/3
        anchors.centerIn: parent

        property real sliderWidth : bAlpha ?
                                        parent.width/4.
                                      : parent.width/3.

        spacing : 0.

        Slider
        {
            id : h
            sliderName : "H"

            bVertical : true

            Layout.fillHeight: true
            Layout.preferredWidth: hsvSlider.sliderWidth

            initialValue: 120./ 360.

            color : Qt.hsva(value ,0.5,0.5,1.)
            handleColor : Qt.hsva((1.-value),0.5,0.5,1.)
        }

        Slider
        {
            id : s
            sliderName : "S"

            bVertical : true

            Layout.fillHeight: true
            Layout.preferredWidth: hsvSlider.sliderWidth

            initialValue: 0.182

            color : Qt.hsva(1.0 ,value,0.5,1.)
            handleColor : Qt.hsva(1.0,1.-value,0.5,1.)
        }

        Slider
        {
            id : v
            sliderName : "V"

            Layout.fillHeight: true
            Layout.preferredWidth: hsvSlider.sliderWidth

            initialValue: 0.733

            color : Qt.hsva(0,0,value,1.)
            handleColor : Qt.hsva(0.,0.,1.-value,1.)
        }

        Slider
        {
            id : a
            sliderName : "A"

            Layout.fillHeight: true
            Layout.preferredWidth: hsvSlider.sliderWidth

            initialValue: 0.7

            color : Qt.hsva(0,0,0,value)
            handleColor : Qt.hsva(value,value,value,1.)
            visible : bAlpha
        }
    }

}
