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

    property bool selected: false
    Rectangle
    {
        anchors.fill : parent
        color : Styles.background
    }

    Crosshair
    {
        id : xy
        anchors.fill: parent
        color: selected? Styles.base :  Styles.colorOn
        radiusScale: selected ? 25 : 35
    }

    TouchArea {
        anchors.fill: parent

        onPressed: applyPos(point);
        onPositionChanged: applyPos(point)

        onDoubleClicked: stickX = stickY = 0.5;

        onReleased: selected = false;

        function applyPos(point)
        {
            selected = true;

            stickX = Utils.clamp(point.x, 0, xyPad.width) / width;
            stickY = Utils.clamp(point.y, 0, xyPad.height) / height;
        }
    }
}
