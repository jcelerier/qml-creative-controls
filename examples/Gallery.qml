import QtQuick 2.0
import QtQuick.Controls 2.1
import QtQuick.Layouts 1.1
import com.github.jcelerier.CreativeControls 1.0

Item {
    width: 900
    height: 900

    property font mainFont:
        Qt.font({
                    family: 'Fira Sans',
                    pointSize: 24
                })
    property font headerFont:
        Qt.font({
                    family: 'Fira Sans',
                    pointSize: 30,
                    bold: true
                })

    property var galleryStyle: DarkStyle
    property color textColor: galleryStyle.base

    SwipeView {
        id:view

        currentIndex: 0
        anchors.fill: parent
        interactive: false

        background: Rectangle {
            anchors.fill: parent
            color: galleryStyle.background
        }

        Page {
            background: Rectangle {
                anchors.fill: parent
                color: "transparent"
            }

            header: Text {
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                font: headerFont
                color: textColor
                height: 100
                y: 20
                text: "Sliders"
            }


            GridLayout {
                anchors {
                    centerIn: parent
                    verticalCenterOffset: -100
                }

                rows: 4
                columns: 2
                rowSpacing: 20
                columnSpacing: 200

                AngleSlider {
                    id: angleSlider
                    width: 200
                    height: 200
                    styles: galleryStyle
                    Layout.column: 0
                    Layout.row: 0
                    Layout.alignment: Layout.Center
                }

                Text {
                    Layout.column: 0
                    Layout.row: 1
                    Layout.alignment:  Layout.Center
                    Layout.preferredWidth: 100
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter

                    font {
                        pointSize: 20
                        family: mainFont
                        bold: false
                    }
                    color: textColor
                    text: "Angle slider \n" + angleSlider.angle.toFixed(2)
                }

                AngleSlider {
                    id: angleSliderMinMax

                    Layout.column: 1
                    Layout.row: 0
                    Layout.alignment: Layout.Center

                    styles: galleryStyle
                    width: 200
                    height: 200

                    angle: 0
                    min: -120
                    max: 120
                    rotation: -90
                }

                Text {
                    Layout.column: 1
                    Layout.row: 1
                    Layout.alignment: Layout.Center
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter

                    wrapMode: Text.WordWrap
                    Layout.preferredWidth: 200
                    font {
                        pointSize: 20
                        family: mainFont
                        bold: false
                    }
                    color: textColor
                    text: "Rotated with\nmin & max\n" + angleSliderMinMax.angle.toFixed(2)
                }
            }
        }

        Page {
            background: Rectangle {
                anchors.fill: parent
                color: "transparent"
            }

            header: Text {
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                font: headerFont
                color: textColor
                height: 100
                y: 20
                text: "Sliders"
            }

            GridLayout {
                anchors.centerIn: parent
                anchors.verticalCenterOffset: -100
                rows: 2
                columns: 2
                rowSpacing: 20
                columnSpacing: 100
                Container {
                    styles: galleryStyle
                    Layout.column: 0
                    Layout.row: 0
                    Layout.alignment: Layout.Center
                    width: 300
                    height: 200
                    title: "label"
                    MultiSlider {
                        styles: galleryStyle
                        anchors.fill: parent
                        spacing: 1
                        count: 6
                    }
                }

                Text {
                    Layout.column: 0
                    Layout.row: 1
                    Layout.alignment: Layout.Center
                    font {
                        pointSize: 20
                        family: mainFont
                        bold: false
                    }
                    color: textColor
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    text: "Multi Slider"
                }

                Container {
                    styles: galleryStyle
                    Layout.column: 1
                    Layout.row: 0
                    Layout.alignment: Layout.Center
                    width: 100
                    height: 300

                    VRangeSlider {
                        styles: galleryStyle
                        anchors.fill: parent
                    }
                }

                Text {
                    Layout.column: 1
                    Layout.row: 1
                    Layout.alignment: Layout.Center

                    font {
                        pointSize: 20
                        family: mainFont
                        bold: false
                    }
                    color: textColor
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    text: "Range Slider"
                }
            }
        }

        Page {
            background: Rectangle {
                anchors.fill: parent
                color: "transparent"
            }
            header: Text {
                horizontalAlignment: Text.AlignHCenter
                font: headerFont
                color: textColor
                text: "Colors"
                height: 100
                y: 20
            }

            GridLayout {
                rows: 3
                columns: 3
                rowSpacing: 20
                columnSpacing: 50
                anchors {
                    centerIn: parent
                    verticalCenterOffset: -50
                }

                Container {
                    styles: galleryStyle

                    Layout.column: 0
                    Layout.row: 0
                    Layout.alignment: Layout.Center
                    width: 200
                    height: 200

                    color: hslSlider.color
                    title: hslSlider.color

                    HSLSlider {
                        id: hslSlider
                        anchors.fill: parent
                    }
                }

                Text {
                    Layout.column: 0
                    Layout.row: 1
                    Layout.alignment: Layout.Center
                    Layout.preferredWidth: 100

                    font {
                        pointSize: 20
                        family: mainFont
                        bold: false
                    }
                    color: textColor
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    text: "HSL Slider"
                }

                Container {
                    styles: galleryStyle

                    Layout.column: 0
                    Layout.row: 2
                    Layout.alignment: Layout.Center
                    width: 200
                    height: 200
                    title: hslDonutSlider.resColor

                    DonutSlider {
                        id: hslDonutSlider
                        width: Math.min(parent.width, parent.height)
                        height: width
                        anchors.centerIn: parent
                        colorSpace: Qt.hsla
                    }
                }

                Text {    
                    Layout.column: 0
                    Layout.row: 3
                    Layout.alignment: Layout.Center
                    Layout.preferredWidth: 100
                    font {
                        pointSize: 20
                        family: mainFont
                        bold: false
                    }
                    color: textColor
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    text: "HSL Donut"
                }

                Container {
                    styles: galleryStyle
                    Layout.column: 1
                    Layout.row: 0
                    Layout.alignment: Layout.Center
                    width: 200
                    height: 200
                    color: hsvSlider.color
                    title: hsvSlider.color

                    HSVSlider {
                        id: hsvSlider
                        anchors.fill: parent
                    }
                }

                Text {
                    Layout.column: 1
                    Layout.row: 1
                    Layout.alignment: Layout.Center
                    Layout.preferredWidth: 100
                    font {
                        pointSize: 20
                        family: mainFont
                        bold: false
                    }
                    color: textColor
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    text: "HSV Slider"
                }

                Container {
                    styles: galleryStyle
                    Layout.column: 1
                    Layout.row: 2
                    Layout.alignment: Layout.Center
                    width: 200
                    height: 200
                    title:  hsvDonutSlider.resColor

                    DonutSlider {
                        id: hsvDonutSlider
                        width: Math.min(parent.width, parent.height)
                        height: width
                        anchors.centerIn: parent
                        colorSpace: Qt.hsva
                    }
                }

                Text {
                    Layout.column: 1
                    Layout.row: 3
                    Layout.alignment: Layout.Center
                    Layout.preferredWidth: 100
                    font {
                        pointSize: 20
                        family: mainFont
                        bold: false
                    }
                    color: textColor
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    text: "HSV Donut"
                }

                Container {
                    styles: galleryStyle
                    Layout.column: 2
                    Layout.row: 0
                    Layout.alignment: Layout.Center
                    width: 200
                    height: 200
                    color: rgbSlider.color
                    title: rgbSlider.color

                    RGBSlider {
                        id: rgbSlider
                        anchors.fill: parent
                    }
                }

                Text {
                    Layout.column: 2
                    Layout.row: 1
                    Layout.alignment: Layout.Center
                    Layout.preferredWidth: 100
                    font {
                        pointSize: 20
                        family: mainFont
                        bold: false
                    }
                    color: textColor
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    text: "RGB Slider\n" + rgbSlider.color
                }

                Container {
                    styles: galleryStyle
                    Layout.column: 2
                    Layout.row: 2
                    Layout.alignment: Layout.Center
                    width: 200
                    height: 200
                    title:  rgbDonutSlider.resColor

                    DonutSlider {
                        id: rgbDonutSlider
                        width: Math.min(parent.width, parent.height)
                        height: width
                        anchors.centerIn: parent
                        colorSpace: Qt.rgba
                    }
                }

                Text {
                    Layout.column: 2
                    Layout.row: 3
                    Layout.alignment: Layout.Center
                    Layout.preferredWidth: 100
                    font{
                        pointSize: 20
                        family: mainFont
                        bold: false
                    }
                    color: textColor
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    text: "RGB Donut"
                }
            }
        }

        Page {
            background: Rectangle {
                anchors.fill: parent
                color: "transparent"
            }
            header: Text {
                horizontalAlignment: Text.AlignHCenter
                font: headerFont
                color: textColor
                text: "Graphs"
                height: 100
                y: 20
            }

            GridLayout {
                rowSpacing: 20
                // columnSpacing: 100
                anchors.horizontalCenter: parent.horizontalCenter

                Graph {
                    id: graph
                    styles: galleryStyle
                    width: 300
                    height: 200
                    Layout.column: 0
                    Layout.row: 0
                    Layout.alignment: Layout.Center

                    Timer {
                        id: tm
                        repeat: true
                        onTriggered: { graph.pushValue(0.1 + 0.8*Math.random()); }
                        running: true
                        interval: 16
                    }

                    Frame {
                        styles: galleryStyle
                    }
                }

                Text {
                    Layout.column: 0
                    Layout.row: 1
                    Layout.alignment: Layout.Center
                    font {
                        pointSize: 20
                        family: mainFont
                        bold: false
                    }
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    color: textColor
                    text: "Graph"
                }

                Scope {
                    id: scope
                    styles: galleryStyle
                    width: 300
                    height: 200
                    Layout.column: 0
                    Layout.row: 2
                    Layout.alignment: Layout.Center
                    symmetrize: true

                    Timer {
                        interval: 64
                        triggeredOnStart: true
                        repeat: true
                        running: true
                        onTriggered: {
                            var array = [];
                            for (var i = 0; i < 10; i++) {
                                array.push(0.8 * (Math.random() * 2 - 1));
                            }
                            scope.points = array;
                        }
                    }

                    Frame {
                        styles: galleryStyle
                    }
                }

                Text {
                    Layout.column: 0
                    Layout.row: 3
                    Layout.alignment: Layout.Center
                    font {
                        pointSize: 20
                        family: mainFont
                        bold: false
                    }
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    color: textColor
                    text: "Scope"
                }
            }
        }

        Page {
            background: Rectangle {
                anchors.fill: parent
                color: "transparent"
            }
            leftPadding: 50
            header: Text {
                horizontalAlignment: Text.AlignHCenter
                font: headerFont
                color: galleryStyle.base
                text: "Pads"
                height: 100
                y: 20
            }

            GridLayout {
                rowSpacing: 20
                columnSpacing: 100
                anchors.horizontalCenter: parent.horizontalCenter

                XYPad {
                    id: xypad
                    styles: galleryStyle
                    Layout.column: 0
                    Layout.row: 0
                    Layout.alignment: Layout.Center
                    width: 200
                    height: 200

                    Frame {
                        styles: galleryStyle
                    }
                }

                Text {
                    Layout.column: 0
                    Layout.row: 1
                    Layout.alignment: Layout.Center
                    font {
                        pointSize: 20
                        family: mainFont
                        bold: false
                    }
                    color: textColor
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    text: "X-Y Pad\n" + xypad.stickX.toFixed(2) + ", " + xypad.stickY.toFixed(2)
                }

                CosInfluence {
                    id: cosinfluence
                    styles: galleryStyle
                    width: 200
                    height: 200
                    Layout.column: 1
                    Layout.row: 0
                    Layout.alignment: Layout.Center

                    Frame {
                        styles: galleryStyle
                    }
                }

                Text {
                    Layout.column: 1
                    Layout.row: 1
                    Layout.alignment: Qt.AlignCenter
                    font {
                        pointSize: 20
                        family: mainFont
                        bold: false
                    }
                    color: textColor
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    text: "Cosine Influence\n" + prettyArray(cosinfluence.values)

                    function prettyArray(arr) {
                        var str = "";
                        for (var i = 0; i < arr.length; ++i) {
                            str += arr[i].toFixed(2) + ", ";
                        }
                        if (str.length > 0)
                            str = str.substring(0, str.length - 2)
                        return str;
                    }
                }

                Joystick {
                    id: joystick
                    styles: galleryStyle
                    width: 200
                    height: 200
                    Layout.column: 0
                    Layout.row: 2
                    Layout.alignment: Layout.Center
                }

                Text {
                    Layout.column: 0
                    Layout.row: 3
                    Layout.alignment: Layout.Center
                    font {
                        pointSize: 20
                        family: mainFont
                        bold: false
                    }
                    color: textColor
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    text: "Joystick\n"
                          + "X: " + joystick.stickX.toFixed(2) + ", Y: " + joystick.stickY.toFixed(2)
                          + "\nR: "+ joystick.stickR.toFixed(2) + ", θ: " + joystick.stickTheta.toFixed(2)
                }
            }
        }

        Page {
            background: Rectangle {
                anchors.fill: parent
                color: "transparent"
            }
            header: Text {
                horizontalAlignment: Text.AlignHCenter
                font: headerFont
                color: textColor
                text: "Keys & Matrices & Switch"
                height: 100
                y: 20
            }

            Container{
                anchors {
                    centerIn: parent
                    horizontalCenterOffset: 0
                    verticalCenterOffset: 50
                }
                width: 700
                height: 380
                styles: galleryStyle
                visible: false
            }

            GridLayout {
                rowSpacing: 50
                columnSpacing: 80
                anchors.horizontalCenter: parent.horizontalCenter

                Container {
                    styles: galleryStyle

                    Layout.alignment: Layout.Center
                    Layout.column: 0
                    Layout.row: 0

                    width: 300
                    height: 120

                    Keyboard {
                        id: kbd
                        styles: galleryStyle
                        anchors.centerIn: parent
                        height: parent.height - parent.radius*2.
                        width: parent.width - parent.radius*2.
                        firstKey: 36
                        lastKey: 62
                    }
                }

                Text {
                    Layout.column: 0
                    Layout.row: 1
                    Layout.alignment: Layout.Center
                    Layout.maximumWidth: 200
                    font {
                        pointSize: 20
                        family: mainFont
                        bold: false
                    }
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    color: textColor
                    text: {
                        if (kbd.pressedKeys.length > 0)
                            return "Keyboard\n" + kbd.pressedKeys[0].key.toFixed(0) + ", " + kbd.pressedKeys[0].vel.toFixed(0)
                        else
                            return "Keyboard\n"
                    }
                }

                Container {
                    styles: galleryStyle

                    Layout.column: 1
                    Layout.row: 0
                    Layout.alignment: Layout.Center

                    height: 100
                    width: 300

                    Row {
                        anchors.centerIn: parent
                        width: 250
                        spacing: 100

                        ToggleSwitch {
                            id: toggleSwitch

                            styles: galleryStyle

                            width: 80
                            height: 50
                            onToggle: leds.setIntensityForAll(!onoff)
                        }

                        Switch {
                            id: pressSwitch

                            styles: galleryStyle

                            width: 50
                            height: 50
                            onPressed: leds.setIntensityForAll(0)
                            onReleased: leds.setIntensityForAll(1)
                        }
                    }
                }

                Row {
                    Layout.column: 1
                    Layout.row: 1
                    Layout.alignment: Layout.Center
                    Layout.topMargin: -30
                    width: 250
                    spacing: 30

                    Text {
                        font {
                            pointSize: 20
                            family: mainFont
                            bold: false
                        }
                        color: textColor
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                        text: "ToggleSwitch\n" + toggleSwitch.state
                    }

                    Text {
                        font {
                            pointSize: 20
                            family: mainFont
                            bold: false
                        }
                        color: textColor
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                        text: "PressSwitch\n" + pressSwitch.state
                    }
                }


                Matrix {
                    id: matrix
                    styles: galleryStyle

                    Layout.column: 0
                    Layout.row: 2
                    Layout.alignment: Layout.Center

                    width: 240
                    height: 240
                    onPressedChanged: {
                        if (matrix.pressed.length > 0)
                            leds.toggle(matrix.pressed[0]);

                        //else
                        //  leds.setIntensityForAll(0.0);
                    }
                }

                Text {
                    Layout.column: 0
                    Layout.row: 3
                    Layout.alignment: Layout.Center
                    font {
                        pointSize: 20
                        family: mainFont
                        bold: false
                    }
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    color: textColor
                    text: {
                        if (matrix.pressed.length > 0)
                            return "Matrix\n" + matrix.pressed[0]
                        else
                            return "Matrix\n"
                    }
                }

                Leds {
                    id: leds
                    styles: galleryStyle

                    Layout.column: 1
                    Layout.row: 2
                    Layout.alignment: Layout.Center
                    width: 240
                    height: 240
                    easing: true

                    // all leds to off
                    intensity: [
                        [1., 1., 1.],
                        [1., 1., 1.],
                        [1., 1., 1.]
                    ]
                }

                Text {
                    Layout.column: 1
                    Layout.row: 3
                    Layout.alignment: Layout.Center

                    font {
                        pointSize: 20
                        family: mainFont
                        bold: false
                    }
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    color: textColor
                    text: "Leds\n"
                }
            }
        }
    }

    Row {
        height: 50
        spacing: 5

        Button {
            id: btnPrevious

            opacity: view.currentIndex > 0

            width: parent.width / 2
            height: parent.height

            onClicked: view.currentIndex = Math.max(view.currentIndex - 1, 0)

            background: Rectangle {
                anchors.fill: parent
                color: btnPrevious.pressed ? galleryStyle.colorOn : galleryStyle.background
            }

            font.bold: false
            contentItem: Text {
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                color: btnPrevious.pressed ? galleryStyle.detail : galleryStyle.colorOn
                font {
                    pointSize: 15
                    family: mainFont
                    bold: true
                }
                text: "Previous"
            }
        }

        Button {
            id: btnNext

            opacity: view.currentIndex < (view.count - 1)
            width: parent.width / 2
            height: parent.height

            onClicked: view.currentIndex = Math.min(view.currentIndex + 1, view.count - 1)

            background: Rectangle{
                anchors.fill: parent
                color: btnNext.pressed ? galleryStyle.colorOn : galleryStyle.background
            }

            font.bold: false
            contentItem: Text {
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                color: btnNext.pressed ? galleryStyle.detail : galleryStyle.colorOn
                font {
                    pointSize: 15
                    bold: true
                    family: mainFont
                }
                text: "Next"
            }
        }

        anchors.bottom: parent.bottom
        width: parent.width
    }

    Column {
        anchors{
            top: parent.top
            topMargin: 20
            left: parent.left
            leftMargin: 20
        }
        spacing: 5

        Rectangle {
            width: 100
            height: 30
            color: galleryStyle == LightStyle
                   ? LightStyle.colorOn
                   : LightStyle.background

            border {
                color: LightStyle.detail
                width: 2
            }

            Text {
                anchors.centerIn: parent
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter

                font.bold: true
                text: "Light Style"
                color: galleryStyle == LightStyle
                       ? LightStyle.detail
                       : LightStyle.labelColor
            }

            MouseArea {
                anchors.fill: parent
                enabled: true
                onPressed: galleryStyle = LightStyle
            }
        }

        Rectangle {
            width: 100
            height: 30
            color: galleryStyle == DarkStyle
                   ? DarkStyle.colorOn
                   : DarkStyle.background

            border {
                color: DarkStyle.detail
                width: 2
            }

            Text {
                anchors.centerIn: parent
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter

                font.bold: true
                text: "Dark Style"
                color: galleryStyle == DarkStyle
                       ? DarkStyle.detail
                       : DarkStyle.labelColor
            }

            MouseArea {
                anchors.fill: parent
                enabled: true
                onPressed: galleryStyle = DarkStyle
            }
        }
    }
}
