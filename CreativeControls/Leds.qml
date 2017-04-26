import QtQuick 2.6
import CreativeControls 1.0

// A LED matrix
// No input
Grid
{
    id: leds

    width : 200
    height : 200

    columns: 3
    rows : 3

    columnSpacing : Utils.clamp((leds.width - leds.radius*2* leds.columns) / (leds.columns-1),
                                0, leds.width)
    rowSpacing : Utils.clamp((leds.height - leds.radius*2* leds.rows) / (leds.rows-1),
                             0,leds.height)


    property real radius : 20
    property color ledColorOn: Styles.detail
    property color ledColorOff: Styles.base
    property bool easing : false

    // intensity default values
    property var intensity : [
        [0.1, 0.2,0.3],
        [0.4,0.5,0.6],
        [0.7,0.8,0.9]
    ]

    // toggle on/off
    function toggle(index)
    {
        var indexRow = index% leds.columns;
        var indexColumn = ( index - indexRow)/(leds.columns)

        // modify the intensity matrix
        var val = intensity[indexColumn][indexRow] > 0. ? 0. : 1.0;
        intensity[indexColumn][indexRow] = val;

        // set the led color
        var item = repeater.itemAt(index)
        if(item !== null)
        {
            item.color = Qt.darker(ledColorOn,val*10.)
        }
    }


    // set intensity for one led at index (1D index for the grid)
    function setIntensity(index,val)
    {
        var indexRow = index% leds.columns;
        var indexColumn = ( index - indexRow)/(leds.columns)

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
        for(var i = 0; i < leds.columns; i++)
        {
            for(var j = 0; j < leds.rows; j++)
            {
                intensity[i][j] = val;

            }
        }

        // set the led color
        for(var k = 0; k < leds.rows*leds.columns; k++)
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
        model: leds.rows * leds.columns

        Rectangle {
            id: rect
            width: leds.radius * 2.; height: leds.radius * 2.
            radius : leds.radius
            border.width: 2
            border.color : Styles.base

            color: Qt.darker(ledColorOn, intensity[indexColumn][indexRow] *10.)

            Behavior on color
            {
                enabled : leds.easing;
                ColorAnimation{easing.type : Easing.InOutQuad; }
            }
            property real indexRow : index% leds.columns
            property real indexColumn : ( index - indexRow)/(leds.columns)
        }

    }
}

