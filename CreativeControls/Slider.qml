import QtQuick 2.6
import CreativeControls 1.0

// Simple slider : values are betweeen 0. and 1.
Rectangle
{
    id: slider

    color : Styles.detail
    border.width : handleWidth
    border.color : handleColor

    radius : Styles.cornerRadius

    // slider width
    property real sliderWidth : 100

    // handle width and color
    property real handleWidth : Math.min(slider.width,slider.height) * 1./15//bVertical ? height / 20 : width / 20
    property color handleColor: Styles.base
    property bool enableHandleAnimation : true

    // vertical (Qt.Vertical) or horizontal (Qt.Horizontal) slider
    property int orientation : Qt.Vertical //Qt.Horizontal

    // the value is between 0 and 1.
    property real value : initialValue;
    property real initialValue : 0.5

    property bool __updating: false

    // value mapping
    property var customMap: function(val){return val;}
    property var linearMap: function()
    {
        var mappedVal = 0.;
        var borderW = border.width;

        if(orientation == Qt.Vertical)
            mappedVal = 1.0 - (handle.y - borderW) / (valueRange.y - valueRange.x);
        else if(orientation == Qt.Horizontal)
            mappedVal = (handle.x - borderW) /  (valueRange.y - valueRange.x);

        return Utils.clamp(mappedVal,0,1);
    }

    // slider value range
    property point valueRange : orientation == Qt.Vertical?
                                    Qt.point(border.width + handleWidth/2.,
                                             slider.height - border.width - handleWidth/2.)
                                  : Qt.point(border.width + handleWidth/2.,
                                             slider.width - border.width - handleWidth/2.)

    // function called after the handle moved
    // updates the value
    function updateValue()
    {
        // TODO use a function instead so that one can use linear, or log, or whatever mapping.
        if(!__updating)
        {
            slider.value = linearMap();

        }
    }

    // called when a mouse event (onPressed / onPositionChanged) is detected
    // moves the slider's handle to the mouse position
    function moveHandle(mouseX,mouseY)
    {
        __updating = true;
        if(orientation == Qt.Vertical)
        {
            handle.y = Utils.clamp(mouseY,
                                   valueRange.x , valueRange.y ) - handleWidth/2;
        }
        else
        {
            handle.x = Utils.clamp(mouseX,
                                   valueRange.x ,valueRange.y ) - handleWidth/2;
        }
        __updating = false;

        updateValue();
    }


    Rectangle
    {
        id: handle

        color: handleColor

        width : orientation == Qt.Vertical? slider.width : handleWidth
        height : orientation == Qt.Vertical? handleWidth : slider.height
        radius : Styles.cornerRadius

        x: orientation == Qt.Horizontal ? (1. - initialValue) * (valueRange.y - valueRange.x) + valueRange.x - handleWidth/2.: 0
        y : orientation == Qt.Vertical ? (1. - initialValue) * (valueRange.y - valueRange.x) + valueRange.x - handleWidth/2.: 0

        Behavior on x {enabled : slider.enableHandleAnimation; NumberAnimation {easing.type : Easing.OutQuint}}
        Behavior on y {enabled : slider.enableHandleAnimation; NumberAnimation {easing.type : Easing.OutQuint}}

        anchors.verticalCenter: orientation == Qt.Horizontal? parent.verticalCenter : undefined
        anchors.horizontalCenter: orientation == Qt.Vertical? parent.horizontalCenter : undefined
    }
    MouseArea
    {
        anchors.fill : parent

        onPressed :  moveHandle(mouseX,mouseY);

        onPositionChanged: moveHandle(mouseX,mouseY);
    }

    // label
    property alias sliderName : label.text
    Text
    {
        id: label

        anchors.centerIn: slider

        font.bold: true
        color : handleColor
    }
}
