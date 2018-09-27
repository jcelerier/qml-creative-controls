import QtQuick 2.6
import com.github.jcelerier.CreativeControls 1.0


// X-Y pad
Item {
    id: xyPad

    width: 200
    height: 200

    property alias stickX: xy.centerX
    property alias stickY: xy.centerY

    property var styles: DarkStyle

    Rectangle {
        anchors.fill: parent
        color: styles.background
    }

    Crosshair {
        id: xy
        anchors.fill: parent
        color: touchArea.pressState ? styles.colorOn : styles.colorOff
        radiusScale: touchArea.pressState ? 25 : 35
    }

    TouchArea {
        id: touchArea
        anchors.fill: parent

        onPressed: applyPos(point)
        onPositionChanged: applyPos(point)

        onDoubleClicked: stickX = stickY = 0.5

        function applyPos(point) {
            stickX = Utils.clamp(point.x, 0, xyPad.width) / width
            stickY = Utils.clamp(point.y, 0, xyPad.height) / height
        }
    }
}
