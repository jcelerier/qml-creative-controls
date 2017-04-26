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
    property real innerRadius : radius * 0.38

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
        result.color = borderDonut.border.color = donutSlider.getResColor();
        for(var i = 0; i < repeater.count; i++)
        {
            repeater.itemAt(i).handleColor = result.color;
        }
    }

    Repeater
    {
        id: repeater
        model : donutSlider.channels
        delegate: ArcSlider
        {
            id : arcSlider
            num : index

            anchors.fill : donutSlider
           // innerRadius: donutSlider.innerRadius
            handleColor : donutSlider.getResColor()
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
        color : donutSlider.getResColor()

    }
    Rectangle
    {
        id : borderDonut
        anchors.centerIn : parent
        width : parent.width + border.width*2
        height : parent.height + border.width*2

        color :"transparent"
        radius : parent.radius + border.width
        border.width : 3.
        border.color : donutSlider.getResColor()
    }

}
