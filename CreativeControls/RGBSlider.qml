import QtQuick 2.6
import CreativeControls 1.0
import QtQuick.Layouts 1.3


// Three to four sliders to control red, green, blue, alpha of a color
// Properties:
// * color: the current color
// * enableAlpha: show the alpha channel slider

Rectangle
{
    id: rgbSlider

    height : 200
    width : 200
    color : Qt.rgba(r.value,g.value,b.value,alphaValue)
    border.color: Styles.base
    border.width: 2

    // vertical or horizontal slider
    property int orientation : Qt.Vertical

    // add an alpha slider
    property bool enableAlpha : false
    property real alphaValue : enableAlpha ? a.value : 1.0

    // slider width varies according to channel number (3 without alpha and 4 with alpha)
    property real sliderWidth : enableAlpha ? width/4. : width/3.


    RowLayout
    {
        width : parent.width
        height : parent.height * 2/3
        anchors.centerIn: parent

        spacing : 0.

        Slider
        {
            id : r

            text : "R"
            orientation : rgbSlider.orientation

            Layout.fillHeight: true
            Layout.alignment: Qt.AlignHCenter
           Layout.preferredWidth: rgbSlider.sliderWidth - 10

            initialValue: 153. / 255.

            color : Qt.rgba(value,0,0,1.)
            handleColor : Qt.rgba(1.-value,0,0,1.)
        }
        Slider
        {
            id : g

            text : "G"
            orientation : rgbSlider.orientation

            Layout.fillHeight: true
            Layout.alignment: Qt.AlignHCenter
            Layout.preferredWidth: rgbSlider.sliderWidth - 10

            initialValue: 187. / 255.

            color : Qt.rgba(0,value,0,1.)
            handleColor: Qt.rgba(0.,1.-value,0,1.)

        }
        Slider
        {
            id : b

            text : "B"
            orientation : rgbSlider.orientation

            Layout.fillHeight: true
            Layout.alignment: Qt.AlignHCenter
            Layout.preferredWidth: rgbSlider.sliderWidth - 10

            initialValue: 153. / 255.

            color : Qt.rgba(0,0,value,1.)
            handleColor : Qt.rgba(0.,0.,1.-value,1.)

        }
        Slider
        {
            id : a

            visible : rgbSlider.enableAlpha

            text : "A"
            orientation : rgbSlider.orientation

            Layout.fillHeight: true
            Layout.alignment: Qt.AlignHCenter
            Layout.preferredWidth: rgbSlider.sliderWidth - 10

            initialValue: 0.7

            color : Qt.rgba(0,0,0,value)
            handleColor : Qt.rgba(value,value,value,1.)
        }
    }

}
