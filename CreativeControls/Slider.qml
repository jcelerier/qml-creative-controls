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

    color : Styles.detail
    border.width : handleWidth
    border.color : handleColor

    radius : Styles.cornerRadius

    width : 100
    height : 200

    onWidthChanged: handle.updateHandle();
    onHeightChanged: handle.updateHandle();

    // the value is between 0 and 1.
    property real value : initialValue;
    property real initialValue : 0.5

    // value mapping
    property var mapFunc : function(linearVal){return linearVal}

    // handle width and color
    property real handleWidth : Math.min(slider.width,slider.height) * 1./15//bVertical ? height / 20 : width / 20
    property alias handleColor : handle.color

    // vertical (Qt.Vertical) or horizontal (Qt.Horizontal) slider
    property int orientation : Qt.Vertical //Qt.Horizontal


    property bool __updating: false

    property var linearMap: function()
    {
        var mappedVal = 0.;
        var borderW = border.width;

        if(orientation == Qt.Vertical)
            mappedVal = 1.0 - (handle.y - borderW) / (valueRange.y - valueRange.x);
        else if(orientation == Qt.Horizontal)
            mappedVal = (handle.x - borderW) /  (valueRange.y - valueRange.x);

        return Utils.clamp(mappedVal.toFixed(2),0.,1.);
    }

    // slider value range
    property point valueRange : orientation == Qt.Vertical?
                                    Qt.point( border.width, slider.height - border.width - handleWidth)
                                  : Qt.point( border.width, slider.width - border.width - handleWidth)

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
        handle.y = (orientation == Qt.Vertical)? Utils.clamp(mouseY, valueRange.x , valueRange.y ) :  handle.y ;
        handle.x = (orientation == Qt.Horizontal)? Utils.clamp(mouseX, valueRange.x ,valueRange.y ) :  handle.x ;
        // __updating = false;
    }

    function reset(){
        slider.value = slider.initialValue;
        handle.updateHandle();
    }
    Rectangle
    {
        id: handle

        anchors.verticalCenter: orientation == Qt.Horizontal? parent.verticalCenter : undefined
        anchors.horizontalCenter: orientation == Qt.Vertical? parent.horizontalCenter : undefined

        color :  Styles.base

        width : orientation == Qt.Vertical? slider.width : handleWidth
        height : orientation == Qt.Vertical? handleWidth : slider.height

        radius : Styles.cornerRadius

        x: orientation == Qt.Horizontal ? Utils.rescale(slider.initialValue, 0,1.,valueRange.x,valueRange.y) : 0;
        onXChanged : {if(!resize) slider.value = mapFunc(linearMap());}

        Behavior on x {enabled : handle.ease; NumberAnimation {easing.type : Easing.OutQuint}}

        y : orientation == Qt.Vertical ? Utils.rescale(slider.initialValue, 0,1.,valueRange.x,valueRange.y) : 0;
        onYChanged : {if(!resize) slider.value = mapFunc(linearMap());}

        Behavior on y {enabled : handle.ease; NumberAnimation {easing.type : Easing.OutQuint}}

        property bool ease : true
        property bool resize : false

        function updateHandle()
        {
            ease = false;
            resize = true;

            var mappedValue = Utils.rescale(slider.value, 0,1.,valueRange.x,valueRange.y);
            x = orientation == Qt.Horizontal ? mappedValue : 0;
            y = orientation == Qt.Vertical ? mappedValue : 0;
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
        color : handleColor
    }
}
