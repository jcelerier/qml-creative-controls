import QtQuick 2.6
import CreativeControls 1.0

// A round 2D touch area. The ballpen automatically returns to center upon release.
Rectangle
{
    id: pad
    color: Styles.base

    state: "default"


    width : Math.max(parent.width,parent.height)
    height: Math.max(parent.width,parent.height)
    radius: Math.max(parent.width,parent.height)/2

    Rectangle
    {
        id: stick
        color: Styles.detail
        radius: pad.radius / 10
        height: radius* 2
        width: height

    }

    function moveStick(mouseX,mouseY)
    {
        var dist = Utils.distance(0,0, mouseX - pad.radius,mouseY- pad.radius);
        var theta = Math.atan2(mouseY - pad.radius, mouseX - pad.radius);

        var radius = Utils.clamp(dist, 0,pad.radius - stick.radius) ;

        stick.x = radius* Math.cos(theta) + pad.radius- stick.radius;
        stick.y = radius * Math.sin(theta) + pad.radius- stick.radius;
    }

    MouseArea
    {
        id: area
        anchors.fill: parent
        onPressed: {
            pad.state = "move"
            moveStick(mouseX,mouseY);
        }

        onPositionChanged: moveStick(mouseX,mouseY)
        onReleased: pad.state = "default"
    }

    states: [ State {
            id: def
            name: "default"
            AnchorChanges
            {
                target: stick
                anchors.horizontalCenter: pad.horizontalCenter
                anchors.verticalCenter: pad.verticalCenter
            }
        }, State {
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
