import QtQuick 2.6
import CreativeControls 1.0

// A matrix of buttons. Buttons can be toggles or triggers.
Item {
    id: root
    width: 800
    height: 200

    property int currentStep: 0
    property int maxStep: 15
    property int numValues: 4

    property var steps: []

    onMaxStepChanged: initSteps()
    onNumValuesChanged: initSteps()
    Component.onCompleted: initSteps()

    function nextStep()
    {
        currentStep = (currentStep + 1) % maxStep;
    }

    function initSteps()
    {
        steps.length = maxStep
        for(var i = 0; i < maxStep; i++)
        {
            var arr = []
            arr.length = numValues;
            for(var j = 0; j < numValues; j++)
            {
                arr[j] = rects.itemAt(i * j).toggled;
            }
            steps[i] = arr;
        }
    }
    function getStep(step)
    {
        var arr = []
        for(var i = 0; i < numValues; i++)
        {
            if(rects.itemAt(i * maxStep + step).toggled)
            {
                arr.push(numValues - i - 1);
            }
        }
        return arr;
    }

    // an array with the 0-valued steps that were triggered
    signal step(var values);
    onCurrentStepChanged: {
        step(getStep(currentStep))
    }

    Row {
        anchors.fill: parent
        spacing: 1
        padding: 0.5
        Repeater {
            model: grid.columns
            Rectangle {
                color: (index === currentStep) ? Qt.lighter(Styles.colorOn) : "#00000000"
                radius: 12
                width: root.width / maxStep - 3
                height: root.height - 5
            }
        }
    }

    Grid
    {
        id: grid
        anchors.fill: parent
        columns: maxStep
        rows: numValues
        spacing: 3
        padding: 1.5
        horizontalItemAlignment : Grid.AlignHCenter
        verticalItemAlignment : Grid.AlignVCenter

        Repeater {
            id: rects
            model: parent.columns * parent.rows

            anchors.fill: parent
            delegate: Rectangle {
                id: rect
                property bool toggled : false

                width: grid.width / maxStep - 5
                height: grid.height / numValues - 5
                radius: 14

                color: Styles.detail
                border.width: 3
                border.color: Styles.background

                onToggledChanged: {
                    if(toggled)
                    {
                        rect.color = Styles.colorOn;
                    }
                    else
                    {
                        rect.color = Styles.detail;
                    }
                }

                MouseArea {
                    anchors.fill: parent
                    onPressed: toggled = !toggled
                }
            }
        }
    }

}
