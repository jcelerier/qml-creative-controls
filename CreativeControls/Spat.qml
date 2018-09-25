import QtQuick 2.6

// Controls spatialization
Item {
    id: spat

    property int sources: 8
    property real dim: Math.min(height, width)

    property real radSmall: dim / 2 - 0.05 * dim

    Rectangle {
        x: 0.05 * dim
        y: 0.05 * dim
        width: dim - 0.1 * dim
        height: dim - 0.1 * dim
        radius: dim
        border {
            width: 1
            color: "black"
        }
    }

    Rectangle {
        width: 2
        border {
            width: 2
            color: "black"
        }
        height: dim
        x: dim / 2
        y: 0
        color: "black"
    }

    Rectangle {
        height: 2
        border {
            width: 2
            color: "black"
        }
        width: dim
        x: 0
        y: dim / 2
        color: "black"
    }

    Repeater {
        model: sources
        Rectangle {
            id: src

            x: radSmall + radSmall * Math.cos(2 * Math.PI * index / sources)
            y: radSmall + radSmall * Math.sin(2 * Math.PI * index / sources)

            width: 0.1 * dim
            height: width
            radius: width
            color: "red"
            Rectangle {
                anchors.centerIn: src
                id: sub
                width: 0.08 * dim
                height: width
                radius: width
                color: "blue"
            }
        }
    }

    Rectangle {
        id: interactor
        width: 0.15 * dim
        x: dim / 2 - width / 2
        y: dim / 2 - width / 2
        height: width
        radius: width
        color: "green"
        MouseArea {
            drag.target: parent
            anchors.fill: parent
            drag.minimumX: 0
            drag.maximumX: dim - width
            drag.minimumY: 0
            drag.maximumY: dim - height
        }
    }
}
