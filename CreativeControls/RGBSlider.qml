import QtQuick 2.6
import CreativeControls 1.0
import QtQuick.Layouts 1.3

// Four sliders to control R, G, B, alpha
Rectangle
{
    color : Qt.rgba(r.value,g.value,b.value,a.value)


    RowLayout
    {
        id: rgbSlider
        width : parent.width
        height : parent.height * 2/3
        anchors.centerIn: parent

        property real sliderWidth : parent.width/4.
        spacing : 0.

        ColorChannelSlider
        {
            id : r
            sliderWidth : rgbSlider.sliderWidth

            Layout.fillHeight: true
            Layout.preferredWidth: rgbSlider.sliderWidth

            initialValue: 153. / 255.

            color : Qt.rgba(value,0,0,1.)
            border.color : Qt.rgba(1.-value,0,0,1.)
        }
        ColorChannelSlider
        {
            id : g
            sliderWidth : rgbSlider.sliderWidth
            Layout.fillHeight: true
            Layout.preferredWidth: rgbSlider.sliderWidth

            initialValue: 187. / 255.
            color : Qt.rgba(0,value,0,1.)
            border.color : Qt.rgba(0.,1.-value,0,1.)

        }
        ColorChannelSlider
        {
            id : b
            sliderWidth : rgbSlider.sliderWidth
            Layout.fillHeight: true
            Layout.preferredWidth: rgbSlider.sliderWidth

            initialValue: 153. / 255.
            color : Qt.rgba(0,0,value,1.)
            border.color : Qt.rgba(0.,0.,1.-value,1.)

        }
        ColorChannelSlider
        {
            id : a
            sliderWidth : rgbSlider.sliderWidth
            Layout.fillHeight: true
            Layout.preferredWidth: rgbSlider.sliderWidth

            initialValue: 0.7

            color : Qt.rgba(0,0,0,value)
            border.color : Qt.rgba(value,value,value,1.)

        }
    }

}
