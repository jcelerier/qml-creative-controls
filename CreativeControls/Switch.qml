import QtQuick 2.6
import CreativeControls 1.0

// A simple toggle switch.

// Property:
// * toggled: the switch state, boolean for either ON or OFF
// Function:
// * toggle(): toggle switch, by changing its state to ON or OFF
// * onOn(): function called on switch toggled on
// * onOff(): function called on switch toggled off
Rectangle
{
    id: toggleSwitch

    width : 200
    height : 200
    radius : width/2

    color : (toggleSwitch.state == "ON")? Styles.detail : Styles.base
    property bool ease : true
    Behavior on color{enabled: ease; ColorAnimation{easing.type : Easing.InOutQuint}}

    border.color : Styles.base
    border.width : width/10.

   // property bool toggled : toggleSwitch.state == "ON"
 //   onToggledChanged: {toggled ? onOn(): onOff()}
   function switchState(){ toggleSwitch.state = (toggleSwitch.state == "ON")? "OFF" : "ON" }

 //   property var onOn: function(){console.log("ON")}
 //   property var onOff:function (){console.log("OFF")}

    signal toggle(bool onoff)

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
