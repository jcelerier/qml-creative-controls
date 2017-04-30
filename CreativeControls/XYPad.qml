import QtQuick 2.6
import CreativeControls 1.0

// X-Y pad
Item
{
    id: xyPad

    property alias stickX : xy.centerX
    property alias stickY : xy.centerY

    Rectangle
    {
        anchors.fill : parent
        color : Styles.detail
    }

    Crosshair
    {
        id : xy
        anchors.fill: parent
        color: Styles.base
    }

    MouseArea {
        anchors.fill: parent

        onPressed: applyPos();
        onPositionChanged: applyPos()

        onDoubleClicked: stickX = stickY = 0.5;


        function applyPos()
        {
            stickX = Utils.clamp(mouseX, 0, xyPad.width) / width;
            stickY = Utils.clamp(mouseY, 0, xyPad.height) / height;
        }
    }

}
