pragma Singleton

import QtQuick 2.6

QtObject
{
    function distance(x1,y1,x2,y2)
    {
        var a = x1 - x2
        var b = y1 - y2

        return Math.sqrt( a*a + b*b );
    }

    function clamp(val, min, max) {
        return Math.min(Math.max(val, min), max);
    }
}
