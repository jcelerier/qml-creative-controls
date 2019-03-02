import QtQuick 2.6
import com.github.jcelerier.CreativeControls 1.0


// A simple toggle switch.

// Signal:
// * toggle(): signal, on toggled
// Function:
// * switchState(): changes the switch state (on or off)
Rectangle {
    id: toggleSwitch

    width: 100
    height: 50
    radius: height

    property var styles: DarkStyle

    border.color: styles.borderColor
    border.width: width / 20

    color: (toggleSwitch.state == "ON") ? styles.colorOn : styles.colorOff
    property bool ease: true
    Behavior on color {
        enabled: ease
        ColorAnimation {
            easing.type: Easing.InOutQuint
        }
    }

    signal toggle(bool onoff)
    function switchState() {
        toggleSwitch.state = (toggleSwitch.state == "ON") ? "OFF" : "ON"
    }

    Rectangle {
        id: toggleHandle

        height: toggleSwitch.height - toggleSwitch.border.width * 2

        width: height
        radius: width / 2
        color: styles.borderColor

        x: (toggleSwitch.state == "ON")
           ? toggleSwitch.width - toggleHandle.width - toggleSwitch.border.width
           : toggleSwitch.border.width
        anchors.verticalCenter: parent.verticalCenter
        Behavior on x {
            enabled: toggleSwitch.ease
            NumberAnimation {
                easing.type: Easing.InOutQuint
            }
        }
    }

    TouchArea {
        anchors.fill: parent
        onPressed: {
            toggleSwitch.switchState()
            toggle(toggleSwitch.state == "ON")
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
