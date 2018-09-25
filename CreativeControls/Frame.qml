import QtQuick 2.6
import com.github.jcelerier.CreativeControls 1.0


// Container
// Rectangle with a background color and border
Rectangle {
    id: container

    property var styles: DarkStyle

    anchors.centerIn: parent

    width: parent.width + border.width * 2
    height: parent.height + border.width * 2
    color: "transparent"

    border {
        width: 3
        color: styles.base
    }
    radius: 10
}
