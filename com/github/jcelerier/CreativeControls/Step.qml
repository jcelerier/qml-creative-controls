import QtQuick 2.6
import com.github.jcelerier.CreativeControls 1.0


// A matrix of buttons. Buttons can be toggles or triggers.
Item {
    id: root
    width: 800
    height: 200

    property int currentStep: 0
    property int maxStep: 15
    property int numValues: 4

    property var steps: []
    property var styles: DarkStyle

    onMaxStepChanged: initSteps()
    onNumValuesChanged: initSteps()
    Component.onCompleted: initSteps()

    function nextStep() {
        currentStep = (currentStep + 1) % maxStep
    }

    function initSteps() {
        steps.length = maxStep
        for (var i = 0; i < maxStep; i++) {
            var arr = []
            arr.length = numValues
            for (var j = 0; j < numValues; j++) {
                arr[j] = rects.itemAt(i * j).toggled
            }
            steps[i] = arr
        }
    }
    function getStep(step) {
        var arr = []
        for (var i = 0; i < numValues; i++) {
            if (rects.itemAt(i * maxStep + step).toggled) {
                arr.push(numValues - i - 1)
            }
        }
        return arr
    }

    // an array with the 0-valued steps that were triggered
    signal step(var values)
    onCurrentStepChanged: {
        step(getStep(currentStep))
    }

    Grid {
        id: grid
        anchors.fill: parent
        columns: maxStep
        rows: numValues
        spacing: 3
        padding: 1.5
        horizontalItemAlignment: Grid.AlignHCenter
        verticalItemAlignment: Grid.AlignVCenter

        property real contentWidth: (width - padding * 2 - spacing * columns)
        property real contentHeight: (height - padding * 2 - spacing * rows)

        Repeater {
            id: rects
            model: parent.columns * parent.rows

            anchors.centerIn: parent
            delegate: Rectangle {
                id: rect
                property bool toggled: false

                property int step: computeStep()
                function computeStep() {
                    var idx = index
                    var quo = Math.floor(idx / maxStep)
                    var rem = idx - quo * maxStep
                    return rem
                }

                width: grid.contentWidth / maxStep
                height: grid.contentHeight / numValues
                radius: styles.stepRectCornerRadius

                color: !toggled ? styles.colorOffDarker : step == currentStep
                                  ? styles.colorOn : styles.colorOnLighter
                border.width: 3
                border.color: step == currentStep ? styles.colorOnLighter : styles.colorOff

                MouseArea {
                    anchors.fill: parent
                    onPressed: toggled = !toggled
                }
            }
        }
    }
}
