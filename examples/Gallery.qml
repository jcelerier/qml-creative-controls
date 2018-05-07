import QtQuick 2.0
import QtQuick.Controls 2.1
import QtQuick.Layouts 1.1
import CreativeControls 1.0

Item {
    width: 900
    height: 900

    property font mainFont:
        Qt.font({
                    family: 'Monospace',
                    weight: Font.Black,
                    bold: true,
                    italic: false,
                    pointSize: 24
                })

    property var galleryStyle: DarkStyle

    SwipeView
    {
        id:view

        currentIndex: 0
        anchors.fill: parent
        interactive: false

        background : Rectangle
        {
            anchors.fill : parent
            color : galleryStyle.background

        }

        Page
        {

            background : Rectangle
            {
                anchors.fill : parent
                color : "transparent"
            }

            header: Text
            {
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                font.pointSize: 30
                font.family: mainFont
                font.bold : true
                color : galleryStyle.base
                height : 100
                y : 20
                text: "Sliders"
            }

            GridLayout
            {
                anchors.horizontalCenter: parent.horizontalCenter
                rows : 4
                columns : 2
                rowSpacing: 20
                columnSpacing: 200

                Container
                {
                    styles: galleryStyle

                    Layout.column: 0
                    Layout.row: 0
                    Layout.alignment: Layout.Center

                    width: 200
                    height: 200
                    title: angleSlider.angle.toFixed(2)

                    AngleSlider {
                        id: angleSlider

                        styles: galleryStyle

                        width: Math.min(parent.width,parent.height)
                        height: width
                        anchors.centerIn: parent
                    }
                }

                Text {
                    Layout.column: 0
                    Layout.row: 1
                    Layout.alignment:  Layout.Center
                    Layout.preferredWidth: 100
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter

                    font.pointSize: 20
                    font.family: mainFont
                    font.bold : true
                    color : galleryStyle.background
                    text: "Angle slider"
                }
                Container
                {
                    styles: galleryStyle

                    Layout.column: 1
                    Layout.row: 0
                    Layout.alignment: Layout.Center

                    width: 200
                    height: 200

                    title: angleSliderMinMax.angle.toFixed(2)

                    AngleSlider {
                        id: angleSliderMinMax

                        styles: galleryStyle

                        width: Math.min(parent.width,parent.height)
                        height: width
                        anchors.centerIn: parent
                        angle: 0
                        min: -120
                        max: 120
                        rotation: -90
                    }
                }
                Text {
                    Layout.column: 1
                    Layout.row: 1
                    Layout.alignment: Layout.Center
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter

                    wrapMode : Text.WordWrap
                    Layout.preferredWidth: 200
                    font.pointSize: 20
                    font.family: mainFont
                    font.bold : true
                    color : galleryStyle.background
                    text: "Rotated with\nmin & max\n"
                }
                /*
                Container
                {
                    Layout.column: 0
                    Layout.row: 2
                    Layout.alignment: Layout.Center
                    width : 300
                    height : 200
                    title: "label"
                    MultiSlider {
                        anchors.fill: parent
                        count: 6
                    }
                }

                Text {
                    Layout.column: 0
                    Layout.row: 3
                    Layout.alignment: Layout.Center
                    font.pointSize: 20
                    font.family: mainFont
                    font.bold : true
                    color : galleryStyle.background
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    text: "Multi Slider"
                }

                Container
                {
                    Layout.column: 1
                    Layout.row: 2
                    Layout.alignment: Layout.Center
                    width: 200
                    height: 100

                   //  title: "label"
                    HSlider
                    {
                        text : value.toFixed(3)
                        mapFunc: Utils.sliderLogMap()
                        anchors.fill : parent
                    }
                }
                Text {
                    Layout.column: 1
                    Layout.row: 3
                    Layout.alignment: Layout.Center

                    font.pointSize: 20
                    font.family: mainFont
                    font.bold : true
                    color : galleryStyle.background
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    text: "Log Slider"
                }
                Container
                {
                    Layout.column: 0
                    Layout.row: 4
                    Layout.alignment: Layout.Center
                    width: 50
                    height: 150

                    RangeSlider
                    {
                        anchors.centerIn : parent
                        width : parent.width - 2 * parent.radius
                        height : parent.height - 2 * parent.radius
                        orientation: Qt.Vertical
                    }
                }
                 Text {
                    Layout.column: 1
                    Layout.row: 5

                    font.pointSize: 20
                    font.family: mainFont
                    font.bold : true
                    color : galleryStyle.background
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
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

            header: Text
            {
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                font.pointSize: 30
                font.family: mainFont
                font.bold : true
                color : galleryStyle.base
                height : 100
                y : 20
                text: "Sliders"
            }

            GridLayout
            {
                anchors.horizontalCenter: parent.horizontalCenter
                rows : 4
                columns : 2
                rowSpacing: 20
                columnSpacing: 200
                Container
                {
                    styles: galleryStyle

                    Layout.column: 0
                    Layout.row: 0
                    Layout.alignment: Layout.Center
                    width : 300
                    height : 200
                    title: "label"
                    MultiSlider {
                        styles: galleryStyle

                        anchors.fill: parent
                        count: 6
                    }
                }

                Text {
                    Layout.column: 0
                    Layout.row: 1
                    Layout.alignment: Layout.Center
                    font.pointSize: 20
                    font.family: mainFont
                    font.bold : true
                    color : galleryStyle.background
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    text: "Multi Slider"
                }


                Container
                {
                    styles: galleryStyle

                    Layout.column: 0
                    Layout.row: 2
                    Layout.alignment: Layout.Center
                    width: 100
                    height: 300

                    VRangeSlider
                    {
                        styles: galleryStyle

                        anchors.fill : parent
                    }
                }
                Text {
                    Layout.column: 0
                    Layout.row: 3
                    Layout.alignment: Layout.Center

                    font.pointSize: 20
                    font.family: mainFont
                    font.bold : true
                    color : galleryStyle.background
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    text: "Range Slider"
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
            header: Text
            {
                horizontalAlignment: Text.AlignHCenter
                font.pointSize: 30
                font.family: mainFont
                font.bold : true
                color : galleryStyle.base
                text: "Colors"
                height : 100
                y : 20
            }

            GridLayout
            {
                rows : 3
                columns : 3
                rowSpacing: 20
                columnSpacing: 50
                anchors.horizontalCenter: parent.horizontalCenter
                Container
                {
                    styles: galleryStyle

                    Layout.column: 0
                    Layout.row: 0
                    Layout.alignment: Layout.Center
                    width: 200
                    height : 200

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

                    font.pointSize: 20
                    font.family: mainFont
                    font.bold : true
                    color : galleryStyle.background
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
                    height : 200
                    title:  hslDonutSlider.resColor
                    DonutSlider {
                        id: hslDonutSlider

                        width: Math.min(parent.width,parent.height)
                        height: width
                        anchors.centerIn: parent

                        colorSpace : Qt.hsla
                    }
                }
                Text {
                    Layout.column: 0
                    Layout.row: 3
                    Layout.alignment: Layout.Center
                    Layout.preferredWidth: 100

                    font.pointSize: 20
                    font.family: mainFont
                    font.bold : true
                    color : galleryStyle.background
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    text: "HSL Donut"
                }
                Container
                {
                    styles: galleryStyle

                    Layout.column: 1
                    Layout.row: 0
                    Layout.alignment: Layout.Center
                    width: 200
                    height : 200

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
                    font.pointSize: 20
                    font.family: mainFont
                    font.bold : true
                    color : galleryStyle.background
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
                    height : 200
                    title:  hsvDonutSlider.resColor

                    DonutSlider {
                        id: hsvDonutSlider

                        width: Math.min(parent.width,parent.height)
                        height: width
                        anchors.centerIn: parent
                        colorSpace : Qt.hsva
                    }
                }
                Text {
                    Layout.column: 1
                    Layout.row: 3
                    Layout.alignment: Layout.Center
                    Layout.preferredWidth: 100
                    font.pointSize: 20
                    font.family: mainFont
                    font.bold : true
                    color : galleryStyle.background
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    text: "HSV Donut"
                }

                Container
                {
                    styles: galleryStyle

                    Layout.column: 2
                    Layout.row: 0
                    Layout.alignment: Layout.Center
                    width: 200
                    height : 200

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

                    font.pointSize: 20
                    font.family: mainFont
                    font.bold : true
                    color : galleryStyle.background
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
                    height : 200
                    title:  rgbDonutSlider.resColor
                    DonutSlider {
                        id: rgbDonutSlider

                        width: Math.min(parent.width,parent.height)
                        height: width
                        anchors.centerIn: parent
                        colorSpace : Qt.rgba
                    }
                }
                Text {
                    Layout.column: 2
                    Layout.row: 3
                    Layout.alignment: Layout.Center
                    Layout.preferredWidth: 100
                    font.pointSize: 20
                    font.family: mainFont
                    font.bold : true
                    color : galleryStyle.background
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    text: "RGB Donut"
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
            header: Text
            {
                horizontalAlignment: Text.AlignHCenter
                font.pointSize: 30
                font.bold : true
                color : galleryStyle.base
                text: "Graphs"
                height : 100
                y : 20
            }

            GridLayout
            {
                rowSpacing: 20
                //columnSpacing: 100
                anchors.horizontalCenter: parent.horizontalCenter

                Graph
                {
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
                    Frame{
                        styles: galleryStyle
                    }
                }
                Text {
                    Layout.column: 0
                    Layout.row: 1
                    Layout.alignment: Layout.Center
                    font.pointSize: 20
                    font.family: mainFont
                    font.bold : true
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    color : galleryStyle.background
                    text: "Graph"
                }

                Scope
                {
                    id: scope

                    styles: galleryStyle

                    width: 300
                    height: 200
                    Layout.column: 0
                    Layout.row: 2
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
                    Frame{
                        styles: galleryStyle
                    }
                }
                Text {
                    Layout.column: 0
                    Layout.row: 3
                    Layout.alignment: Layout.Center
                    font.pointSize: 20
                    font.family: mainFont
                    font.bold : true
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    color : galleryStyle.background
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
                font.bold : true
                color : galleryStyle.base
                text: "Pads"
                height : 100
                y : 20
            }

            GridLayout
            {
                rowSpacing: 20
                columnSpacing: 100
                anchors.horizontalCenter: parent.horizontalCenter

                XYPad
                {
                    id: xypad

                    styles: galleryStyle

                    Layout.column: 0
                    Layout.row: 0
                    Layout.alignment: Layout.Center

                    width: 200
                    height: 200

                    Frame{
                        styles: galleryStyle
                    }
                }
                Text {
                    Layout.column: 0
                    Layout.row: 1
                    Layout.alignment: Layout.Center
                    font.pointSize: 20
                    font.family: mainFont
                    font.bold : true
                    color : galleryStyle.background
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    text: "X-Y Pad\n" + xypad.stickX.toFixed(2) + ", " + xypad.stickY.toFixed(2)
                }

                CosInfluence
                {
                    id: cosinfluence

                    styles: galleryStyle

                    width: 200
                    height: 200
                    Layout.column: 1
                    Layout.row: 0
                    Layout.alignment: Layout.Center

                    Frame{
                        styles: galleryStyle
                    }
                }
                Text {
                    Layout.column: 1
                    Layout.row: 1
                    Layout.alignment: Qt.AlignCenter
                    font.pointSize: 20
                    font.family: mainFont
                    font.bold : true
                    color : galleryStyle.background
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    text: "Cosine Influence\n" + prettyArray(cosinfluence.values)

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
                Joystick
                {
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
                    font.pointSize: 20
                    font.family: mainFont
                    font.bold : true
                    color : galleryStyle.background
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    text: "Joystick\n" + joystick.stickX.toFixed(2) + ", " + joystick.stickY.toFixed(2)
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
            header: Text
            {
                horizontalAlignment: Text.AlignHCenter
                font.pointSize: 30
                font.family: mainFont
                font.bold : true
                color : galleryStyle.base
                text: "Keys & Matrices & Switch"
                height : 100
                y : 20
            }

            GridLayout
            {
                rowSpacing: 50
                columnSpacing: 100
                anchors.horizontalCenter: parent.horizontalCenter
                Container {
                    styles: galleryStyle

                    Layout.alignment: Layout.Center
                    Layout.column: 0
                    Layout.row: 0

                    width: 300
                    height: 120

                    Keyboard
                    {
                        id: kbd

                        styles: galleryStyle

                        anchors.centerIn: parent
                        height : parent.height - parent.radius*2.
                        width : parent.width - parent.radius*2.

                        firstKey: 36
                        lastKey: 62
                    }
                }
                Text {
                    Layout.column: 0
                    Layout.row: 1
                    Layout.alignment: Layout.Center
                    Layout.maximumWidth: 200
                    font.pointSize: 20
                    font.family: mainFont
                    font.bold : true
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    color : galleryStyle.background
                    text:
                    {
                        if(kbd.pressedKeys.length > 0)
                            "Keyboard\n" + kbd.pressedKeys[0].key.toFixed(0) + ", " + kbd.pressedKeys[0].vel.toFixed(0)
                        else
                            "Keyboard\n"
                    }
                }
                Container {
                    styles: galleryStyle

                    Layout.column: 1
                    Layout.row: 0
                    Layout.alignment: Layout.Center
                    height: 100
                    width: 100
                    Switch
                    {
                        id : toggleSwitch

                        styles: galleryStyle

                        anchors.centerIn: parent

                        width: 50
                        height: 50
                        onToggle: leds.setIntensityForAll(!onoff);

                    }
                }
                Text {
                    Layout.column: 1
                    Layout.row: 1
                    Layout.alignment: Layout.Center

                    font.pointSize: 20
                    font.family: mainFont
                    font.bold : true
                    color : galleryStyle.background
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    text: "Switch\n" + toggleSwitch.state
                }
                Container
                {
                    styles: galleryStyle
                    Layout.column: 0
                    Layout.row: 2
                    Layout.alignment: Layout.Center
                    width: 240
                    height: 240

                    Matrix
                    {
                        id: matrix
                        styles: galleryStyle

                        anchors.centerIn: parent
                        height : parent.height - parent.radius*4.
                        width : parent.width - parent.radius*4.
                        onPressedChanged:
                        {
                            if(matrix.pressed.length > 0)
                                leds.toggle(matrix.pressed[0]);

                            //else
                            //  leds.setIntensityForAll(0.0);
                        }
                    }
                }
                Text {
                    Layout.column: 0
                    Layout.row: 3
                    Layout.alignment: Layout.Center
                    font.pointSize: 20
                    font.family: mainFont
                    font.bold : true
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    color : galleryStyle.background
                    text:
                    {
                        if(matrix.pressed.length > 0)
                            "Matrix\n" + matrix.pressed[0]
                        else
                            "Matrix\n"
                    }
                }
                Container{
                    Layout.column: 1
                    Layout.row: 2
                    Layout.alignment: Layout.Center
                    width: 240
                    height: 240
                    styles: galleryStyle
                    Leds
                    {
                        id : leds
                        styles: galleryStyle

                        anchors.centerIn: parent
                        height : parent.height - parent.radius*4.
                        width : parent.width - parent.radius*4.
                        easing : true

                        // all leds to off
                        intensity : [
                            [1., 1.,1.],
                            [1.,1.,1.],
                            [1.,1.,1.]
                        ]
                    }
                }
                Text {
                    Layout.column: 1
                    Layout.row: 3
                    Layout.alignment: Layout.Center

                    font.pointSize: 20
                    font.family: mainFont
                    font.bold : true
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    color : galleryStyle.background
                    text: "Leds\n"
                }


            }
        }
    }
    Row{

        height : 50
        spacing : 5


        Button
        {
            id: btnPrevious

            opacity: view.currentIndex > 0

            width: parent.width / 2
            height: parent.height

            onClicked: view.currentIndex = Math.max(view.currentIndex - 1, 0)

            background: Rectangle{
                anchors.fill : parent
                color : btnPrevious.pressed ? galleryStyle.colorOn : galleryStyle.background
            }
            font.bold : true
            contentItem: Text {
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                color: btnPrevious.pressed ? galleryStyle.detail : galleryStyle.colorOn
                font.pointSize: 15
                font.family: mainFont
                font.bold: true
                text: "Previous"
            }
        }

        Button
        {
            id: btnNext

            opacity: view.currentIndex < (view.count - 1)
            width: parent.width / 2
            height: parent.height

            onClicked: view.currentIndex = Math.min(view.currentIndex + 1, view.count - 1)

            background: Rectangle{
                anchors.fill : parent
                color : btnNext.pressed ? galleryStyle.colorOn : galleryStyle.background
            }
            font.bold : true
            contentItem: Text {
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                color: btnNext.pressed ? galleryStyle.detail : galleryStyle.colorOn
                font.pointSize: 15
                font.bold: true
                font.family: mainFont
                text: "Next"
            }
        }

        anchors.bottom: parent.bottom
        width: parent.width
    }

    Row{
        anchors{
            top: parent.top
            topMargin: 20
            left: parent.left
            leftMargin: 20
        }
        spacing: 20
        Rectangle{
            width: 100
            height: 30
            color: galleryStyle == LightStyle ?
                       LightStyle.colorOn
                     : LightStyle.background

            border.color: LightStyle.detail
            border.width: 2
            Text{
                anchors.centerIn: parent
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter

                font.bold: true
                text: "LightStyle"
                color: galleryStyle == LightStyle ?
                           LightStyle.detail
                         : LightStyle.labelColor

            }

            MouseArea{
                anchors.fill: parent
                enabled : true

                onPressed: galleryStyle = LightStyle
            }
        }
        Rectangle{
            width: 100
            height: 30
            color: galleryStyle == DarkStyle ?
                       DarkStyle.colorOn
                     : DarkStyle.background

            border.color: DarkStyle.detail
            border.width: 2
            Text{
                anchors.centerIn: parent
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter

                font.bold: true
                text: "DarkStyle"
                color: galleryStyle == DarkStyle ?
                           DarkStyle.detail
                         : DarkStyle.labelColor

            }

            MouseArea{
                anchors.fill: parent
                enabled : true

                onPressed: galleryStyle = DarkStyle
            }
        }
    }
}
