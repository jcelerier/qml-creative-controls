import QtQuick 2.6
import com.github.jcelerier.CreativeControls 1.0


// Cosine influence area.
// Parameters:
// * points: a list of points betwen (0;0) and (1;1).
// * centerX / centerY: the position of the crosshair
// * values: when the crosshair moves, values is updated to contain an array of distances
//           to each point in points
Rectangle {
    id: cosInfluence

    property var points: [Qt.point(0.2, 0.4), Qt.point(0.5, 0.1)]
    property alias centerX: xy.centerX
    property alias centerY: xy.centerY
    onCenterXChanged: updateValues()
    onCenterYChanged: updateValues()
    onPointsChanged: updateValues()

    property var styles: DarkStyle
    color: styles.background

    property real sizeRatio: Math.min(cosInfluence.width,
                                      cosInfluence.height) / 13.
    property var values: []

    function updateValues() {
        var newvalues = []
        for (var i = 0; i < cosInfluence.points.length; i++) {
            var x1 = cosInfluence.points[i].x - centerX + sizeRatio / width
            var x2 = cosInfluence.points[i].y - centerY + sizeRatio / width
            var dist = 3 * Math.sqrt(x1 * x1 + x2 * x2)
            if (Math.abs(dist) < Math.PI / 2)
                newvalues.push(Math.cos(dist))
            else
                newvalues.push(0)
        }
        values = newvalues
    }

    // Mouse area for when the background is clicked
    TouchArea {
        id: touchArea
        anchors.fill: parent
        onPressed: applyPos(point)
        onPositionChanged: applyPos(point)

        function applyPos(point) {
            centerX = Utils.clamp(point.x, 0, cosInfluence.width) / width
            centerY = Utils.clamp(point.y, 0, cosInfluence.height) / height
        }
    }

    // The circles
    Repeater {
        model: points
        delegate: Polygon {
            smooth: true
            antialiasing: true
            x: points[index].x * cosInfluence.width
            y: points[index].y * cosInfluence.height
            onXChanged: {
                points[index].x = x / cosInfluence.width
                updateValues()
            }
            onYChanged: {
                points[index].y = y / cosInfluence.height
                updateValues()
            }
            width: 2. * sizeRatio
            height: width
            borderWidth: 0.05 * sizeRatio
            fillColor: styles.randomDetailColor()
            borderColor: dragArea.pressed ? styles.textPressedColor : styles.background

            Text {
                anchors.centerIn: parent
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter

                font.pointSize: Math.max(2, 1.1 * sizeRatio)
                text: index
                color: parent.borderColor
            }

            Drag.hotSpot: Qt.point(width / 2, height / 2)

            MouseArea {
                id: dragArea
                anchors.fill: parent

                drag {
                    target: parent
                    smoothed: false
                    minimumX: 0. - width / 2.
                    maximumX: cosInfluence.width - width / 2.
                    minimumY: 0 - height / 2.
                    maximumY: cosInfluence.height - height / 2.
                }
            }
        }
    }

    // Crosshair. When clicked it will also move.
    Crosshair {
        id: xy
        anchors.fill: parent
        color: xy.pressed
               || touchArea.pressState ? styles.colorOn : styles.colorOff
        radiusScale: xy.pressed || touchArea.pressState ? 25 : 35
    }
}
