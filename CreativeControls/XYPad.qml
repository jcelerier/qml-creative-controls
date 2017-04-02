import QtQuick 2.6
import CreativeControls 1.0

// X-Y pad
Rectangle
{
    anchors.fill: parent
    color: Styles.base
    radius: Styles.cornerRadius
    property real ballsX : width / 2
    property real ballsY : height / 2
    Canvas
    {
        id: cv
        anchors.fill: parent
        onPaint: {
            var ctx = getContext("2d");
            ctx.reset();

            ctx.strokeStyle = Styles.detail
            ctx.fillStyle = Styles.detail
            ctx.lineWidth = 2

            ctx.beginPath();
            ctx.moveTo(0, ballsY)
            ctx.lineTo(width, ballsY)
            ctx.moveTo(ballsX, 0)
            ctx.lineTo(ballsX, height)

            ctx.stroke();
            ctx.closePath();

            ctx.arc(ballsX, ballsY, 10, 0, 2 * Math.PI, false);

            ctx.fill();
        }
    }

    MouseArea {
        function applyPos()
        {
            ballsX = Utils.clamp(mouseX, 0, width);
            ballsY = Utils.clamp(mouseY, 0, height);
            cv.requestPaint();
        }

        anchors.fill: parent
        onPressed: applyPos()
        onPositionChanged: applyPos()
        onReleased: applyPos()
    }

}
