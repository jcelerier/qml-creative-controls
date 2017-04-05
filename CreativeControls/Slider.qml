import QtQuick 2.6
import CreativeControls 1.0

// Simple slider
Rectangle
{
    id: background
    color : Styles.detail
    property bool bVertical : true
    radius : Styles.cornerRadius
    clip: true

    property real sliderWidth : 100
    border.width : handleWidth
    border.color : handleColor

    property real value : bVertical? 1.0 - handle.y / background.height : handle.x / background.width;
    property real initialValue : 0.5

    property real handleWidth : Math.min(background.width,background.height) * 1./15//bVertical ? height / 20 : width / 20

    property color handleColor: Styles.base

    Rectangle
    {
        id: handle
        color : handleColor

        width : bVertical? background.width : handleWidth
        height : bVertical? handleWidth : background.height
        radius : Styles.cornerRadius

        x: bVertical ? 0 : (1. - initialValue) * (background.width - handle.width)
        y : bVertical ? (1. - initialValue) * (background.height - handle.height) : 0
        anchors.verticalCenter: bVertical? undefined : parent.verticalCenter
        anchors.horizontalCenter: bVertical? parent.horizontalCenter : undefined
    }


    function moveCursor(mouseX,mouseY)
    {
        if(background.bVertical)
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
