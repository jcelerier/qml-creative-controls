import QtQuick 2.0
import QtQuick.Controls 2.1
import QtQuick.Layouts 1.1
import CreativeControls 1.0

Page
{
    Timer {
        running: true
        interval: 200
        repeat: true
        onTriggered: step.nextStep()
    }

    Step {
        id: step
        width: parent.width
        onStep: {
            console.log(values)
        }
    }
}
