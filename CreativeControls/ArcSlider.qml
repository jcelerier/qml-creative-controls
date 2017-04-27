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
    property real num : 0

    property real angleStart : num *2*Math.PI /channels
    property real angleEnd : (num+1) *2*Math.PI /channels

    property real value : (angle*Math.PI/180. - angleStart)/(angleEnd -angleStart)

    property var metric: Qt.rgba//function(){return Qt.rgba()}

    property real angle : 180 / Math.PI * (arcSlider.angleStart + arcSlider.angleEnd)*0.5
    Behavior on angle
    {
        id: easing
        NumberAnimation{easing.type : Easing.InOutCubic}
    }

    function moveHandle(newAngle )
    {
        arcSlider.angle = 180 / Math.PI *
                Math.min(Math.max((newAngle),
                                  arcSlider.angleStart),
                         arcSlider.angleEnd);

        handleColor = arcSlider.getColor(value);
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

    property color handleColor : arcSlider.getColor(value);//Styles.base
    Rectangle
   {
       id : handle

       x: arcSlider.x + arcSlider.radius
       y: arcSlider.y + arcSlider.radius - height/2.
       width : arcSlider.radius
       height : 5
       color : handleColor

       transform: Rotation{id :rotation
           origin.x : 0 ;
           origin.y : handle.height/2.;
           angle: arcSlider.angle}

   }

    Canvas
    {
        id : canvas
        anchors.fill: parent
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
            for(var i = 0; i < 50 ; i++)
            {
                grd.addColorStop(i/50., arcSlider.getColor(i/50.));
            }

            ctx.strokeStyle = grd;//arcSlider.background ;
            ctx.fillStyle = grd;
            ctx.beginPath()
            ctx.lineCap= "round";
            ctx.lineJoin = "round";

            var origin = Qt.point(canvas.width/2., canvas.height/2.);

            ctx.arc(origin.x, origin.y,arcSlider.innerRadius,arcSlider.angleStart,arcSlider.angleEnd);
            ctx.arc(origin.x, origin.y,arcSlider.radius,arcSlider.angleEnd,arcSlider.angleStart-2.*Math.PI );
            ctx.closePath();

            ctx.fill();
            ctx.stroke();

        }
    }


    MouseArea
    {
        anchors.fill : parent
        propagateComposedEvents: true
        onPressed :
        {
            easing.enabled = true;

            var dist = Utils.distance(mouseX,mouseY, handle.x, handle.y);
            var angleRad = Math.atan2(mouseY - handle.y, mouseX - handle.x) ; //+ (2.* Math.PI);
            angleRad += angleRad < 0 ? 2.*Math.PI : 0;
            if(dist < arcSlider.radius
                    && dist > arcSlider.innerRadius
                    && angleRad > arcSlider.angleStart
                    && angleRad < arcSlider.angleEnd )
            {
                moveHandle(angleRad);
                mouse.accepted = true
            }
            else
                mouse.accepted = false;
        }
        onPositionChanged:
        {
            easing.enabled = false;
            var angleRad = Math.atan2(mouseY - handle.y, mouseX - handle.x) ; //+ (2.* Math.PI);
            angleRad += angleRad < 0 ? 2.*Math.PI : 0;
            moveHandle(angleRad);
        }
        onDoubleClicked: reset();
    }

}
