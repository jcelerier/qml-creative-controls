import QtQuick 2.6
import CreativeControls 1.0

// Cosine influence area
Item
{
    property var points : [Qt.point(0.2, 0.4), Qt.point(0.5, 0.1)]
    property alias centerX : xy.centerX
    property alias centerY : xy.centerY

    property real sizeRatio : Math.min(item.width, item.height) / 15.
    property var values: []
    onValuesChanged: console.log(values)

    id: item
    anchors.fill: parent

    onCenterXChanged: updateValues()
    onCenterYChanged: updateValues()
    onPointsChanged: updateValues()

    function updateValues()
    {
        var newvalues = [];
        for(var i = 0; i < item.points.length; i++)
        {
            var x1 = item.points[i].x - centerX + sizeRatio / width;
            var x2 = item.points[i].y  - centerY + sizeRatio / width;
            var dist = 3 * Math.sqrt(x1 * x1 + x2 * x2);
            if(Math.abs(dist) < Math.PI / 2)
                newvalues.push(Math.cos(dist));
            else
                newvalues.push(0);
        }
        values = newvalues;
    }

    MouseArea {
        function applyPos()
        {
            centerX = Utils.clamp(mouseX, 0, item.width) / width;
            centerY = Utils.clamp(mouseY, 0, item.height) / height;
        }

        anchors.fill: parent
        onPressed: applyPos()
        onPositionChanged: applyPos()
        onReleased: applyPos()
    }

    Repeater
    {
        id: rpt
        model: points
        delegate: Polygon
        {
            x: points[index].x * item.width
            y: points[index].y * item.height
            onXChanged: { points[index].x = x / item.width; updateValues(); }
            onYChanged: { points[index].y = y / item.height; updateValues(); }
            width: 2. * sizeRatio
            height: width
            borderWidth: 0.05 * sizeRatio
            fillColor: Styles.base
            borderColor: CppUtils.setHSVHue(Styles.detail, Math.abs(Math.random(360)))

            Text
            {
                anchors.centerIn: parent
                font.pointSize: Math.max(2, 1.1 * sizeRatio)
                text: index
                color: parent.borderColor
            }
            Drag.hotSpot: Qt.point(width / 2, height / 2)

            MouseArea {
                id: dragArea
                anchors.fill: parent

                drag.target: parent
                drag.smoothed: false
                drag.minimumX: 0. - width / 2.
                drag.maximumX: item.width - width / 2.
                drag.minimumY: 0 - height / 2.
                drag.maximumY: item.height - height / 2.
            }
        }
    }

    XYTarget {
        id: xy
        anchors.fill: parent
        color: Styles.detail
    }

}
