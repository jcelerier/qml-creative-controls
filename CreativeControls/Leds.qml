import QtQuick 2.6
import com.github.jcelerier.CreativeControls 1.0


// A LED matrix.

// Property:
// * intensity[]:
//      array containing the color intensity for each led of the matrix

// Functions:
// * toggle(index):
//      toggle the led at index(1D index for the grid) in the grid,
//      switching it on or off
// * setIntensity(index,val):
//      set intensity at val for the led at index (1D index for the grid)
// * setIntensityForAll(val):
//      set intensity at val for all the leds in the matrix
Grid {
    id: leds

    width: 200
    height: 200

    columns: 3
    rows: 3

    columnSpacing: Utils.clamp((leds.width - leds.radius * 2 * leds.columns) / (leds.columns - 1), 0, leds.width)
    rowSpacing: Utils.clamp((leds.height - leds.radius * 2 * leds.rows) / (leds.rows - 1), 0, leds.height)

    property var styles: DarkStyle
    onStylesChanged: updateColor()

    property real radius: 20
    property color ledColorOn: styles.colorOn
    property color ledColorOff: styles.colorOff

    property bool easing: false

    // intensity default values
    property var intensity: [[0.1, 0.2, 0.3], [0.4, 0.5, 0.6], [0.7, 0.8, 0.9]]

    // update color if the style changed
    function updateColor() {
        for (var k = 0; k < repeater.count; k++) {
            var item = repeater.itemAt(k)
            if (item !== null) {
                item.color = Qt.darker( styles.colorOn, intensity[item.indexColumn][item.indexRow] * 10.)
            }
        }
    }

    // toggle on/off
    function toggle(index) {
        var indexRow = index % leds.columns
        var indexColumn = (index - indexRow) / (leds.columns)

        // modify the intensity matrix
        var val = intensity[indexColumn][indexRow] > 0. ? 0. : 1.0
        setIntensity(index, val)
    }

    // set intensity for one led at index (1D index for the grid)
    function setIntensity(index, val) {
        var indexRow = index % leds.columns
        var indexColumn = (index - indexRow) / (leds.columns)

        // modify the intensity matrix
        intensity[indexColumn][indexRow] = val

        // set the led color
        var item = repeater.itemAt(index)
        if (item !== null) {
            item.color = Qt.darker(ledColorOn, val * 10.)
        }
    }

    // set intensity for all the leds
    function setIntensityForAll(val) {
        // modify the intensity matrix
        for (var i = 0; i < leds.columns; i++) {
            for (var j = 0; j < leds.rows; j++) {
                intensity[i][j] = val
            }
        }

        // set the led color
        for (var k = 0; k < leds.rows * leds.columns; k++) {
            var item = repeater.itemAt(k)
            if (item !== null) {
                item.color = Qt.darker(ledColorOn, val * 10.)
            }
        }
    }

    Repeater {
        id: repeater
        model: leds.rows * leds.columns

        Rectangle {
            id: rect
            width: leds.radius * 2.
            height: leds.radius * 2.
            radius: leds.radius

            // border.width: 2
            // border.color : Styles.base
            color: Qt.darker(ledColorOn, intensity[indexColumn][indexRow] * 10.)

            Behavior on color {
                enabled: leds.easing
                ColorAnimation {
                    easing.type: Easing.InOutQuad
                }
            }
            property real indexRow: index % leds.columns
            property real indexColumn: (index - indexRow) / (leds.columns)
        }
    }
}
