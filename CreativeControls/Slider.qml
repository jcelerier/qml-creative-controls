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

    //anchors.fill : parent

    property real handleWidth : bRotate ? height / 10 : width / 10
    property real value : bRotate? 1.0 - handle.y / background.height : handle.x / background.width;
    property real initialValue : 0.
    property alias handleColor: handle.color
    Rectangle
    {
        id: handle

        width : bRotate? background.width : handleWidth
        height : bRotate? handleWidth : background.height
        radius : Styles.cornerRadius

        x: bRotate ? 0 : (1. - initialValue) * (background.width - handle.width)
        y : bRotate ? (1. - initialValue) * (background.height - handle.height) : 0
        anchors.verticalCenter: bRotate? undefined : parent.verticalCenter
        anchors.horizontalCenter: bRotate? parent.horizontalCenter : undefined

        color : Styles.base
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
