import QtQuick 2.0
import QtQuick.Controls 2.1
import QtQuick.Layouts 1.1
import CreativeControls 1.0

Item {
    width: 900
    height: 1200


    SwipeView
    {
        id:view

        currentIndex: 0
        anchors.fill: parent
        interactive: false

        background : Rectangle
        {
            anchors.fill : parent
            color : Styles.background
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
                    font.pointSize: 20
                    text: "Angle slider: " + angleSlider.angle.toFixed(2)
                }

                HSLSlider {
                    id: hslSlider
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
                    text: "HSL Slider: " + hslSlider.color
                }

                HSVSlider {
                    id: hsvSlider
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
                    font.pointSize: 20
                    text: "HSV Slider: " + hsvSlider.color
                }

                RGBSlider {
                    id: rgbSlider
                    Layout.column: 0
                    Layout.row: 3
                    Layout.alignment: Layout.Center
                    width: 100
                    height: 100
                }
                Text {
                    Layout.column: 1
                    Layout.row: 3
                    Layout.alignment: Qt.AlignLeft
                    font.pointSize: 20
                    text: "RGB Slider: " + rgbSlider.color
                }

                MultiSlider {
                    Layout.column: 0
                    Layout.row: 4
                    Layout.alignment: Layout.Center
                    width: 200
                    height: 100
                    count: 5
                }
                Text {
                    Layout.column: 1
                    Layout.row: 4
                    Layout.alignment: Qt.AlignLeft
                    font.pointSize: 20
                    text: "Multi Slider"
                }


                LogSlider
                {
                    Layout.column: 0
                    Layout.row: 5
                    Layout.alignment: Layout.Center
                    width: 50
                    height: 150
                }
                Text {
                    Layout.column: 1
                    Layout.row: 5
                    font.pointSize: 20
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
                        onTriggered: { graph.pushValue(Math.random()); }
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
                                array.push(Math.random() * 2 - 1);
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
                text: "Keys & Matrices"
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
                    Layout.alignment: Layout.Center

                    width: 200
                    height: 200

                    firstKey: 36
                    lastKey: 53
                }
                Text {
                    Layout.column: 1
                    Layout.row: 0
                    Layout.alignment: Qt.AlignLeft
                    font.pointSize: 20
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

                    font.pointSize: 20
                    text: "Leds"
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
