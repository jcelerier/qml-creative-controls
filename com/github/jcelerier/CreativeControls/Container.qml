import QtQuick 2.6
import com.github.jcelerier.CreativeControls 1.0

Rectangle {
    id: container

    width: 150
    height: 150
    radius: 10

    property var styles: DarkStyle

    color: styles.background
    border {
        color: styles.base
        width: styles.containerCornerRadius
    }

    default property alias main: content.data

    Item {
        id: content
        anchors {
            top: container.top
            topMargin: container.radius
            leftMargin: container.radius
            horizontalCenter: container.horizontalCenter
        }
        width: container.width - 2 * container.radius
        height: title == ""
                ? container.height - 2. * container.radius
                : container.height - 2. * container.radius - (titleLabel.height + titleBottomMargin)
    }

    Component.onCompleted: main.parent = content

    property alias title: titleLabel.text
    property real titleBottomMargin: titleLabel.height * 0.3

    Text {
        id: titleLabel
        text: ""

        anchors {
            top: content.bottom
            topMargin: container.titleBottomMargin
            horizontalCenter: container.horizontalCenter
        }
        width: container.width
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter

        font {
            bold: true
            capitalization: Font.AllUppercase
        }
        color: styles.base
    }
}
