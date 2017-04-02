import QtQuick 2.6
import CreativeControls 1.0

// Simple slider
Rectangle
{
    id: background
    color : Styles.detail
    property bool bRotate : true
    radius : Styles.cornerRadius
    clip: true

    property real sliderWidth : 100
    border.width : handleWidth
    border.color : handleColor

    property real value : bRotate? 1.0 - handle.y / background.height : handle.x / background.width;
    property real initialValue : 0.

    property real handleWidth : bRotate ? height / 20 : width / 20
    property color handleColor: Styles.base

    Rectangle
    {
        id: handle
        color : handleColor

        width : bRotate? background.width : handleWidth
        height : bRotate? handleWidth : background.height
        radius : Styles.cornerRadius

        x: bRotate ? 0 : (1. - initialValue) * (background.width - handle.width)
        y : bRotate ? (1. - initialValue) * (background.height - handle.height) : 0
        anchors.verticalCenter: bRotate? undefined : parent.verticalCenter
        anchors.horizontalCenter: bRotate? parent.horizontalCenter : undefined
    }


    function moveCursor(mouseX,mouseY)
    {
        if(background.bRotate)
            handle.y = Utils.clamp(mouseY - handle.height/2,
                                   0,
                                   background.height - handle.height );
        else
            handle.x = Utils.clamp(mouseX - handle.width/2,
                                   0,
                                   background.width - handle.width );
    }

    MouseArea
    {
        anchors.fill : parent
        onPressed :  moveCursor(mouseX,mouseY);

        onPositionChanged: moveCursor(mouseX,mouseY);
    }
}
