import QtQuick 2.6
import CreativeControls 1.0

// X-Y pad
Item
{
    anchors.fill: parent
    property real centerX : 0.5
    property real centerY : 0.5

    onWidthChanged: cv.requestPaint()
    onHeightChanged: cv.requestPaint()
    onCenterXChanged: cv.requestPaint()
    onCenterYChanged: cv.requestPaint()

    Canvas
    {
        id: cv
        anchors.fill: parent
        onPaint: {
            var ctx = getContext("2d");
            ctx.reset();

            var xpos = centerX * width;
            var ypos = centerY * height;
            ctx.strokeStyle = Styles.detail
            ctx.fillStyle = Styles.detail
            ctx.lineWidth = 2

            ctx.beginPath();
            ctx.moveTo(0, ypos)
            ctx.lineTo(width, ypos)
            ctx.moveTo(xpos, 0)
            ctx.lineTo(xpos, height)

            ctx.stroke();
            ctx.closePath();

            ctx.arc(xpos, ypos, 10, 0, 2 * Math.PI, false);

            ctx.fill();
        }
    }

    MouseArea {
        function applyPos()
        {
            centerX = Utils.clamp(mouseX, 0, width) / width;
            centerY = Utils.clamp(mouseY, 0, height) / height;
            cv.requestPaint();
        }

        anchors.fill: parent
        onPressed: applyPos()
        onPositionChanged: applyPos()
        onReleased: applyPos()
    }

}
