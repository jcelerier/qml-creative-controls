import QtQuick 2.0
import com.github.jcelerier.CreativeControls 1.0

Container {
    id: root
    width: 800
    height: 400

    MultiSlider {
        id: slider
        anchors.fill:parent
        count: 64
        textVisible: false
        interactive: false
        spacing: 1
        ease: true
    }

    // Init to zero
    Component.onCompleted: {
        var array = [];
        for (var i = 0; i < slider.count; i++) {
            array.push(0.3);
        }
        slider.values = array;
    }

    Timer {
        interval: 100
        running: true
        repeat: true

        onTriggered: {
            var array = [];
            for (var i = 0; i < slider.count; i++) {
                array.push(Math.random() / (0.01 * i * i + 1));
            }
            slider.values = array;
        }
    }
}
