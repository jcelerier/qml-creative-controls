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

    width : 200
    height : 200
    radius : width/2

    border.color : "#666666"//Styles.base
    border.width : width/10.

    color : (toggleSwitch.state == "ON")? Styles.colorOn : Styles.colorOff
    property bool ease : true
    Behavior on color{enabled: ease; ColorAnimation{easing.type : Easing.InOutQuint}}

    signal toggle(bool onoff)
    function switchState(){ toggleSwitch.state = (toggleSwitch.state == "ON")? "OFF" : "ON" }


    MouseArea
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
