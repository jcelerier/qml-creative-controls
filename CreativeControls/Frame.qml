import QtQuick 2.6
import CreativeControls 1.0

// Container
// Rectangle with a background color and border
Rectangle
{
    id: container

    anchors.centerIn : parent

    width : parent.width + border.width *2
    height : parent.height + border.width *2
    color : "transparent"

    border.width : 3
    border.color : Styles.base
    radius : 10
}
