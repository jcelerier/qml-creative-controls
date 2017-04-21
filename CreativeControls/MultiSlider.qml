import QtQuick 2.6

// Vertical or horizontal set of sliders.
// Parameters:
// * count: the number of sliders
// * orientation: vertical / horizontal
// * spacing: spacing between sliders
// * values: an array with all the output values.
Item
{
    id: multiSlider
    property int count : 10
    property int orientation : Qt.Vertical
    property real spacing : 5.
    property var values: []

    width: 200
    height: 100

    function recomputeValues()
    {
        var source = (orientation == Qt.Vertical) ? vSliders : hSliders;
        var array = [];
        for(var i = 0; i < count; i++)
        {
            var item = source.itemAt(i);
            if(item !== null)
                array.push(item.value)
        }
        values = array;
    }

    Row
    {
        spacing: multiSlider.spacing

        Repeater
        {
            id: hSliders
            model : (orientation == Qt.Vertical) ? 0 : multiSlider.count
            Slider
            {
                height : multiSlider.height
                width : (multiSlider.width - spacing * (multiSlider.count - 1)) / multiSlider.count
                bVertical: true
                onValueChanged: recomputeValues()
            }
        }
    }

    Column
    {
        spacing : multiSlider.spacing
        Repeater
        {
            id: vSliders
            model: (orientation == Qt.Vertical) ? multiSlider.count : 0
            Slider
            {
                height : (multiSlider.height - spacing * (multiSlider.count - 1)) / multiSlider.count
                width : multiSlider.width
                bVertical: false
                onValueChanged: recomputeValues()
            }
        }
    }
}
