import QtQuick 2.6
import com.github.jcelerier.CreativeControls 1.0


// Slider with a min and max
Rectangle {
    id: rangeSlider

    width: 300
    height: 100
    // onWidthChanged: handle.updateHandle();
    // onHeightChanged: handle.updateHandle();
    property var styles: DarkStyle

    color: styles.sliderBackgroundColor
    border {
        width: height / 25.
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

    property real handleSize: 40.

    property color handleColor: styles.handleColor

    Rectangle {
        id: range

        anchors {
            right: maxHandle.left
            verticalCenter: rangeSlider.verticalCenter
        }

        width: maxHandle.x - (minHandle.x + minHandle.width)
        height: rangeSlider.height - rangeSlider.border.width * 2

        color: styles.colorOn

        function updateValues(offset) {
            console.log(offset)

            var xMax = maxHandle.x + offset
            var xMin = minHandle.x + offset

            var clampedMaxX = Utils.clamp(xMax + handleSize / 2.,
                                          minHandle.x + 3. * handleSize / 2.,
                                          rangeSlider.width - handleSize / 2.)
            var clampedMinX = Utils.clamp(xMin + handleSize / 2.,
                                          handleSize / 2.,
                                          xMax - handleSize / 2.)

            var tmp = Utils.clamp(Utils.rescale(
                                      clampedMaxX, 3. * handleSize / 2.,
                                      rangeSlider.width - handleSize / 2., 0.,
                                      1.), 0, 1)
            rangeSlider.maxValue = tmp

            rangeSlider.minValue = Utils.clamp(Utils.rescale(
                                                   clampedMinX, handleSize / 2., rangeSlider.width
                                                   - 3. * handleSize / 2., 0.,
                                                   1.), 0, 1)
        }
    }

    Rectangle {
        id: minHandle

        width: handleSize
        height: rangeSlider.height - rangeSlider.border.width * 2

        x: Utils.rescale(
               rangeSlider.minValue, 0., 1., handleSize / 2.,
               rangeSlider.width - 3. * handleSize / 2.) - handleSize / 2

        y: rangeSlider.border.width

        color: styles.detail

        function moveHandle(mouseX, mouseY) {
            var clampedX = Utils.clamp(mouseX, handleSize / 2.,
                                       maxHandle.x - handleSize / 2.)
            rangeSlider.minValue = Utils.rescale(
                        clampedX, handleSize / 2.,
                        rangeSlider.width - handleSize * 1.5, 0., 1.)
            // __updating = false;
        }

        function reset() {
            rangeSlider.minValue = rangeSlider.initialMinValue
        }
    }

    Rectangle {
        id: maxHandle

        width: handleSize
        height: rangeSlider.height - rangeSlider.border.width * 2

        x: Utils.rescale(rangeSlider.maxValue, 0., 1., 3. * handleSize / 2., rangeSlider.width - handleSize / 2.) - handleSize / 2.
        y: rangeSlider.border.width
        color: styles.detail

        function moveHandle(mouseX, mouseY) {
            var clampedX = Utils.clamp(mouseX, minHandle.x + minHandle.width + handleSize / 2, rangeSlider.width - handleSize / 2)
            rangeSlider.maxValue = Utils.rescale(clampedX, handleSize * 1.5, rangeSlider.width - handleSize / 2, 0., 1.)
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
        color: styles.labelColor
        font.bold: true
    }

    Text {
        anchors.fill: maxHandle

        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        text: rangeSlider.maxValue.toFixed(2)
        color: styles.labelColor
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

            if (mouseX < minHandle.x + minHandle.width) {
                handlePressed = minHandle
                handlePressed.moveHandle(mouseX, mouseY)
            } else if (mouseX > maxHandle.x) {
                handlePressed = maxHandle
                handlePressed.moveHandle(mouseX, mouseY)
            } else {
                moveRange = true
                offset = mouseX - range.x
            }
        }

        onPositionChanged: {
            if (handlePressed)
                handlePressed.moveHandle(mouseX, mouseY)
            else if (moveRange) {
                var newVal = 0
                newVal = Utils.clamp(
                            mouseX - offset, handleSize,
                            rangeSlider.width - (range.width + handleSize))
                newVal -= range.x
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
