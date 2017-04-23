import QtQuick 2.6
import CreativeControls 1.0

Slider
{
    text : value.toFixed(3)


    customMap: function(val)
    {
        return scale(mapFunc(val),0.,1);
    }

    property var mapFunc : function(val){return Math.log(val)}// * Math.LOG10}

    function scale(mappedVal,min, max)
    {
        var mappedMax = 0.//mapFunc(max)//(mapType === "log") ? Math.log(0.) : Math.exp(1.);
        var mappedMin = -36.7//mapFunc(min)//(mapType === "log") ? Math.log(1.) : Math.exp(0.);

        return ((max - min) * (mappedVal - mappedMin))/(mappedMax - mappedMin) + min;

    }

}
