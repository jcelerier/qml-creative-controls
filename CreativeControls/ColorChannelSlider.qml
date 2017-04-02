import QtQuick 2.6
import CreativeControls 1.0

Slider
{
    bRotate : true
    radius: 20

    property real sliderWidth : 100

    border.width : sliderWidth /20

    handleColor : border.color
    handleWidth: border.width
}
