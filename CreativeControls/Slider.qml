import QtQuick 2.6
import CreativeControls 1.0

// Simple slider
Rectangle
{
    id: background
    color : Styles.detail
    property bool bRotate : false

    //anchors.fill : parent

    property real sliderWidth : bRotate ? height / 10 : width / 10
    Rectangle
    {
        id: handle
        height : bRotate? sliderWidth : background.height
        width : bRotate? background.width : sliderWidth
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
