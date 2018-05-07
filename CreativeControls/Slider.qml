import QtQuick 2.6
import CreativeControls 1.0

Item
{
    id: slider
    width: 300
    height: 200

    property int orientation: Qt.Horizontal
    property Item impl: makeSlider()

    property var styles: DarkStyle

    property bool ease: false

    property bool interactive: true

    property real initialValue: 0.5

    property var mapFunc: function(linearVal) { return linearVal; }

    property bool textVisible: true

    property string text
    property real value

    onOrientationChanged:
    {
        impl.parent = null;
        impl = makeSlider();
        impl.parent = slider;
        impl.anchors.fill = parent;
    }

    function makeSlider()
    {
        var sl = null;
        if(orientation == Qt.Horizontal)
            sl = hslider.createObject(slider)
        else
            sl = vslider.createObject(slider)

        sl.styles = Qt.binding(function() { return slider.styles })
        sl.ease = Qt.binding(function() { return slider.ease })
        sl.interactive = Qt.binding(function() { return slider.interactive })
        sl.initialValue = Qt.binding(function() { return slider.initialValue })
        sl.mapFunc = Qt.binding(function() { return slider.mapFunc })
        sl.textVisible = Qt.binding(function() { return slider.textVisible })
        //sl.text = Qt.binding(function() { return slider.text })

        slider.value = Qt.binding(function() { return sl.value })
        slider.text = Qt.binding(function() { return sl.text })

        return sl;
    }

    Component {
        id: hslider
        HSlider { anchors.fill: parent; parent: slider }
    }
    Component {
        id: vslider
        VSlider { anchors.fill: parent; parent: slider }
    }
}
