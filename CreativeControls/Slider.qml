import QtQuick 2.6
import CreativeControls 1.0

// Simple slider : values are betweeen 0. and 1.
Rectangle
{
    id: background
    color : Styles.detail
    property bool bVertical : true
    radius : Styles.cornerRadius
    clip: true

    property real sliderWidth : 100

    // the value is between 0 and 1.
    property real value : /*customMap*/(linearMap())

    property point valueRange : bVertical?
                                    Qt.point(border.width + handleWidth/2.,
                                             background.height - border.width - handleWidth/2.)
                                  : Qt.point(border.width + handleWidth/2.,
                                             background.width - border.width - handleWidth/2.)

    property var customMap: function(val){return val;}


    property var linearMap: function()
    {
        var mappedVal = 0.;
        var borderW = border.width
        if(bVertical)
            mappedVal = 1.0 - (handle.y - borderW) / (valueRange.y - valueRange.x);
        else
           mappedVal = (handle.x - borderW) /  (valueRange.y - valueRange.x)
        return Utils.clamp(mappedVal,0,1);

    }

    property real initialValue : 0.5

    property real handleWidth : Math.min(background.width,background.height) * 1./15//bVertical ? height / 20 : width / 20

    property color handleColor: Styles.base

    border.width : handleWidth
    border.color : handleColor

    Rectangle
    {
        id: handle
        color: handleColor
        width : bVertical? background.width : handleWidth
        height : bVertical? handleWidth : background.height
        radius : Styles.cornerRadius

        x: bVertical ? 0 : (1. - initialValue) * (valueRange.y - handle.width)
        y : bVertical ? (1. - initialValue) * (valueRange.y - handle.height) : 0
        anchors.verticalCenter: bVertical? undefined : parent.verticalCenter
        anchors.horizontalCenter: bVertical? parent.horizontalCenter : undefined
    }
    // label
    property alias sliderName : label.text
    Text
    {
        id: label
        anchors.centerIn: background
        font.bold: true
        color : handleColor
    }


    function moveCursor(mouseX,mouseY)
    {
        if(background.bVertical)
        {
            handle.y = Utils.clamp(mouseY,
                                   valueRange.x , valueRange.y ) - handleWidth/2;
        }
        else
        {
            handle.x = Utils.clamp(mouseX,
                                   valueRange.x ,valueRange.y ) - handleWidth/2;
        }

    }

    MouseArea
    {
        anchors.fill : parent
        onPressed :  moveCursor(mouseX,mouseY);

        onPositionChanged: moveCursor(mouseX,mouseY);
    }
}
