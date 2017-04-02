import QtQuick 2.6

// A round 2D touch area. The ballpen automatically returns to center upon release.
Item
{
    height: 500
    width: 400

    function clamp(min, max) {
      return Math.min(Math.max(this, min), max);
    }
    property color base: "#666666"
    property color detail: "#99BB99"
    Rectangle
    {
        id: pad
        color: base
        radius: 100
        height: radius * 2
        width: height
        state: "default"

        Rectangle
        {
            id: stick
            color: detail
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
                stick.x = mouseX - stick.radius / 2
                stick.y = mouseY - stick.radius / 2
            }
            onPositionChanged: {
                stick.x = mouseX - stick.radius / 2
                stick.y = mouseY - stick.radius / 2
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
}
