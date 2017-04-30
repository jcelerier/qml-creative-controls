import QtQuick 2.0
import QtQuick.Controls 2.1
import QtQuick.Layouts 1.1
import CreativeControls 1.0

Item {
    width: 900
    height: 900

    ColumnLayout {
    MultiSlider {
        orientation: Qt.Horizontal
        count: 4
    }

    MultiSlider {
        orientation: Qt.Vertical
        count: 4
    }
    }
}
