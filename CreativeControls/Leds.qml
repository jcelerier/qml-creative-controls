import QtQuick 2.6
import QtQuick.Layouts 1.3

// A LED matrix
// No input
Item
{
    id: leds

    property real ledsPerRow : 3
    property real ledsPerColumn : 2

    property color ledColorOn: "#99BB99"
    property color ledColorOff: "#666666"


    height: 500
    width: 400



    property var intensity : [
        [2.1, 1.7],
        [1.5, 2.4],
        [2.9, 1.3]
    ]
    Grid {
        id: gridTest
        columns: ledsPerColumn
        rows : ledsPerRow
        Repeater {
            model: ledsPerRow * ledsPerColumn
            Rectangle {
                id: rect
                width: 100; height: 40
                border.width: 1
                property real indexColumn : index %ledsPerRow
                property real indexRow : index%ledsPerColumn
                color: Qt.darker(ledColorOn, intensity[indexColumn][indexRow])

            }

        }
    }


    // component for a single led
    Component
    {
        id: ledComponent
        Rectangle
        {
            id: led
            height: 10
            width: 10

            radius : width/2.

            state : "LED_OFF"
            states:[
                State
                {
                    id: ledOn
                    name : "LED_ON"
                    PropertyChanges {
                        target: led
                        color: ledColorOn
                    }
                },
                State
                {
                    id: ledOff
                    name : "LED_OFF"
                    PropertyChanges {
                        target: led
                        color: ledColorOff
                    }
                }
            ]
            Transition{
                ColorAnimation {duration: 200}
            }
            function toggle()
            {
                state = state === "LED_ON" ? "LED_OFF" : "LED_ON"
            }
        }

    }


}
