import QtQuick 2.6
import com.github.jcelerier.CreativeControls 1.0
import QtGraphicalEffects 1.0


// arc slider
Rectangle {
    id: arcSlider
    width: 200
    height: width
    onWidthChanged: canvas.requestPaint()
    onHeightChanged: canvas.requestPaint()

    radius: width / 2.

    color: "transparent"

    property real innerRadius: radius * 0.7 / 0.9 * 0.5
    property real channels: 3
    property real channelIndex: 0

    property real angleStart: channelIndex * 2 * Math.PI / channels
    property real angleEnd: (channelIndex + 1) * 2 * Math.PI / channels

    property real value: (angle * Math.PI / 180. - angleStart) / (angleEnd - angleStart)

    property var colorSpace: Qt.hsla //function(){return Qt.rgba()}

    property real angle: 180 / Math.PI * (arcSlider.angleStart + arcSlider.angleEnd) * 0.5
    Behavior on angle {
        id: easing
        enabled: false
        NumberAnimation {
            easing.type: Easing.InOutCubic
        }
    }

    function moveHandle(newAngle) {
        arcSlider.angle = 180 / Math.PI * newAngle
        canvas.requestPaint()
    }

    function getColor(c) {
        switch (channelIndex) {
        case 0:
            return colorSpace === Qt.rgba
                    ? colorSpace(c, 0., 0., 1.)
                    : colorSpace === Qt.hsva ? colorSpace(c, 1., 1.0, 1.) : colorSpace(c, 1., 0.5, 1.)
        case 1:
            return colorSpace === Qt.rgba
                    ? colorSpace(0., c, 0., 1.)
                    : colorSpace(hue, c, 0.5, 1.)
        case 2:
            return colorSpace == Qt.rgba
                    ? colorSpace(0., 0., c, 1.)
                    : colorSpace(hue, 0.5, c, 1.)
        default:
            return "transparent"
        }
    }

    property real hue: 0.

    function updateHue(h) {
        arcSlider.hue = h
        canvas.requestPaint()
    }

    function reset() {
        moveHandle((arcSlider.angleStart + arcSlider.angleEnd) * 0.5)
    }

    property bool drawHue: arcSlider.channelIndex == 0
                           && (arcSlider.colorSpace === Qt.hsla
                               || arcSlider.colorSpace === Qt.hsva)

    Canvas {
        id: canvas
        // width : parent.width *2.
        // height : parent.width *2.
        anchors.fill: parent
        antialiasing: true
        smooth: true
        visible: true

        //visible : !shader.visible
        //anchors.fill : parent
        onPaint: {
            var ctx = getContext("2d")
            ctx.reset()

            ctx.clearRect(0, 0, canvas.width, canvas.height)
            ctx.lineWidth = 0

            var center = arcSlider.innerRadius + (arcSlider.radius - arcSlider.innerRadius) * 0.5

            /*  var grd = ctx.createLinearlGradient( arcSlider.radius + center * Math.cos(arcSlider.angleStart),
                                               arcSlider.radius + center * Math.sin(arcSlider.angleStart),

                                               arcSlider.radius + center * Math.cos(arcSlider.angleEnd),
                                               arcSlider.radius + center * Math.sin(arcSlider.angleEnd));*/
            var origin = Qt.point(canvas.width / 2., canvas.height / 2.)
            var grd = ctx.createLinearGradient(
                        arcSlider.radius + center * Math.cos(arcSlider.angleStart),
                        arcSlider.radius + center * Math.sin(arcSlider.angleStart),
                        arcSlider.radius + center * Math.cos(arcSlider.angleEnd),
                        arcSlider.radius + center * Math.sin(arcSlider.angleEnd))
            for (var i = 0; i < 50; i++) {
                grd.addColorStop(i / 50., arcSlider.getColor(i / 50.))
            }

            ctx.strokeStyle = Styles.background
            ctx.fillStyle = grd

            ctx.lineWidth = 1
            ctx.lineCap = "round"
            ctx.lineJoin = "round"

            if (!arcSlider.drawHue) {
                ctx.beginPath()
                ctx.arc(origin.x, origin.y, arcSlider.innerRadius,
                        arcSlider.angleStart, arcSlider.angleEnd)
                ctx.arc(origin.x, origin.y, arcSlider.radius,
                        arcSlider.angleEnd, arcSlider.angleStart - 2. * Math.PI)
                ctx.closePath()

                //ctx.fillRect(0, 0, canvas.width, canvas.height);
                ctx.fill()
            } else {
                var nbLines = arcSlider.width / 2.
                for (var i = 0; i < nbLines; i++) {
                    var iAng = arcSlider.angleStart + i
                            * (arcSlider.angleEnd - arcSlider.angleStart) / nbLines

                    /*  var ang = Math.PI - Math.atan2(arcSlider.radius *Math.cos(iAng) - radius*2.,
                                                   arcSlider.radius *Math.sin(iAng) - radius*2.) ;
                    ang -= Math.PI/2. ;
                    ang += ang < 0. ? 2.*Math.PI : 0.;*/
                    var color = (iAng - arcSlider.angleStart)
                            / (arcSlider.angleEnd - arcSlider.angleStart)
                    ctx.strokeStyle = Qt.hsla(color, 1., 0.5, 1.0)
                    ctx.lineWidth = 3.

                    ctx.beginPath()

                    ctx.moveTo(arcSlider.radius + (arcSlider.innerRadius + ctx.lineWidth * 0.5) * Math.cos(iAng),
                               arcSlider.radius + (arcSlider.innerRadius + ctx.lineWidth * 0.5) * Math.sin(iAng))
                    ctx.lineTo(arcSlider.radius + (arcSlider.radius - ctx.lineWidth) * Math.cos(iAng),
                               arcSlider.radius + (arcSlider.radius - ctx.lineWidth) * Math.sin(iAng))
                    ctx.stroke()
                }
            }

            // if(shader.visible)ctx.stroke();
            ctx.lineWidth = 0.2 * arcSlider.innerRadius

            if (arcSlider.drawHue) {
                ctx.strokeStyle = arcSlider.getColor(arcSlider.value)
                ctx.fillStyle = arcSlider.getColor(arcSlider.value)
            } else
                ctx.strokeStyle = grd

            ctx.beginPath()

            var lineLength = 0.84 * arcSlider.innerRadius

            var perimeter = 2. * Math.PI * lineLength
                    * (arcSlider.angleEnd - arcSlider.angleStart) / (2. * Math.PI)
            var angleOffset = (ctx.lineWidth * 0.5) / perimeter
                    * (arcSlider.angleEnd - arcSlider.angleStart)
            var clampedAngle = Utils.clamp(Math.PI / 180. * arcSlider.angle,
                                           arcSlider.angleStart + angleOffset,
                                           arcSlider.angleEnd - angleOffset)
            var angleToDeg = Math.PI / 180. * arcSlider.angle
            ctx.moveTo(origin.x + (lineLength) * Math.cos(clampedAngle),
                       origin.y + (lineLength) * Math.sin(clampedAngle))
            ctx.lineTo(origin.x, origin.y)
            ctx.stroke()
            ctx.fill()
        }
    }

    function isInside(angleRad) {
        if (angleRad > arcSlider.angleStart && angleRad < arcSlider.angleEnd)
            return true
        return false
    }

    /*
    Text
    {
        x : arcSlider.radius + 0.2 * arcSlider.radius * Math.cos(Math.PI /180. * arcSlider.angle)
        y : arcSlider.radius + 0.2 * arcSlider.radius * Math.sin(Math.PI /180. * arcSlider.angle)
        color : "red"
        text : channelIndex
    }*/
}
