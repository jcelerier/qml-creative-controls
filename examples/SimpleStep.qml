import QtQuick 2.0
import QtQuick.Controls 2.1
import QtQuick.Layouts 1.1
import com.github.jcelerier.CreativeControls 1.0

Rectangle {
    width: 800
    height: step.height + 10

    color: DarkStyle.background
    Timer {
        running: true
        interval: 200
        repeat: true
        onTriggered: step.nextStep()
    }

    Container {
        width: 800
        height: step.height + 10

        Step {
            id: step
            anchors.centerIn: parent

            width: parent.width
            onStep: {
                console.log(values)
            }
        }
    }
}
