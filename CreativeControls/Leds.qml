import QtQuick 2.6
import QtQuick.Layouts 1.3

// A LED matrix
// No input
Item
{
    id: leds

    property real ledsPerRow : 2
    property real ledsPerColumn : 3

    property color ledColorOn: "#99BB99"
    property color ledColorOff: "#666666"


    height: 500
    width: 400



    property var intensity : [
        [0.1, 0.2],
        [0.3, 0.4],
        [0.5, 0.6]
    ]

    Grid {
        id: gridTest
        columns: ledsPerRow
        rows : ledsPerColumn
        Repeater {
            model: ledsPerRow * ledsPerColumn
            Rectangle {
                id: rect
                width: 100; height: 100
                radius : width/2.
                border.width: 1

                property real indexRow : index% ledsPerRow
                property real indexColumn : ( index - indexRow)/(ledsPerRow)
                color: Qt.darker(ledColorOn, intensity[indexColumn][indexRow] *10.)

            }

        }
    }



}
