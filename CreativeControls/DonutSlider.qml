import QtQuick 2.6
import CreativeControls 1.0
import QtQuick.Controls.Styles 1.4

//  A RGB slider shaped in donut

// Properties:
// * resColor: the current color

Rectangle
{
    id : donutSlider

    width : 200
    height : width

    radius : width /2.

    color : "transparent"

    border.width : 2.
    border.color : "black"

    property real channels : 3.
    property real innerRadius : radius * 0.5//0.38
    property color resColor : Styles.detail

    function updateColor()
    {
        donutSlider.resColor = (repeater.itemAt(2) !== null) ?
                    Qt.rgba(repeater.itemAt(0).value,
                            repeater.itemAt(1).value,
                            repeater.itemAt(2).value,
                            1.)
                  : Styles.detail;
    }

    Repeater
    {
        id: repeater
        model : donutSlider.channels

        delegate: ArcSlider
        {
            id : arcSlider
            num : index

            anchors.centerIn : donutSlider
            width : donutSlider.width *0.8
            height : donutSlider.height*0.8

            innerRadius: donutSlider.width *0.7*0.5
            onValueChanged :  donutSlider.updateColor()

        }
    }


    Rectangle
    {
        id: center

        width : innerRadius*2.
        height : width
        radius : innerRadius

        anchors.centerIn: parent
        color : donutSlider.resColor
        MouseArea
        {
            anchors.fill : parent
            onDoubleClicked:
            {
                for(var i = 0; i < repeater.count; i++)
                {
                    repeater.itemAt(i).reset();
                }
            }
        }
    }

    Rectangle
    {
        id : borderDonut

        anchors.centerIn : parent
        width : parent.width + border.width*2
        height : parent.height + border.width*2

        radius : width/2.
        color :"transparent"

        border.width : 3.
        border.color : donutSlider.resColor
    }

}
