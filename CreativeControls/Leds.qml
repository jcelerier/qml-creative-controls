import QtQuick 2.6
import CreativeControls 1.0

// A LED matrix
// No input
Grid
{
    id: ledsGrid

    columns: 3
    rows : 3


    columnSpacing : Utils.clamp((ledsGrid.width - ledsGrid.ledRadius*2* ledsGrid.columns) / (ledsGrid.columns-1),
                                0, parent.width)
    rowSpacing : Utils.clamp((ledsGrid.height - ledsGrid.ledRadius*2* ledsGrid.rows) / (ledsGrid.rows-1),
                             0,parent.height)


    property real ledRadius : 20
    property color ledColorOn: Styles.detail
    property color ledColorOff: Styles.base


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
            border.width: 2
            border.color: Qt.rgba(1.-color.g, 1.-color.g, 1.-color.g, color.a)

            property real indexRow : index% ledsGrid.columns
            property real indexColumn : ( index - indexRow)/(ledsGrid.columns)

            color: Qt.darker(ledColorOn, intensity[indexColumn][indexRow] *10.)

        }

    }
}

