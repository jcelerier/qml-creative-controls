import QtQuick 2.6
import com.github.jcelerier.CreativeControls 1.0


// A simple toggle switch.

// Signal:
// * pressed(): signal, on pressed
// * released(): signal, on released
Rectangle {
    id: pressSwitch

    width: 50
    height: 50
    radius: width / 2

    property var styles: DarkStyle

    border.color: styles.borderColor
    border.width: width / 10.

    color: (pressSwitch.state == "ON") ? styles.colorOn : styles.colorOff
    property bool ease: true
    Behavior on color {
        enabled: ease
        ColorAnimation {
            easing.type: Easing.OutQuint
        }
    }

    signal pressed
    signal released

    TouchArea {
        anchors.fill: parent
        onPressed: {
            pressSwitch.pressed()
            pressSwitch.state = "ON"
        }
        onReleased: {
            pressSwitch.released()
            pressSwitch.state = "OFF"
        }
    }
    state: "OFF"
    states: [
        State {
            name: "ON"
        },
        State {
            name: "OFF"
        }
    ]
}
