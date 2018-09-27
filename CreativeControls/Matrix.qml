import QtQuick 2.6
import com.github.jcelerier.CreativeControls 1.0


// A matrix of buttons. Buttons can be toggles or triggers.
Grid {
    id: grid

    width: 200
    height: 200

    columns: 3
    rows: 3
    spacing: 5
    padding: 2.5
    horizontalItemAlignment: Grid.AlignHCenter
    verticalItemAlignment: Grid.AlignVCenter

    property real radius: styles.cornerRadius

    property bool togglable: false
    property var pressed: []
    property var styles: DarkStyle
    onStylesChanged: {
        for (var k = 0; k < repeater.count; k++) {
            var item = repeater.itemAt(k)
            if (item !== null) {
                item.color = item.toggled ? styles.colorOn : styles.colorOff
            }
        }
    }

    Repeater {
        id: repeater
        model: parent.columns * parent.rows

        anchors.fill: parent
        delegate: Rectangle {

            id: rect

            width: grid.width / grid.columns - 5
            height: grid.height / grid.rows - 5
            radius: grid.radius

            color: styles.colorOff
            border.width: 3
            border.color: styles.colorOnLighter

            property bool toggled: false

            onToggledChanged: {
                if (toggled)
                    rect.color = styles.colorOn
                else
                    rect.color = styles.colorOff
            }

            MouseArea {
                anchors.fill: parent

                onPressed: {
                    if (togglable)
                        toggled = !toggled
                    else
                        toggled = true
                    grid.pressed = [index]
                }
                onReleased: {
                    if (togglable)
                        ;
                    else
                        toggled = false
                    grid.pressed = []
                }
            }
        }
    }
}
