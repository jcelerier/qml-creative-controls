import QtQuick 2.6
import com.github.jcelerier.CreativeControls 1.0


// Slider with a min and max
Rectangle {
    id: rangeSlider

    width: 100
    height: 200
    // onWidthChanged: handle.updateHandle();
    // onHeightChanged: handle.updateHandle();
    property var styles: DarkStyle

    color: styles.sliderBackgroundColor
    border {
        width: width / 25.
        color: styles.sliderBackgroundColor
    }
    radius: styles.cornerRadius

    // the value is between 0 and 1.
    property real value

    //: initialValue;
    property real minValue: initialMinValue
    property real maxValue: initialMaxValue

    property real initialMinValue: 0.4
    property real initialMaxValue: 0.8

    // value mapping
    property var mapFunc: function (linearVal) {
        return linearVal
    }

    property bool __updating: false

    // by reseting, the handle width and height are initialized according to the initalValue
    Component.onCompleted: reset()

    // function called when updating the value from outside
    function updateValue() {
        // TODO use a function instead so that one can use linear, or log, or whatever mapping.
        if (!__updating) {
            rangeSlider.value = mapFunc()
        }
    }

    function reset() {
        minHandle.reset()
        maxHandle.reset()
    }

    property real handleSize: rangeSlider.border.width * 5.

    property color handleColor: styles.handleColor

    Rectangle {
        id: range

        anchors {
            top: maxHandle.bottom
            horizontalCenter: rangeSlider.horizontalCenter
        }

        width: rangeSlider.width - rangeSlider.border.width * 2
        height: minHandle.y - (maxHandle.y + maxHandle.height)

        color: mouseArea.moveRange ? styles.colorOnLighter : styles.colorOn

        function updateValues(offset) {

            var yMax = maxHandle.y + offset
            var yMin = minHandle.y + offset

            var clampedMaxY = Utils.clamp(yMax + handleSize / 2.,
                                          handleSize / 2.,
                                          minHandle.y - handleSize / 2.)
            var clampedMinY = Utils.clamp(yMin + handleSize / 2.,
                                          yMax + 3. * handleSize / 2.,
                                          rangeSlider.height - handleSize / 2.)

            rangeSlider.maxValue = Utils.clamp(Utils.rescale(
                                                   rangeSlider.height - clampedMaxY,
                                                   3. * handleSize / 2., rangeSlider.height
                                                   - handleSize / 2.,
                                                   0., 1.), 0, 1)
            rangeSlider.minValue = Utils.clamp(Utils.rescale(
                                                   rangeSlider.height - clampedMinY,
                                                   handleSize / 2.,
                                                   rangeSlider.height - 3. * handleSize / 2.,
                                                   0., 1.), 0, 1)
        }
    }

    Rectangle {
        id: minHandle

        width: rangeSlider.width - rangeSlider.border.width * 2
        height: handleSize

        x: rangeSlider.border.width

        y: Utils.rescale(1. - rangeSlider.minValue, 0., 1.,
                         3. * handleSize / 2.,
                         rangeSlider.height - handleSize / 2.) - handleSize / 2.

        color: mouseArea.handlePressed == minHandle
               ? styles.pressedHandlesColor : styles.handlesColor

        function moveHandle(mouseX, mouseY) {
            var clampedY = Utils.clamp(
                        mouseY,
                        maxHandle.y + maxHandle.height + handleSize / 2.,
                        rangeSlider.height - handleSize / 2.)
            rangeSlider.minValue = Utils.rescale(
                        rangeSlider.height - clampedY, handleSize / 2.,
                        rangeSlider.height - 3. * handleSize / 2., 0., 1.)

            // __updating = false;
        }

        function reset() {
            rangeSlider.minValue = rangeSlider.initialMinValue
        }
    }

    Rectangle {
        id: maxHandle

        width: rangeSlider.width - rangeSlider.border.width * 2
        height: handleSize

        x: rangeSlider.border.width
        y: Utils.rescale(
               1. - rangeSlider.maxValue, 0., 1., handleSize / 2.,
               rangeSlider.height - 3. * handleSize / 2.) - handleSize / 2.

        color: mouseArea.handlePressed == maxHandle
               ? styles.pressedHandlesColor : styles.handlesColor

        function moveHandle(mouseX, mouseY) {
            var clampedY = Utils.clamp(mouseY, handleSize / 2.,
                                       minHandle.y - handleSize / 2.)
            rangeSlider.maxValue = Utils.rescale(
                        rangeSlider.height - clampedY, 3. * handleSize / 2.,
                        rangeSlider.height - handleSize / 2., 0., 1.)
        }
        function reset() {
            rangeSlider.maxValue = rangeSlider.initialMaxValue
        }
    }

    Text {
        anchors.fill: minHandle

        // anchors.horizontalCenter: range.horizontalCenter
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter

        text: rangeSlider.minValue.toFixed(2)
        color: styles.handlesValueColor
        font.bold: true
    }

    Text {
        anchors.fill: maxHandle

        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        text: rangeSlider.maxValue.toFixed(2)
        color: styles.handlesValueColor
        font.bold: true
    }

    MouseArea {
        id: mouseArea

        anchors.fill: parent
        property var handlePressed: null
        property bool moveRange: false
        property real offset: 0
        onPressed: {
            __updating = true
            if (mouseY < maxHandle.y + maxHandle.height) {
                handlePressed = maxHandle
                handlePressed.moveHandle(mouseX, mouseY)
            } else if (mouseY > minHandle.y) {
                handlePressed = minHandle
                handlePressed.moveHandle(mouseX, mouseY)
            } else {
                moveRange = true
                offset = mouseY - range.y
            }
        }

        onPositionChanged: {
            if (handlePressed)
                handlePressed.moveHandle(mouseX, mouseY)
            else if (moveRange) {
                var newVal = 0
                newVal = Math.min(
                            Math.max(handleSize, mouseY - offset),
                            rangeSlider.height - (range.height + handleSize))
                newVal -= range.y

                range.updateValues(newVal)
            }
        }

        onReleased: {
            handlePressed = null
            __updating = false
            moveRange = false
        }

        onDoubleClicked: {
            if (Utils.inside(mouseX, mouseY, maxHandle.x, maxHandle.y,
                             maxHandle.width, maxHandle.height)) {
                maxHandle.reset()
            } else if (Utils.inside(mouseX, mouseY, minHandle.x, minHandle.y,
                                    minHandle.width, minHandle.height)) {
                minHandle.reset()
            } else
                rangeSlider.reset()
        }
    }
}
