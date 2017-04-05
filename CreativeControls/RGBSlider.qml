import QtQuick 2.6
import CreativeControls 1.0
import QtQuick.Layouts 1.3

// Four sliders to control R, G, B, alpha
Rectangle
{
    // add an alpha slider
    property bool bAlpha : false
    property real alphaValue : bAlpha ? a.value : 1.0

    color : Qt.rgba(r.value,g.value,b.value,alphaValue)


    RowLayout
    {
        id: rgbSlider
        width : parent.width
        height : parent.height * 2/3
        anchors.centerIn: parent

        property real sliderWidth : bAlpha ?
                                        parent.width/4.
                                      : parent.width/3.
        spacing : 0.

        Slider
        {
            id : r
            sliderName : "R"
            bVertical : true

            Layout.fillHeight: true
            Layout.preferredWidth: rgbSlider.sliderWidth

            initialValue: 153. / 255.

            color : Qt.rgba(value,0,0,1.)
            handleColor : Qt.rgba(1.-value,0,0,1.)
        }
        Slider
        {
            id : g
            sliderName : "G"

            bVertical : true

            Layout.fillHeight: true
            Layout.preferredWidth: rgbSlider.sliderWidth

            initialValue: 187. / 255.
            color : Qt.rgba(0,value,0,1.)
            handleColor : Qt.rgba(0.,1.-value,0,1.)

        }
        Slider
        {
            id : b
            sliderName : "B"

            Layout.fillHeight: true
            Layout.preferredWidth: rgbSlider.sliderWidth

            initialValue: 153. / 255.
            color : Qt.rgba(0,0,value,1.)
            handleColor : Qt.rgba(0.,0.,1.-value,1.)

        }
        Slider
        {
            id : a
            sliderName : "A"

            Layout.fillHeight: true
            Layout.preferredWidth: rgbSlider.sliderWidth

            initialValue: 0.7

            color : Qt.rgba(0,0,0,value)
            handleColor : Qt.rgba(value,value,value,1.)
            visible : bAlpha
        }
    }

}
