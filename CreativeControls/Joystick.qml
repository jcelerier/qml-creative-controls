import QtQuick 2.6
import com.github.jcelerier.CreativeControls 1.0


// A round 2D touch area. The ballpen automatically returns to center upon release.
// Properties:
// * stickX / stickY : the position of the stick between [-1; 1]
// * stickR : the distance of the stick to the center between [0; 1]
// * stickAngle : the angle in degrees; 0 is at the right, 90 at the top.
Rectangle {
    id: pad

    width: 200
    height: 200
    radius: Math.max(width, height) / 2

    property var styles: DarkStyle
    color: styles.background

    state: "default"

    border {
        color: styles.base
        width: 5.
    }

    property real stickX: 0
    property real stickY: 0
    property real stickR: 0
    property real stickTheta: 0

    function moveStick(mouseX, mouseY) {
        var dist = Utils.distance(0, 0, mouseX - pad.radius,
                                  mouseY - pad.radius)
        stickTheta = mouseY === pad.radius
                && mouseX === pad.radius ? 0 : Math.atan2(mouseY - pad.radius,
                                                          mouseX - pad.radius)
        var radius = Utils.clamp(dist, 0, pad.radius - stick.radius)

        stick.x = radius * Math.cos(stickTheta) + pad.radius - stick.radius
        stick.y = radius * Math.sin(stickTheta) + pad.radius - stick.radius

        // rescale between 0 and 1
        stickX = Utils.rescale(stick.x, 0, pad.width - stick.width, -1.00, 1.00)
        stickY = -Utils.rescale(stick.y, 0, pad.height - stick.height, -1, 1)
        stickR = Utils.distance(stickX, stickY, 0, 0)
    }

    function releaseStick() {
        stickX = 0
        stickY = 0
        stickTheta = 0
        stickR = 0
    }

    Rectangle {
        id: stick
        color: pad.state === "move" ? styles.colorOn : styles.base
        radius: pad.state === "move" ? pad.radius / 6 * 1.1 : pad.radius / 6
        height: radius * 2
        width: height
    }

    TouchArea {
        id: area
        anchors.fill: parent
        onPressed: {
            pad.state = "move"
            moveStick(point.x, point.y)
        }

        onPositionChanged: moveStick(point.x, point.y)
        onReleased: {
            pad.state = "default"
            releaseStick()
        }
    }

    states: [
        State {
            id: def
            name: "default"
            AnchorChanges {
                target: stick
                anchors.horizontalCenter: pad.horizontalCenter
                anchors.verticalCenter: pad.verticalCenter
            }
        },
        State {
            id: move
            name: "move"
            AnchorChanges {
                target: stick
                anchors.horizontalCenter: undefined
                anchors.verticalCenter: undefined
            }
        }
    ]

    transitions: Transition {
        AnchorAnimation {
            duration: 50
        }
    }
}
