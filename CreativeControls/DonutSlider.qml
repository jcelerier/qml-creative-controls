import QtQuick 2.6
import CreativeControls 1.0
import QtQuick.Controls.Styles 1.4
// DonutSlider
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
    property color resColor : getResColor()

    function getResColor()
    {
        if(repeater.itemAt(2) !== null)
        {
            return Qt.rgba(repeater.itemAt(0).value,
                           repeater.itemAt(1).value,
                           repeater.itemAt(2).value,
                           1.);
        }
        return Styles.detail;
    }

    function updateColor()
    {
        donutSlider.resColor = donutSlider.getResColor();

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

            // anchors.fill : donutSlider
            innerRadius: donutSlider.width *0.7*0.5
            //handleColor : donutSlider.getResColor()
            // handleColor: donutSlider.getColor(index,1.-arcSlider.value)
            onValueChanged :
            {
                donutSlider.updateColor();
            }
        }
    }


    Rectangle
    {

        id: result
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
        width : parent.width /**1.03*/+ border.width*2
        height : parent.height/**1.03*/ + border.width*2

        color :"transparent"
        radius : width/2.
        border.width : 3.
        border.color : donutSlider.resColor
    }

}
