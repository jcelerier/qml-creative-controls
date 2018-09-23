import QtQuick 2.0
import QtQuick.Controls 2.1
import QtQuick.Layouts 1.1
import com.github.jcelerier.CreativeControls 1.0

Page {
    Row {
        Container {
            height: col.childrenRect.height + 2 * radius

            Column {
                id: col

                Repeater {
                    model :5

                    Column {
                        HSlider {
                            height: 50
                        }
                        Text {
                            height: 50
                            text: "coucou"
                            color: "white"
                            font.pointSize: 34
                        }
                    }
                }
            }
        }

        Container {
            VSlider {
                anchors.fill: parent
            }
        }
    }
}
