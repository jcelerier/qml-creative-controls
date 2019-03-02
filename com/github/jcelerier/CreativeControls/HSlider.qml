import QtQuick 2.6
import com.github.jcelerier.CreativeControls 1.0


// A simple slider

// Properties:
// * value: the slider value, between 0 and 1
// * initialValue: the slider's initial value
// * mapFunc:
//      function to apply on the slider value
//      which is already scaled linearly between 0 and 1
// * orientation: vertical / horizontal
// * text : the text to display on the slider
Rectangle {
    id: slider

    width: 200
    height: 100
    onWidthChanged: updateHandle()
    onHeightChanged: updateHandle()

    property var styles: DarkStyle

    color: styles.sliderBackgroundColor
    border {
        width: height / 25.
        color: styles.sliderBackgroundColor
    }

    radius: styles.cornerRadius

    function updateHandle() {
        handle.update()
    }

    property alias ease: handle.ease
    property alias interactive: mouseArea.enabled

    // the value is between 0 and 1.
    property real value
    //: initialValue;
    property real initialValue: 0.5

    // value mapping
    property var mapFunc: function (linearVal) {
        return linearVal
    }

    // handle color
    property alias handleColor: handle.color

    property bool __updating: false

    property var linearMap: function () {
        var mappedVal = 0.
        var borderW = border.width

        mappedVal = handle.width / (slider.width - 2. * borderW)

        return Utils.clamp(mappedVal.toFixed(2), 0., 1.)
    }

    // by reseting, the handle width and height are initialized according to the initalValue
    Component.onCompleted: reset()

    // function called when updating the value from outside
    function updateValue() {
        // TODO use a function instead so that one can use linear, or log, or whatever mapping.
        if (!__updating) {
            slider.value = mapFunc()
        }
    }

    // called when a mouse event (onPressed / onPositionChanged) is detected
    // moves the slider's handle to the mouse position
    function moveHandle(mouseX, mouseY) {
        handle.width = Utils.clamp(mouseX, 0, slider.width - 2. * slider.border.width)
        // __updating = false;
    }

    function reset() {
        slider.value = slider.initialValue
        updateHandle()
    }

    Rectangle {
        id: handle

        x: slider.border.width
        y: slider.border.width

        height: slider.height - slider.border.width * 2

        color: mouseArea.pressed ? styles.pressedHandleColor : styles.handleColor

        onWidthChanged: {
            if (!resize)
                slider.value = mapFunc(linearMap())
        }
        Behavior on width {
            enabled: handle.ease
            NumberAnimation {
                duration: 100
            }
        }

        property bool ease: false
        property bool resize: false

        function update() {
            resize = true
            handle.width = slider.value * (slider.width - 2. * slider.border.width)
        }
    }

    MouseArea {
        id: mouseArea
        anchors.fill: parent

        onPressed: {
            __updating = true
            handle.ease = true
            handle.resize = false
            moveHandle(mouseX, mouseY)
        }

        onPositionChanged: {
            handle.ease = false
            handle.resize = false
            moveHandle(mouseX, mouseY)
        }

        onReleased: __updating = false

        onDoubleClicked: slider.reset()
    }

    // label
    property alias textVisible: label.visible
    property alias text: label.text

    Label {
        id: label
        text: slider.value.toFixed(2)
        selected: mouseArea.pressed
        styles: slider.styles

        anchors {
            verticalCenter: slider.verticalCenter
        }
        property real margin: 5

        // the label is always on top of the handle
        x: Utils.clamp(
               handle.width + slider.border.width + margin,
               slider.border.width,
               slider.width - slider.border.width - label.width - margin)
    }
}
