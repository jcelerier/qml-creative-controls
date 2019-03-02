import QtQuick 2.6
import com.github.jcelerier.CreativeControls 1.0
import QtQuick.Controls.Styles 1.4


//  A RGB slider shaped in donut

// Properties:
// * resColor: the current color
// * colorSpace: choose the colorSpace for the slider (Qt.rgba/Qt.hsla/Qt.hsva)
Rectangle {
    id: donutSlider

    width: 200
    height: width
    radius: width / 2.
    color: "transparent"

    //  border.width : 3.
    //  border.color : donutSlider.resColor
    property real channels: 3.
    property real innerRadius: radius * 0.4 //0.38
    property color resColor: Styles.detail
    property var colorSpace: Qt.hsla

    function updateColor() {
        if (repeater.itemAt(2) !== null && (colorSpace === Qt.hsla
                                            || colorSpace === Qt.hsva)) {
            for (var i = 1; i < repeater.count; i++) {
                repeater.itemAt(i).updateHue(repeater.itemAt(0).value)
            }
        }
        donutSlider.resColor = (repeater.itemAt(2) !== null)
                ? colorSpace(repeater.itemAt(0).value, repeater.itemAt(1).value, repeater.itemAt(2).value, 1.)
                : Styles.detail
    }

    Repeater {
        id: repeater
        model: donutSlider.channels

        delegate: ArcSlider {
            id: arcSlider
            channelIndex: index
            colorSpace: donutSlider.colorSpace

            anchors.fill: parent

            innerRadius: donutSlider.innerRadius * 1.5
            onValueChanged: donutSlider.updateColor()
        }
    }

    Rectangle {
        id: center

        width: innerRadius * 2.
        height: width
        radius: innerRadius

        anchors.centerIn: parent
        color: donutSlider.resColor
        visible: true
    }

    Rectangle {
        id: border

        anchors.fill: parent
        radius: parent.radius
        color: "transparent"

        border.width: 3.
        border.color: donutSlider.resColor
    }

    /*Rectangle
    {
        id: innerBorder

       anchors.centerIn : parent
       width : radius *2.
       height : radius *2.

       radius : donutSlider.innerRadius * 1.5
       color : "transparent"

       border.width : 3.
       border.color : donutSlider.resColor
    }*/
    function updateSliders(ptX, ptY) {
        var angleRad = Math.PI - Math.atan2(
                    ptX - donutSlider.radius,
                    ptY - donutSlider.radius) //+ (2.* Math.PI);
        angleRad -= Math.PI / 2.

        angleRad += angleRad < 0 ? 2. * Math.PI : 0

        for (var i = 0; i < repeater.count; i++) {
            if (repeater.itemAt(i).isInside(angleRad)) {
                repeater.itemAt(i).moveHandle(angleRad)
                return true
            }
        }
    }

    TouchArea {
        anchors.fill: parent
        onPressed: {
            var distToCenter = Utils.distance(point.x, point.y, parent.radius,
                                              parent.radius)
            if (distToCenter > innerRadius) {
                updateSliders(point.x, point.y)
            }
        }
        onPositionChanged: updateSliders(point.x, point.y)

        onDoubleClicked: {
            var distToCenter = Utils.distance(point.x, point.y, parent.radius,
                                              parent.radius)
            if (distToCenter < innerRadius) {
                for (var i = 0; i < repeater.count; i++) {
                    repeater.itemAt(i).reset()
                }
            } else {
                for (var i = 0; i < repeater.count; i++) {
                    if (repeater.itemAt(i).isInside(angleRad)) {
                        repeater.itemAt(i).reset()
                        return true
                    }
                }
            }
        }
    }
}
