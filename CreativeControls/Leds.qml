import QtQuick 2.6
import QtQuick.Layouts 1.3

// A LED matrix
// No input
Grid
{
    id: ledsGrid
    height: 500
    width: 500

    columns: 3
    rows : 3


    columnSpacing :  (width - ledRadius/2) / columns
    rowSpacing :  (height - ledRadius/2) / rows

    property real ledRadius : 30

    property color ledColorOn: "#99BB99"
    property color ledColorOff: "#666666"


    // intensity default values
    property var intensity : [
        [0.1, 0.2,0.3],
        [0.4,0.5,0.6],
        [0.7,0.8,0.9]
    ]

    // set intensity for one led at index (1D index for the grid)
    function setIntensity(index,val)
    {
        var indexRow = index% ledsGrid.columns;
        var indexColumn = ( index - indexRow)/(ledsGrid.columns)

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
        for(var i = 0; i < ledsGrid.columns; i++)
        {
            for(var j = 0; j < ledsGrid.rows; j++)
            {
                intensity[i][j] = val;

            }
        }

        // set the led color
        for(var k = 0; k < ledsGrid.rows*ledsGrid.columns; k++)
        {
            var item = repeater.itemAt(k)
            if(item !== null)
            {
                item.color = Qt.darker(ledColorOn,val)
            }
        }

    }


    Repeater {
        id: repeater
        model: ledsGrid.rows * ledsGrid.columns
        Rectangle {
            id: rect
            width: ledsGrid.ledRadius * 2.; height: ledsGrid.ledRadius * 2.
            radius : ledsGrid.ledRadius
            border.width: 1
            border.color: "transparent"

            property real indexRow : index% ledsGrid.columns
            property real indexColumn : ( index - indexRow)/(ledsGrid.columns)

            color: Qt.darker(ledColorOn, intensity[indexColumn][indexRow] *10.)

        }

    }

}
