import QtQuick 2.6
import CreativeControls 1.0

// A simple toggle switch.

// Signal:
// * toggle(): signal, on toggled
// Function:
// * switchState(): changes the switch state (on or off)

Rectangle
{
    id: toggleSwitch

    width : 50
    height : 50
    radius : width/2

    property var styles: DarkStyle

    border.color : styles.borderColor
    border.width : width/10.

    color : (toggleSwitch.state == "ON")? styles.colorOn : styles.colorOff
    property bool ease : true
    Behavior on color{enabled: ease; ColorAnimation{easing.type : Easing.InOutQuint}}

    signal toggle(bool onoff)
    function switchState(){ toggleSwitch.state = (toggleSwitch.state == "ON")? "OFF" : "ON" }


    TouchArea
    {
        anchors.fill : parent
        onPressed : {
            toggleSwitch.switchState();
            toggle(toggleSwitch.state == "ON");
        }
    }

    state : "OFF"
    states: [
        State {name : "ON"},
        State {name : "OFF"}
    ]
}
