import QtQuick 2.7
import CreativeControls 1.0

// Displays input messages in a graph
// No UI input.
// * lines: will display lines between dots
GraphImpl {
    id: plot

    color: Styles.base
    lines: true

    // Use this function to add a value to the graph.
    function pushValue(v) {
        plot.values.push(v)
        if(plot.values.length > (width / 2))
            plot.values.shift()
    }
}
