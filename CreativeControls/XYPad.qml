import QtQuick 2.6
import CreativeControls 1.0

// X-Y pad
Item
{
    id: xyPad

    width : 200
    height : 200

    property alias stickX : xy.centerX
    property alias stickY : xy.centerY

    Rectangle
    {
        anchors.fill : parent
        color : Styles.background
    }

    Crosshair
    {
        id : xy
        anchors.fill: parent
        color: Styles.colorOn
    }

    TouchArea {
        anchors.fill: parent

        onPressed: applyPos(point);
        onPositionChanged: applyPos(point)

        onDoubleClicked: stickX = stickY = 0.5;

        function applyPos(point)
        {
            stickX = Utils.clamp(point.x, 0, xyPad.width) / width;
            stickY = Utils.clamp(point.y, 0, xyPad.height) / height;
        }
    }
}
