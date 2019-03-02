import QtQuick 2.4
import com.github.jcelerier.CreativeControls 1.0

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
            x: 365
            y: 33
            width: 300
            height: 300
            rows: 4
            columns: 4
        }

        Label {
            id: label
            x: 368
            y: 512
            text: "QML Creative Controls"
            anchors.horizontalCenterOffset: 100
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 31
        }

        RGBSlider {
            id: rGBSliders
            x: 681
            y: 35
            width: 180
            height: 180
        }

        Joystick {
            id: joystick
            x: 32
            y: 219
            width: 100
            height: 100
            radius: 50
        }

        AngleSlider {
            id: angleSlider
            x: 181
            y: 217
        }

        Container {
            id: container2
            x: 37
            y: 356
            width: 255
            height: 174

            CosInfluence {
                id: cosineInfluence
                anchors.fill: parent
            }
        }

        Keyboard {
            id: pianoKeyboard
            x: 365
            y: 356
            width: 497
            height: 108
        }

        Leds {
            id: leds
            x: 681
            y: 229
            width: 180
            height: 100
            rows: 2
        }

        ToggleSwitch {
            id: toggleSwitch1
            x: 485
            y: 491
            anchors.right: parent.right
            anchors.rightMargin: 100
        }

        Container {
            id: container1
            x: 19
            y: 15
            width: 310
            height: 136

            MultiSlider {
                id: element1
                ease: false
                interactive: false
                anchors.topMargin: -2
                anchors.rightMargin: -2
                textVisible: true
                anchors.fill: parent
                values: [0.2, 0.6, 0.7, 0.3, 0.8]
                count: 5
            }
        }
    }
}
