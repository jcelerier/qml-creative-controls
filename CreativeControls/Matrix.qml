import QtQuick 2.6

// A matrix of buttons. Buttons can be toggles or triggers.
Grid
{
    id: grid
    anchors.fill: parent
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
            color: "green"
            radius: 14
            width: grid.width / grid.columns - 5
            height: grid.height / grid.rows - 5

            border.color: "black"

            onToggledChanged: if(toggled) rect.color = "darkGreen"; else rect.color = "green";
            MouseArea {
                anchors.fill: parent
                onPressed: if(togglable) toggled = !toggled; else toggled = true;
                onReleased: if(togglable) ; else toggled = false;
            }
        }
    }
}
