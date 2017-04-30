import QtQuick 2.6
import CreativeControls 1.0

// A simple slider

// Properties:
// * value: the slider value, between 0 and 1
// * initialValue: the slider's initial value
// * mapFunc:
//      function to apply on the slider value
//      which is already scaled linearly between 0 and 1
// * orientation: vertical / horizontal
// * text : the text to display on the slider

Rectangle
{
    id: slider

    width : 100
    height : 200
    onWidthChanged: handle.updateHandle();
    onHeightChanged: handle.updateHandle();

    color : Styles.detail
    border.width : width /35.
    border.color : handleColor

    radius : Styles.cornerRadius

    // the value is between 0 and 1.
    property real value //: initialValue;
    property real initialValue : 0.5

    // value mapping
    property var mapFunc : function(linearVal){return linearVal}

    // handle color
    property alias handleColor : handle.color

    // vertical (Qt.Vertical) or horizontal (Qt.Horizontal) slider
    property int orientation : Qt.Vertical //Qt.Horizontal


    property bool __updating: false

    property var linearMap: function()
    {
        var mappedVal = 0.;
        var borderW = border.width;

        if(orientation == Qt.Vertical)
            mappedVal = 1.0 - handle.height / (slider.height - 2.*borderW);
        else if(orientation == Qt.Horizontal)
            mappedVal = handle.width /  (slider.width - 2.*borderW);

        return Utils.clamp(mappedVal.toFixed(2),0.,1.);
    }

    // by reseting, the handle width and height are initialized according to the initalValue
    Component.onCompleted: reset();

    // function called when updating the value from outside
    function updateValue()
    {
        // TODO use a function instead so that one can use linear, or log, or whatever mapping.
        if(!__updating)
        {
            slider.value = mapFunc();
        }
    }

    // called when a mouse event (onPressed / onPositionChanged) is detected
    // moves the slider's handle to the mouse position
    function moveHandle(mouseX,mouseY)
    {
        handle.height = (orientation == Qt.Vertical)?
                    Utils.clamp(mouseY, 0 , slider.height - 2.*slider.border.width) :  handle.height ;
        handle.width = (orientation == Qt.Horizontal)?
                    Utils.clamp(mouseX, 0 , slider.width - 2.*slider.border.width) : handle.width ;
        // __updating = false;
    }

    function reset(){
        slider.value = slider.initialValue;
        handle.updateHandle();
    }

    Rectangle
    {
        id: handle

        x : slider.border.width
        y: slider.border.width

        color :  Styles.base
        radius : Styles.cornerRadius

        onWidthChanged : {if(!resize) slider.value = mapFunc(linearMap());}
        Behavior on width {enabled : handle.ease; NumberAnimation {easing.type : Easing.OutQuint}}

        onHeightChanged : {if(!resize) slider.value = mapFunc(linearMap());}
        Behavior on height {enabled : handle.ease; NumberAnimation {easing.type : Easing.OutQuint}}

        property bool ease : true
        property bool resize : false

        function updateHandle()
        {
            ease = false;
            resize = true;

            handle.width = orientation == Qt.Horizontal ?  slider.value * (slider.width- 2.*slider.border.width)
                                                 : slider.width - 2.*slider.border.width;
            handle.height = orientation == Qt.Vertical ? slider.value* (slider.height- 2.*slider.border.width)
                                                : slider.height - 2.*slider.border.width;
        }
    }

    MouseArea
    {
        anchors.fill : parent

        onPressed :
        {
            __updating = true;
            handle.ease = true;
            handle.resize = false;
            moveHandle(mouseX,mouseY);
        }

        onPositionChanged: {
            handle.ease = false;
            moveHandle(mouseX,mouseY);
        }

        onReleased:  __updating = false


        onDoubleClicked: slider.reset()
    }


    // label
    property alias text : label.text
    Text
    {
        id: label
        //text : value
        anchors.centerIn: slider

        font.bold: true
        color : "black"//handleColor
    }

}
