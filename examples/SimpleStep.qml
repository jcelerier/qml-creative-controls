import QtQuick 2.0
import QtQuick.Controls 2.1
import QtQuick.Layouts 1.1
import CreativeControls 1.0

Rectangle
{
    color: DarkStyle.background
    Timer {
        running: true
        interval: 200
        repeat: true
        onTriggered: step.nextStep()
    }
    Container {
        width: 600
        height: step.height + 10
        Step {
            id: step
            width: parent.width
            onStep: {
                console.log(values)
            }
        }

    }

}
