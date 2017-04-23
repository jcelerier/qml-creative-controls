import QtQuick 2.6
import CreativeControls 1.0

// X-Y pad
Item
{
    id: xyPad


    property alias centerX : xy.centerX
    property alias centerY : xy.centerY

    Crosshair
    {
        id : xy
        anchors.fill: parent
        color: Styles.detail
    }

    MouseArea {
        anchors.fill: parent

        onPressed: applyPos()
        onPositionChanged: applyPos()
        onReleased: applyPos()

        function applyPos()
        {
            centerX = Utils.clamp(mouseX, 0, xyPad.width) / width;
            centerY = Utils.clamp(mouseY, 0, xyPad.height) / height;
        }
    }

}
