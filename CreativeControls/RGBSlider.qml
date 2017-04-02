import QtQuick 2.6
import CreativeControls 1.0
import QtQuick.Layouts 1.3

// Four sliders to control R, G, B, alpha
Row//Layout
{
    id: rgbSlider

    spacing : 10
    anchors.fill : parent

    property real sliderWidth : (rgbSlider.width-spacing *3) / 4
    Slider
    {
        id : r
        bRotate : true
        width : rgbSlider.sliderWidth
        height: rgbSlider.height
    }
    Slider
    {
        id : g
        bRotate : true

        width : rgbSlider.sliderWidth
        height :  rgbSlider.height
    }
    Slider
    {
        id : b
        bRotate : true

        width : rgbSlider.sliderWidth
        height :  rgbSlider.height
    }
    Slider
    {
        id : a
        bRotate : true

        width : rgbSlider.sliderWidth
        height :  rgbSlider.height
    }
}
