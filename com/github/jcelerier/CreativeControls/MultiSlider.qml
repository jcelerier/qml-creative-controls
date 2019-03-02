import QtQuick 2.6


// Vertical or horizontal set of sliders.
// Parameters:
// * count: the number of sliders
// * orientation: vertical / horizontal
// * spacing: spacing between sliders
// * values: an array with all the output values.
Item {
    id: multiSlider

    objectName: "multiSlider"
    width: orientation == Qt.Vertical ? 500 : 400
    height: orientation == Qt.Vertical ? 200 : 500

    property var styles: DarkStyle

    property int count: 10
    property int orientation: Qt.Vertical
    property bool textVisible: true
    property bool interactive: true
    property bool ease: false
    property real spacing: 0.
    property real sliderWidth: (multiSlider.orientation == Qt.Vertical)
                               ? (multiSlider.width) / count - spacing
                               : (multiSlider.height) / count - spacing

    property bool __updating: false

    property var values: []
    onValuesChanged: updateValues()
    Row {
        spacing: multiSlider.spacing

        Repeater {
            id: hSliders

            model: (multiSlider.orientation == Qt.Vertical) ? multiSlider.count : 0
            VSlider {
                styles: multiSlider.styles

                textVisible: multiSlider.textVisible
                ease: multiSlider.ease
                interactive: multiSlider.interactive
                height: multiSlider.height
                width: multiSlider.sliderWidth
                border.width: 0

                onValueChanged: recomputeValues()
            }
        }
    }

    Column {
        spacing: multiSlider.spacing
        Repeater {
            id: vSliders

            model: (multiSlider.orientation == Qt.Horizontal) ? multiSlider.count : 0
            HSlider {
                styles: multiSlider.styles

                textVisible: multiSlider.textVisible
                ease: multiSlider.ease
                interactive: multiSlider.interactive
                height: multiSlider.sliderWidth
                width: multiSlider.width
                border.width: 0

                onValueChanged: recomputeValues()
            }
        }
    }

    // outside -> inside
    function updateValues() {
        if (!__updating) {
            __updating = true
            var source = (orientation == Qt.Vertical) ? hSliders : vSliders

            for (var i = 0; i < count; i++) {
                var item = source.itemAt(i)

                if (item !== null) {
                    item.value = values[i]
                    item.updateHandle()
                }
            }
            __updating = false
        }
    }

    // inside -> outside
    function recomputeValues() {
        if (!__updating) {
            var source = (orientation == Qt.Vertical) ? hSliders : vSliders
            var array = []
            for (var i = 0; i < count; i++) {
                var item = source.itemAt(i)
                if (item !== null) {
                    array.push(item.value)
                }
            }
            __updating = true
            values = array
            __updating = false
        }
    }
}
