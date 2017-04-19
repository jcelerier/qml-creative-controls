import QtQuick 2.6
import CreativeControls 1.0

// X-Y pad
Item
{
    property real stickX : 0.5
    property real stickY : 0.5

    onWidthChanged: cv.requestPaint()
    onHeightChanged: cv.requestPaint()
    onStickXChanged: cv.requestPaint()
    onStickYChanged: cv.requestPaint()

    Canvas
    {
        id: cv
        anchors.fill: parent
        onPaint: {
            var ctx = getContext("2d");
            ctx.reset();

            var xpos = stickX * width;
            var ypos = stickY * height;
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
            stickX = Utils.clamp(mouseX, 0, width) / width;
            stickY = Utils.clamp(mouseY, 0, height) / height;
            cv.requestPaint();
        }

        anchors.fill: parent
        onPressed: applyPos()
        onPositionChanged: applyPos()
        onReleased: applyPos()
    }

}
