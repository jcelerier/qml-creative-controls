import QtQuick 2.6
import CreativeControls 1.0
import QtGraphicalEffects 1.0

// arc slider

Rectangle
{
    id: arcSlider
    anchors.fill : parent

    radius : width /2.

    color : "transparent"
    property color background : getColor(1.0)

    property real innerRadius : radius * 0.5
    property real channels : 3
    property real num : 1

    property real angleStart : num * 2 * Math.PI / channels
    property real angleEnd : (num+1) * 2 * Math.PI / channels

    property real value : (angle * Math.PI/180. - angleStart) / (angleEnd - angleStart)

    property var metric: Qt.rgba//function(){return Qt.rgba()}

    property real angle : 180 / Math.PI * (arcSlider.angleStart + arcSlider.angleEnd) * 0.5
    Behavior on angle
    {
        id: easing
        NumberAnimation{easing.type : Easing.InOutCubic}
    }

    function moveHandle(newAngle)
    {

        arcSlider.angle = 180 / Math.PI * newAngle;
        canvas.requestPaint();
    }



    function getColor(c)
    {
        switch(num)
        {
        case 0:
            return metric(c+0.3,0.,0.,1.);
        case 1:
            return metric(0.,c+0.3,0.,1.);
        case 2:
            return metric(0.,0.,c+0.3,1.);
        default :
            return "transparent";
        }
    }

    function reset()
    {
        moveHandle((arcSlider.angleStart + arcSlider.angleEnd)*0.5);
    }

    Canvas
    {
        id : canvas
        anchors.fill: parent
        antialiasing: true
        //anchors.fill : parent

        onPaint:
        {
            var ctx = getContext("2d")
            ctx. reset();

            ctx.clearRect(0, 0, canvas.width, canvas.height);
            ctx.lineWidth = 0;

            var center = arcSlider.innerRadius+ (arcSlider.radius-arcSlider.innerRadius)*0.5;
            var grd = ctx.createLinearGradient( arcSlider.radius + center * Math.cos(arcSlider.angleStart),
                                               arcSlider.radius + center * Math.sin(arcSlider.angleStart),
                                               arcSlider.radius + center * Math.cos(arcSlider.angleEnd),
                                               arcSlider.radius + center * Math.sin(arcSlider.angleEnd));
            var origin = Qt.point(canvas.width/2., canvas.height/2.);

            for(var i = 0; i < 50 ; i++)
            {
                grd.addColorStop(i/50., arcSlider.getColor(i/50.));
            }

            ctx.strokeStyle = grd;
            ctx.fillStyle = grd;

            ctx.lineWidth = 1;
            ctx.lineCap = "round";
            ctx.lineJoin = "round";

            ctx.beginPath();
            ctx.arc(origin.x, origin.y,arcSlider.innerRadius, arcSlider.angleStart, arcSlider.angleEnd);
            ctx.arc(origin.x, origin.y,arcSlider.radius, arcSlider.angleEnd, arcSlider.angleStart-2.*Math.PI );
            ctx.closePath();

            ctx.fill();

            ctx.lineWidth = 10;

            ctx.beginPath();

            var perimeter = 2. * Math.PI * (0.7 * arcSlider.radius) *  (arcSlider.angleEnd - arcSlider.angleStart) /( 2. * Math.PI);
            var angleOffset = (ctx.lineWidth*0.5) / perimeter * (arcSlider.angleEnd - arcSlider.angleStart);
            var clampedAngle = Utils.clamp(Math.PI /180. * arcSlider.angle,
                                           arcSlider.angleStart + angleOffset,
                                           arcSlider.angleEnd - angleOffset);
            var angleToDeg = Math.PI /180. * arcSlider.angle;
            ctx.moveTo(origin.x + 0.7 * arcSlider.radius * Math.cos(clampedAngle) ,
                       origin.y + 0.7 * arcSlider.radius * Math.sin(clampedAngle));
            ctx.lineTo(origin.x + 0.7 * arcSlider.radius * Math.cos(clampedAngle)
                       - 0.5 * arcSlider.radius * Math.cos(clampedAngle),
                       origin.y + 0.7 * arcSlider.radius * Math.sin(clampedAngle)
                       -0.5 * arcSlider.radius * Math.sin(clampedAngle));
            ctx.stroke();
            ctx.fill();


        }
    }

    MouseArea
    {
        anchors.fill : parent

        onPressed :
        {
            //easing.enabled = true;
            var angleRad = Math.atan2(mouseY - arcSlider.radius, mouseX - arcSlider.radius) ; //+ (2.* Math.PI);
            angleRad += angleRad < 0 ? 2.*Math.PI : 0;
            //  angleRad = Utils.clamp(angleRad,arcSlider.angleStart, arcSlider.angleEnd ); //+ (2.* Math.PI);

            if(angleRad >= arcSlider.angleStart
                    && angleRad <= arcSlider.angleEnd )
            {
                moveHandle(angleRad);
                mouse.accepted = true;
            }
            else
                mouse.accepted = false;
        }

        onPositionChanged:
        {
            easing.enabled = false;
            var angleRad = Math.atan2(mouseY - arcSlider.radius, mouseX - arcSlider.radius);

            angleRad+= angleRad < 0. ? 2.*Math.PI : 0;
            angleRad = Utils.clamp(angleRad,arcSlider.angleStart, arcSlider.angleEnd ); //+ (2.* Math.PI);
            if(angleRad > arcSlider.angleStart
                    && angleRad < arcSlider.angleEnd )
            {
                moveHandle(angleRad);
            }

        }
        onDoubleClicked: reset();
    }

}
