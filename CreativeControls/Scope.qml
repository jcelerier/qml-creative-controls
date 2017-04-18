import QtQuick 2.6
import CreativeControls 1.0

Rectangle
{
    property alias points: scope.points
    property alias fillColor: scope.baseColor
    property alias lineColor: scope.detailColor
    property alias symmetrize: scope.symmetrize
    property alias yMin: scope.yMin
    property alias yMax: scope.yMax

    radius: 5
    color: Styles.base
    anchors.fill: parent
    ScopeImpl
    {
        id: scope
        anchors.fill: parent
        points: [-0.5, 0, -1, -0.5, 0, 1.5, 1, 2];
        yMin: -0.5
        yMax: 2
        baseColor: Styles.dark
        detailColor: Styles.detail
        symmetrize: true
    }

    /* TEST

    Timer
    {
        interval: 64
        triggeredOnStart: true
        repeat: true
        running: true
        onTriggered: {
            var array = [];
            for(var i = 0; i < 10; i++)
            {
                array.push(Math.random(2));
            }
            scope.points = array;
        }
    }
    */
}
