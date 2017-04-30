import QtQuick 2.6
import CreativeControls 1.0
import QtQuick.Layouts 1.3

// Sliders to control hue, saturation, value, alpha, of a color
// Properties:
// * color: the current color
// * enableAlpha: show the alpha channel slider

Rectangle
{
    id: hsvSlider

    color : Qt.hsva(h.value,s.value,v.value,alphaValue)
    border.color: Styles.base
    border.width: 2

    // vertical or horizontal slider
    property int orientation : Qt.Vertical

    // add an alpha slider
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
            border.width : 0

            orientation : hsvSlider.orientation

            Layout.fillHeight: true
            Layout.alignment: Qt.AlignHCenter
            Layout.preferredWidth: hsvSlider.sliderWidth - 10

            initialValue: 120./ 360.

            color : Qt.hsva(value ,0.5,0.5,1.)
        }

        Slider
        {
            id : s

            text : "S"
            border.width : 0

            orientation : hsvSlider.orientation

            Layout.fillHeight: true
            Layout.alignment: Qt.AlignHCenter
            Layout.preferredWidth: hsvSlider.sliderWidth - 10

            initialValue: 0.182

            color : Qt.hsva(1.0 ,value,0.5,1.)
        }

        Slider
        {
            id : v

            text : "V"
            border.width : 0

            orientation : hsvSlider.orientation

            Layout.fillHeight: true
            Layout.alignment: Qt.AlignHCenter
            Layout.preferredWidth: hsvSlider.sliderWidth - 10

            initialValue: 0.733

            color : Qt.hsva(0,0,value,1.)
        }

        Slider
        {
            id : a

            text : "A"
            visible : hsvSlider.enableAlpha
            border.width : 0

            orientation : hsvSlider.orientation

            Layout.fillHeight: true
            Layout.alignment: Qt.AlignHCenter
            Layout.preferredWidth: hsvSlider.sliderWidth - 10

            initialValue: 0.7

            color : Qt.hsva(0,0,0,value)
        }
    }

}
