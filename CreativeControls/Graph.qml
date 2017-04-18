import QtQuick 2.7
import CreativeControls 1.0

// Displays input messages in a graph
// No input
Rectangle
{
    anchors.fill: parent

    color: "black"

    function pushValue(v) {
        plot.values.push(v)
        if(plot.values.length > width)
            plot.values.shift()
    }
    GraphImpl {
        id: plot
        anchors.fill: parent
        graphColor: "green"
        lines: false
        values: [1, 0.5, 0, 0.5, 0, 0.5, 0]
    }

    /* Test:
    Timer {
        id: tm
        repeat: true
        onTriggered: { pushValue(Math.random(1)) ;  }
        running: true
        interval: 100
    }
    */

}
