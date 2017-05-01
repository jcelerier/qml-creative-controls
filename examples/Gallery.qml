import QtQuick 2.0
import QtQuick.Controls 2.1
import QtQuick.Layouts 1.1
import CreativeControls 1.0

Item {
    width: 900
    height: 900

    property font mainFont: Qt.font({
                                        family: 'Monospace',
                                        weight: Font.Black,
                                        bold: true,
                                        italic: false,
                                        pointSize: 24
                                    })

    SwipeView
    {
        id:view

        currentIndex: 0
        anchors.fill: parent
        interactive: false

        background : Rectangle
        {
            anchors.fill : parent
            color : Styles.colorOff
        }
        Page
        {

            background : Rectangle
            {
                anchors.fill : parent
                color : "transparent"
            }
            leftPadding: 50
            header: Text
            {
                horizontalAlignment: Text.AlignHCenter
                font.pointSize: 30
                font.family: mainFont

                text: "Sliders"
            }

            GridLayout
            {
                rowSpacing: 20
                columnSpacing: 10

                AngleSlider {
                    id: angleSlider
                    Layout.column: 0
                    Layout.row: 0
                    Layout.alignment: Layout.Center
                }
                Text {
                    Layout.column: 1
                    Layout.row: 0
                    Layout.alignment: Qt.AlignLeft
                    Layout.preferredWidth: 200

                    font.pointSize: 20
                    font.family: mainFont
                    text: "Angle slider: " + angleSlider.angle.toFixed(2)
                }

                AngleSlider {
                    id: angleSliderMinMax
                    Layout.column: 2
                    Layout.row: 0
                    Layout.alignment: Layout.Center
                    Layout.leftMargin: 40

                    width: 100
                    height: 100
                    angle: 0
                    min: -120
                    max: 120
                    transform: Rotation { origin.x: 50; origin.y: 50; angle: -90}
                }
                Text {
                    Layout.column: 3
                    Layout.row: 0
                    Layout.alignment: Qt.AlignLeft

                    wrapMode : Text.WordWrap
                    Layout.preferredWidth: 200
                    font.pointSize: 20
                    font.family: mainFont
                    text: "Rotated angle slider with min and max: " + angleSliderMinMax.angle.toFixed(2)
                }


                MultiSlider {
                    Layout.column: 0
                    Layout.row: 5
                    Layout.alignment: Layout.Center
                    count: 4
                }
                Text {
                    Layout.column: 1
                    Layout.row: 5
                    Layout.alignment: Qt.AlignLeft
                    font.pointSize: 20
                    font.family: mainFont
                    text: "Multi Slider"
                }


                LogSlider
                {
                    Layout.column: 0
                    Layout.row: 6
                    Layout.alignment: Layout.Center
                    width: 150
                    height: 50
                }
                Text {
                    Layout.column: 1
                    Layout.row: 6
                    font.pointSize: 20
                    font.family: mainFont
                    text: "Log Slider"
                }
                /*
                RangeSlider
                {
                    Layout.column: 0
                    Layout.row: 6
                    Layout.alignment: Layout.Center
                }
                Text {
                    Layout.column: 1
                    Layout.row: 6
                    font.pointSize: 20
                    text: "Range Slider"
                }
                */
            }
        }
        Page
        {

            background : Rectangle
            {
                anchors.fill : parent
                color : "transparent"
            }
            leftPadding: 50
            header: Text
            {
                horizontalAlignment: Text.AlignHCenter
                font.pointSize: 30
                font.family: mainFont

                text: "Colors"
            }

            GridLayout
            {
                rowSpacing: 20
                columnSpacing: 10


                HSLSlider {
                    id: hslSlider
                    Layout.column: 0
                    Layout.row: 0
                    Layout.alignment: Layout.Center
                    width: 100
                    height: 100
                }
                Text {
                    Layout.column: 1
                    Layout.row: 0
                    Layout.alignment: Qt.AlignLeft
                    font.pointSize: 20
                    font.family: mainFont
                    text: "HSL Slider: " + hslSlider.color
                }
                Rectangle {
                    Layout.column: 2
                    Layout.row: 0

                    color: Styles.background
                    border.color : Styles.base
                    border.width: 3
                    radius : 10
                    width: 150
                    height: 150

                    Layout.alignment: Layout.Center
                    Layout.leftMargin: 40

                    DonutSlider {
                        x: parent.radius
                        y: parent.radius
                        id: hslDonutSlider
                        width: parent.width - 2 * parent.radius
                        height: parent.height - 2 * parent.radius
                        colorSpace : Qt.hsla
                    }
                }
                Text {
                    Layout.column: 3
                    Layout.row: 0
                    Layout.alignment: Qt.AlignLeft
                    font.pointSize: 20
                    font.family: mainFont
                    text: "HSL Donut: " + hslDonutSlider.resColor
                }

                HSVSlider {
                    id: hsvSlider
                    Layout.column: 0
                    Layout.row: 1
                    Layout.alignment: Layout.Center
                    width: 100
                    height: 100
                }
                Text {
                    Layout.column: 1
                    Layout.row: 1
                    Layout.alignment: Qt.AlignLeft
                    font.pointSize: 20
                    font.family: mainFont
                    text: "HSV Slider: " + hsvSlider.color
                }

                Rectangle {

                    Layout.column: 2
                    Layout.row: 1

                    color: Styles.background
                    border.color : Styles.base
                    border.width: 3
                    radius : 10
                    width: 150
                    height: 150

                    Layout.alignment: Layout.Center
                    Layout.leftMargin: 40

                    DonutSlider {
                        x: parent.radius
                        y: parent.radius
                        id: hsvDonutSlider
                        width: parent.width - 2 * parent.radius
                        height: parent.height - 2 * parent.radius
                        colorSpace : Qt.hsva
                    }
                }
                Text {
                    Layout.column: 3
                    Layout.row: 1
                    Layout.alignment: Qt.AlignLeft
                    font.pointSize: 20
                    font.family: mainFont
                    text: "HSV Donut: " + hsvDonutSlider.resColor
                }

                RGBSlider {
                    id: rgbSlider
                    Layout.column: 0
                    Layout.row: 2
                    Layout.alignment: Layout.Center

                    width: 100
                    height: 100
                }
                Text {
                    Layout.column: 1
                    Layout.row: 2
                    Layout.alignment: Qt.AlignLeft
                    Layout.preferredWidth: 200

                    font.pointSize: 20
                    font.family: mainFont
                    text: "RGB Slider: " + rgbSlider.color
                }
                Rectangle {
                    Layout.column: 2
                    Layout.row: 2

                    color: Styles.background
                    border.color : Styles.base
                    border.width: 3
                    radius : 10
                    width: 150
                    height: 150

                    Layout.alignment: Layout.Center
                    Layout.leftMargin: 40

                    DonutSlider {
                        x: parent.radius
                        y: parent.radius
                        id: rgbDonutSlider
                        width: parent.width - 2 * parent.radius
                        height: parent.height - 2 * parent.radius
                        colorSpace : Qt.rgba
                    }
                }
                Text {
                    Layout.column: 3
                    Layout.row: 2
                    Layout.alignment: Qt.AlignLeft
                    font.pointSize: 20
                    font.family: mainFont
                    text: "RGB Donut: " + rgbDonutSlider.resColor
                }


            }
        }

        Page
        {
            background : Rectangle
            {
                anchors.fill : parent
                color : "transparent"
            }
            leftPadding: 50
            header: Text
            {
                horizontalAlignment: Text.AlignHCenter
                font.pointSize: 30
                text: "Graphs"
            }

            GridLayout
            {
                rowSpacing: 20
                columnSpacing: 10

                Graph
                {
                    id: graph
                    width: 200
                    height: 100
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
                    Frame{}
                }
                Text {
                    Layout.column: 1
                    Layout.row: 0
                    Layout.alignment: Qt.AlignLeft
                    font.pointSize: 20
                    font.family: mainFont
                    text: "Graph"
                }

                Scope
                {
                    id: scope
                    width: 200
                    height: 100
                    Layout.column: 0
                    Layout.row: 1
                    Layout.alignment: Layout.Center
                    symmetrize: true

                    Timer
                    {
                        interval: 64
                        triggeredOnStart: true
                        repeat: true
                        running: true
                        onTriggered: {
                            var array = [];
                            for(var i = 0; i < 10; i++)
                            {
                                array.push(0.8 * (Math.random() * 2 - 1));
                            }
                            scope.points = array;
                        }
                    }
                    Frame{}
                }
                Text {
                    Layout.column: 1
                    Layout.row: 1
                    Layout.alignment: Qt.AlignLeft
                    font.pointSize: 20
                    font.family: mainFont
                    text: "Scope"
                }
            }
        }

        Page
        {
            background : Rectangle
            {
                anchors.fill : parent
                color : "transparent"
            }
            leftPadding: 50
            header: Text
            {
                horizontalAlignment: Text.AlignHCenter
                font.pointSize: 30
                font.family: mainFont
                text: "Pads"
            }

            GridLayout
            {
                rowSpacing: 20
                columnSpacing: 10

                Joystick
                {
                    id: joystick
                    width: 200
                    height: 200
                    Layout.column: 0
                    Layout.row: 0
                    Layout.alignment: Layout.Center
                }
                Text {
                    Layout.column: 1
                    Layout.row: 0
                    Layout.alignment: Qt.AlignLeft
                    font.pointSize: 20
                    font.family: mainFont
                    text: "Joystick: " + joystick.stickX.toFixed(2) + ", " + joystick.stickY.toFixed(2)
                }



                XYPad
                {
                    id: xypad

                    Layout.column: 0
                    Layout.row: 1
                    Layout.alignment: Layout.Center

                    width: 200
                    height: 200

                    Frame{}
                }
                Text {
                    Layout.column: 1
                    Layout.row: 1
                    Layout.alignment: Qt.AlignLeft
                    font.pointSize: 20
                    font.family: mainFont
                    text: "X-Y Pad: " + xypad.stickX + ", " + xypad.stickY
                }

                CosInfluence
                {
                    id: cosinfluence
                    width: 200
                    height: 200
                    Layout.column: 0
                    Layout.row: 2
                    Layout.alignment: Layout.Center

                    Frame{}
                }
                Text {
                    Layout.column: 1
                    Layout.row: 2
                    Layout.alignment: Qt.AlignLeft
                    font.pointSize: 20
                    font.family: mainFont
                    text: "Cosine Influence: " + prettyArray(cosinfluence.values)

                    function prettyArray(arr)
                    {
                        var str = "";
                        for(var i = 0; i < arr.length; ++i)
                        {
                            str += arr[i].toFixed(2) + ", ";
                        }
                        if(str.length > 0)
                            str = str.substring(0, str.length - 2)
                        return str;
                    }
                }
            }
        }

        Page
        {
            background : Rectangle
            {
                anchors.fill : parent
                color : "transparent"
            }
            leftPadding: 50
            header: Text
            {
                horizontalAlignment: Text.AlignHCenter
                font.pointSize: 30
                font.family: mainFont
                text: "Keys & Matrices & Switch"
            }

            GridLayout
            {
                rowSpacing: 20
                columnSpacing: 10

                Keyboard
                {
                    id: kbd
                    Layout.column: 0
                    Layout.row: 0
                    Layout.preferredHeight: 100
                    Layout.preferredWidth: 200

                    Layout.alignment: Layout.Center

                    firstKey: 36
                    lastKey: 53
                }
                Text {
                    Layout.column: 1
                    Layout.row: 0
                    Layout.alignment: Qt.AlignLeft
                    Layout.maximumWidth: 200
                    font.pointSize: 20
                    font.family: mainFont
                    text:
                    {
                        if(kbd.pressedKeys.length > 0)
                            "Keyboard: " + kbd.pressedKeys[0].key.toFixed(0) + ", " + kbd.pressedKeys[0].vel.toFixed(0)
                        else
                            "Keyboard"
                    }
                }

                Matrix
                {
                    id: matrix
                    Layout.column: 0
                    Layout.row: 1
                    Layout.alignment: Layout.Center

                    width: 200
                    height: 200
                    onPressedChanged:
                    {
                        if(matrix.pressed.length > 0)
                            leds.toggle(matrix.pressed[0]);

                        //else
                        //  leds.setIntensityForAll(0.0);
                    }

                }
                Text {
                    Layout.column: 1
                    Layout.row: 1
                    Layout.alignment: Qt.AlignLeft
                    font.pointSize: 20
                    font.family: mainFont
                    text:
                    {
                        if(matrix.pressed.length > 0)
                            "Matrix: " + matrix.pressed[0]
                        else
                            "Matrix"
                    }
                }

                Leds
                {
                    id : leds

                    Layout.column: 0
                    Layout.row: 2
                    Layout.alignment: Layout.Center
                    Layout.preferredWidth: 200
                    width: 200
                    height: 200
                    easing : true

                    // all leds to off
                    intensity : [
                        [1., 1.,1.],
                        [1.,1.,1.],
                        [1.,1.,1.]
                    ]
                }
                Text {
                    Layout.column: 1
                    Layout.row: 2
                    Layout.alignment: Qt.AlignLeft
                    Layout.preferredWidth: 200

                    font.pointSize: 20
                    font.family: mainFont
                    text: "Leds"
                }

                Switch
                {
                    id : toggleSwitch

                    Layout.column: 2
                    Layout.row: 2
                    Layout.alignment: Layout.Center
                    Layout.leftMargin: 100
                    width: 50
                    height: 50
                    onToggle: leds.setIntensityForAll(!onoff);

                }
                Text {
                    Layout.column: 3
                    Layout.row: 2
                    Layout.alignment: Qt.AlignLeft

                    font.pointSize: 20
                    font.family: mainFont
                    text: "Switch"
                }
            }
        }
    }
    Row{

        Button
        {
            onClicked: view.currentIndex = Math.max(view.currentIndex - 1, 0)
            text: "Previous"
            width: parent.width / 2
        }

        Button
        {
            onClicked: view.currentIndex = Math.min(view.currentIndex + 1, view.count - 1)
            text: "Next"
            width: parent.width / 2
        }

        anchors.bottom: parent.bottom
        width: parent.width
    }
}
