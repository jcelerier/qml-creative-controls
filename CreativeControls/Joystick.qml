import QtQuick 2.6
import CreativeControls 1.0

// A round 2D touch area. The ballpen automatically returns to center upon release.
Rectangle
{
    id: pad
    color: Styles.base
    radius: 100
    height: radius * 2
    width: height
    state: "default"


    Rectangle
    {
        id: stick
        color: Styles.detail
        radius: 10
        height: radius* 2
        width: height

    }

    MouseArea
    {
        id: area
        anchors.fill: parent
        onPressed: {
            pad.state = "move"
            stick.x = mouseX - stick.radius;
            stick.y = mouseY - stick.radius;
        }

        onPositionChanged: {
            var newX = mouseX - stick.radius ;
            var newY = mouseY - stick.radius ;

            var dist = Utils.distance(0,0, newX - pad.radius,newY- pad.radius)
            var theta = Math.atan2(newY - pad.radius, newX - pad.radius);

            var radius = Utils.clamp(dist, 0,pad.radius - stick.radius) ;

            stick.x = radius* Math.cos(theta) + pad.radius - stick.radius
            stick.y = radius * Math.sin(theta) + pad.radius - stick.radius

        }
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
