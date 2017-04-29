import QtQuick 2.6
import CreativeControls 1.0

// A simple toggle switch.

// Property:
// * toggled: the switch state, boolean for either ON or OFF
// Function:
// * toggle(): toggle switch, by changing its state to ON or OFF

Rectangle
{
    id: toggleSwitch

    width : 200
    height : 200
    radius : width/2

    color : toggleSwitch.toggled? Styles.detail : Styles.base
    property bool ease : true
    Behavior on color{enabled: ease; ColorAnimation{easing.type : Easing.InOutQuint}}

    border.color : Styles.base
    border.width : width/10.

    property bool toggled : toggleSwitch.state == "ON"
    function toggle(){toggleSwitch.state = toggleSwitch.toggled? "OFF" : "ON"}

    MouseArea
    {
        anchors.fill : parent
        onPressed : toggleSwitch.toggle()
    }

    state : "OFF"
    states: [
        State {name : "ON"},
        State {name : "OFF"}
    ]
}
