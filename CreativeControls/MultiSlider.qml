import QtQuick 2.6

// Vertical or horizontal set of sliders.
Item
{
    id: multiSlider
    property var nbSliders : 10
    property bool bVerticalSet : true
    property real spacing : 5.

    Row
    {
        spacing : multiSlider.spacing

        Repeater
        {
            model : bVerticalSet ? 0 :  nbSliders
            Slider
            {
                height : multiSlider.height
                width : (multiSlider.width-spacing*(nbSliders-1)) /nbSliders
                bVertical: true
            }
        }
    }

    Column
    {
        spacing : multiSlider.spacing
        Repeater
        {
            model : bVerticalSet ? nbSliders : 0
            Slider
            {
                height : (multiSlider.height-spacing*(nbSliders-1)) / nbSliders
                width : multiSlider.width
                bVertical: false
            }
        }

    }
}
