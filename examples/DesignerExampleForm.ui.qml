import QtQuick 2.4
import com.github.jcelerier.CreativeControls 1.0
import QtQuick.Layouts 1.0

Item {
    id: element
    width: 1000
    height: 600
    clip: false
    visible: true

    Container {
        id: container
        x: 16
        y: 16
        width: 900
        height: 580
        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenter: parent.horizontalCenter

        Matrix {
            id: buttonMatrix
            x: 354
            width: 300
            height: 300
            anchors.top: parent.top
            anchors.topMargin: 20
            rows: 4
            columns: 4
        }

        Label {
            id: label
            x: 368
            y: 502
            text: "QML Creative Controls"
            anchors.horizontalCenterOffset: 135
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 31
        }

        RGBSlider {
            id: rGBSliders
            x: 681
            width: 180
            height: 180
            anchors.right: parent.right
            anchors.rightMargin: 20
            anchors.top: parent.top
            anchors.topMargin: 20
        }

        Container {
            id: container2
            y: 359
            width: 310
            height: 190
            radius: 10
            anchors.left: parent.left
            anchors.leftMargin: 20
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 20

            CosInfluence {
                id: cosineInfluence
                radius: 1
                anchors.fill: parent
            }
        }

        Keyboard {
            id: pianoKeyboard
            x: 362
            y: 356
            width: 497
            height: 108
        }

        Leds {
            id: leds
            x: 681
            y: 216
            width: 180
            height: 100
            rows: 2
        }

        ToggleSwitch {
            id: toggleSwitch1
            x: 725
            y: 492
            anchors.right: parent.right
            anchors.rightMargin: 55
        }

        Container {
            id: container1
            width: 310
            height: 136
            anchors.left: parent.left
            anchors.leftMargin: 20
            anchors.top: parent.top
            anchors.topMargin: 20

            MultiSlider {
                id: element1
                ease: false
                interactive: false
                anchors.topMargin: -2
                anchors.rightMargin: -2
                textVisible: true
                anchors.fill: parent
                count: 5

                values: [0.1, 0.5, 0.9, 0.4, 0.7]
            }
        }

        Switch {
            id: element2
            x: 365
            y: 491
        }

        RowLayout {
            x: 32
            y: 192
            spacing: 20

            Joystick {
                id: joystick
                radius: 60
                Layout.preferredHeight: 120
                Layout.preferredWidth: 120
            }

            AngleSlider {
                id: angleSlider
                Layout.preferredHeight: 120
                Layout.preferredWidth: 120
            }
        }
    }
}




/*##^## Designer {
    D{i:2;anchors_y:15}D{i:4;anchors_y:35}D{i:5;anchors_height:174;anchors_width:255;anchors_x:37;anchors_y:359}
D{i:10;anchors_x:15;anchors_y:15}
}
 ##^##*/
