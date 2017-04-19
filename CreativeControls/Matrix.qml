import QtQuick 2.6
import CreativeControls 1.0

// A matrix of buttons. Buttons can be toggles or triggers.
Grid
{
    id: grid
    property bool togglable: false

    columns: 3
    rows: 3
    spacing: 5
    padding: 2.5
    horizontalItemAlignment : Grid.AlignHCenter
    verticalItemAlignment : Grid.AlignVCenter

    Repeater {
        model: parent.columns * parent.rows

        anchors.fill: parent
        delegate: Rectangle {
            property bool toggled : false
            id: rect
            color: Styles.detail
            radius: 14
            width: grid.width / grid.columns - 5
            height: grid.height / grid.rows - 5

            border.color: Styles.base

            onToggledChanged: {
                if(toggled)
                    rect.color = Styles.dark;
                else
                    rect.color = Styles.detail;
            }
            MouseArea {
                anchors.fill: parent
                onPressed: if(togglable) toggled = !toggled; else toggled = true;
                onReleased: if(togglable) ; else toggled = false;
            }
        }
    }
}
