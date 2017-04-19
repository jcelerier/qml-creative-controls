import QtQuick 2.6
import CreativeControls 1.0

// An oscilliscope.
// No user input.
// Properties:
// * points: an array of values that will be displayed.
// * symmetrize: render a waveform instead of a scope
// * yMin / yMax: bounds (in the value domain) that should be shown. Default is [-1; 1]
Item
{
    property alias points: scope.points
    property alias fillColor: scope.baseColor
    property alias lineColor: scope.detailColor
    property alias symmetrize: scope.symmetrize
    property alias yMin: scope.yMin
    property alias yMax: scope.yMax

    anchors.fill: parent
    ScopeImpl
    {
        id: scope
        anchors.fill: parent
        yMin: -1
        yMax: 1
        baseColor: Styles.dark
        detailColor: Styles.detail
        symmetrize: false
    }

    Timer
    {
        interval: 640
        triggeredOnStart: true
        repeat: true
        running: true
        onTriggered: {
            var array = [];
            for(var i = 0; i < 10; i++)
            {
                array.push(Math.random() * 2 - 1);
            }
            scope.points = array;
            console.log(array)
        }
    }
}
