import QtQuick 2.6
import CreativeControls 1.0

// Vertical or horizontal set of sliders.
Item
{
    anchors.fill: parent
    width: 100
    height: 100
    Rectangle
    {
        anchors.fill: parent
        color: "#CCCCCC"
    }
    AngleSliderImpl {
    angle: 0
    anchors.fill: parent
    baseColor: Styles.detail
    detailColor: Styles.base
    }
}
