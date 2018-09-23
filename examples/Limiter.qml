import QtQuick 2.10
import com.github.jcelerier.CreativeControls 1.0

Container {
    width: 800
    height: 200

    AngleSlider {
        id: output
        x: 189
        y: 40
    }

    Label {
        id: text15
        x: 506
        y: 166
        text: qsTr("Limiting Amplifier")
        anchors {
            bottomMargin: 11
            topMargin: -11
            verticalCenter: text4.verticalCenter
            bottom: text4.bottom
            top: text4.top
        }
        font.pixelSize: 12
    }

    Label {
        id: text14
        x: 693
        y: 125
        text: qsTr("OFF")
        font.pixelSize: 12
    }

    Label {
        id: text13
        x: 693
        y: 92
        text: qsTr("+4")
        font.pixelSize: 12
    }

    Label {
        id: text12
        x: 693
        y: 58
        text: qsTr("+8")
        font.pixelSize: 12
    }

    Label {
        id: text11
        x: 693
        y: 24
        text: qsTr("GR")
        font.pixelSize: 12
    }

    Label {
        id: text10
        x: 660
        y: -1
        text: qsTr("Meter")
        font.pixelSize: 12
    }

    Label {
        id: text9
        x: 434
        y: -1
        text: qsTr("Ratio")
        font.pixelSize: 12
    }

    Label {
        id: text8
        x: 423
        y: 127
        text: qsTr("4")
        font.pixelSize: 12
    }

    Label {
        id: text7
        x: 422
        y: 91
        text: qsTr("8")
        font.pixelSize: 12
    }

    Label {
        id: text6
        x: 419
        y: 59
        text: qsTr("12")
        font.pixelSize: 12
    }

    Label {
        id: text5
        x: 419
        y: 22
        text: qsTr("20")
        font.pixelSize: 12
    }

    Label {
        id: text4
        x: 346
        y: 155
        text: qsTr("Release")
        font.pixelSize: 12
    }

    Label {
        id: text3
        x: 348
        y: -1
        text: qsTr("Attack")
        font.pixelSize: 12
    }

    Label {
        id: text2
        x: 218
        y: 140
        text: qsTr("Output")
        font.pixelSize: 12
    }

    Label {
        id: text1
        x: 72
        y: 140
        text: qsTr("Input")
        font.pixelSize: 12
    }

    AngleSlider {
        id: input
        x: 39
        y: 40
    }

    AngleSlider {
        id: attack
        x: 348
        y: 20
        width: 40
        height: 40
    }

    AngleSlider {
        id: release
        x: 348
        y: 113
        width: 40
        height: 40
    }

    Matrix {
        id: ratio
        x: 434
        y: 15
        width: 30
        height: 150
        spacing: 1
        rows: 4
        columns: 1
    }

    Container {
        id: container
        x: 471
        y: 13
        width: 186
        height: 134

        Graph {
            id: gr
            x: 4
            y: -3
            width: 157
            height: 121
        }
    }

    Matrix {
        id: meter
        x: 664
        y: 15
        width: 30
        height: 150
        columns: 1
        rows: 4
        spacing: 1
    }
}
