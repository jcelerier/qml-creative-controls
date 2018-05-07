import QtQuick 2.6
import com.github.jcelerier.CreativeControls 1.0

// A round 2D touch area. The ballpen automatically returns to center upon release.
// Properties:
// * stickX / stickY : the position of the stick between [-1; 1]
// * stickR : the distance of the stick to the center between [0; 1]
// * stickAngle : the angle in degrees; 0 is at the right, 90 at the top.

Rectangle
{
    id: pad

    width : 200
    height : 200
    radius: Math.max(width, height) / 2

    property var styles: DarkStyle
    color: styles.background

    state: "default"


    border.color: styles.base
    border.width: 5.

    property real stickX: Utils.rescale(stick.x,0,pad.width - stick.width,-1,1)
    property real stickY: Utils.rescale(stick.y,0,pad.height - stick.height,-1,1)
    property real stickR: Utils.distance(stickX, stickY, 0, 0)
    property real stickTheta: Math.atan2(stick.y + stick.radius - pad.radius,
                                         stick.x + stick.radius- pad.radius);

    function moveStick(mouseX,mouseY)
    {
        var dist = Utils.distance(0,0, mouseX - pad.radius,mouseY- pad.radius);
        var theta = Math.atan2(mouseY - pad.radius, mouseX - pad.radius);
        var radius = Utils.clamp(dist, 0,pad.radius - stick.radius) ;

        stick.x = radius * Math.cos(theta) + pad.radius - stick.radius;
        stick.y = radius * Math.sin(theta) + pad.radius - stick.radius;
    }


    Rectangle
    {
        id: stick
        color: pad.state === "move" ? styles.colorOn : styles.base
        radius: pad.state === "move" ? pad.radius / 6 * 1.1 : pad.radius / 6
        height: radius* 2
        width: height
    }

    TouchArea
    {
        id: area
        anchors.fill: parent
        onPressed: {
            pad.state = "move"
            moveStick(point.x, point.y);
        }

        onPositionChanged: moveStick(point.x, point.y)
        onReleased: pad.state = "default"
    }


    states: [
        State {
            id: def
            name: "default"
            AnchorChanges
            {
                target: stick
                anchors.horizontalCenter: pad.horizontalCenter
                anchors.verticalCenter: pad.verticalCenter
            }
        },
        State {
            id: move
            name: "move"
            AnchorChanges
            {
                target: stick
                anchors.horizontalCenter: undefined
                anchors.verticalCenter: undefined
            }
        }
    ]

    transitions: Transition {
        AnchorAnimation { duration: 50 }
    }

}
