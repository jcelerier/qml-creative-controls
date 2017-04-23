import QtQuick 2.6
import CreativeControls 1.0

Slider
{
    id : logSlider

    text : value.toFixed(3)

    mapFunc : mapLog
    property var mapLog : function()
    {
        return 1.+Math.log(linearMap());
    }

}
