import QtQuick 2.6
import CreativeControls 1.0

// A matrix of buttons. Buttons can be toggles or triggers.
Grid
{
    id: grid

    width : 200
    height : 200

    columns: 3
    rows: 3
    spacing: 5
    padding: 2.5
    horizontalItemAlignment : Grid.AlignHCenter
    verticalItemAlignment : Grid.AlignVCenter

    property bool togglable: false
    property var pressed: []

    Repeater {
        model: parent.columns * parent.rows

        anchors.fill: parent
        delegate: Rectangle {

            id: rect

            width: grid.width / grid.columns - 5
            height: grid.height / grid.rows - 5
            radius: 14

            color: Styles.detail
            border.width: 3
            border.color: Styles.base

            property bool toggled : false

            onToggledChanged: {
                if(toggled)
                    rect.color = Styles.dark;
                else
                    rect.color = Styles.detail;
            }

            MouseArea {
                anchors.fill: parent

                onPressed: {
                    if(togglable)
                        toggled = !toggled;
                    else
                        toggled = true;
                    grid.pressed = [ index ]
                }
                onReleased: {
                    if(togglable)
                        ;
                    else
                        toggled = false;
                    grid.pressed = [ ]
                }
            }
        }
    }
}
