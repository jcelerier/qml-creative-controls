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

    color : Styles.background
    border.width : orientation ==  Qt.Vertical ? width / 25. : height / 25.
    border.color : Styles.background

    radius : Styles.cornerRadius

    // the value is between 0 and 1.
    property real value //: initialValue;
    property real initialValue : 0.5

    // value mapping
    property var mapFunc : function(linearVal){return linearVal}

    // handle color
    property alias handleColor : handle.color

    // vertical (Qt.Vertical) or horizontal (Qt.Horizontal) slider
    property int orientation : Qt.Horizontal


    property bool __updating: false

    property var linearMap: function()
    {
        var mappedVal = 0.;
        var borderW = border.width;

        if(orientation == Qt.Vertical)
            mappedVal = handle.height / (slider.height - 2.*borderW);
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
                    Utils.clamp(slider.height - mouseY,0,slider.height -slider.border.width) - slider.border.width
                  :  handle.height ;
        handle.width = (orientation == Qt.Horizontal)?
                   Utils.clamp(mouseX,0,slider.width - slider.border.width) - slider.border.width
                  : handle.width ;
        // __updating = false;
    }

    function reset(){
        slider.value = slider.initialValue;
        handle.updateHandle();
    }

    Rectangle
    {
        id: handle

        x:  slider.border.width
        y: (orientation == Qt.Vertical) ?  slider.height - handle.height -slider.border.width: slider.border.width

        color :  Styles.colorOn
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

            if(orientation == Qt.Horizontal)
            {
                handle.width = slider.value * (slider.width - 2. * slider.border.width);
                handle.height = slider.height - 2.*slider.border.width;
            }
            else
            {
                handle.width = slider.width - 2. * slider.border.width;
                handle.height = slider.value * (slider.height - 2. * slider.border.width);
            }
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
        text : value
        anchors.centerIn: slider

        font.bold: true
        color : Styles.colorOff
    }

}
