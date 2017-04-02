import QtQuick 2.0
import CreativeControls 1.0
Item {

    Column {
        Repeater {
            model: 10
            delegate: Keyboard { }
        }
    }
}
