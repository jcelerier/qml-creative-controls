import QtQuick 2.6
import QtQuick.Layouts 1.3

// A LED matrix
// No input
Item
{
    id: leds

    property real ledsPerRow : 3
    property real ledsPerColumn : 3

    property color ledColorOn: "#99BB99"
    property color ledColorOff: "#666666"


    height: 500
    width: 400

    // intensity default values
    property var intensity : [
        [0.1, 0.2,0.3],
        [0.4,0.5,0.6],
        [0.7,0.8,0.9]
    ]

    // set intensity for one led at index (1D index for the grid)
    function setIntensity(index,val)
    {
        var indexRow = index% ledsPerRow;
        var indexColumn = ( index - indexRow)/(ledsPerRow)

        // modify the intensity matrix
        intensity[indexColumn][indexRow] = val;

        // set the led color
        var item = repeater.itemAt(index)
        if(item !== null)
        {
            item.color = Qt.darker(ledColorOn,val*10.)
        }
    }
    // set intensity for all the leds
    function setIntensityForAll(val)
    {
        // modify the intensity matrix
        for(var i = 0; i < ledsPerRow; i++)
        {
            for(var j = 0; j < ledsPerColumn; j++)
            {
                intensity[i][j] = val;

            }
        }

        // set the led color
        for(var k = 0; k < ledsPerColumn*ledsPerRow; k++)
        {
            var item = repeater.itemAt(k)
            if(item !== null)
            {
                item.color = Qt.darker(ledColorOn,val)
            }
        }

    }

    // grid containing leds
    Grid {
        id: gridTest
        anchors.fill : parent
        columns: ledsPerRow
        rows : ledsPerColumn

        spacing : 30

        Repeater {
            id: repeater
            model: ledsPerRow * ledsPerColumn
            Rectangle {
                id: rect
                width: gridTest.spacing /2.; height: gridTest.spacing /2.
                radius : width/2.
                border.width: 1
                border.color: "transparent"

                property real indexRow : index% ledsPerRow
                property real indexColumn : ( index - indexRow)/(ledsPerRow)

                color: Qt.darker(ledColorOn, intensity[indexColumn][indexRow] *10.)

            }

        }
    }
}
