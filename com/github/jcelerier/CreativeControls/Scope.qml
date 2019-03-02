import QtQuick 2.6
import com.github.jcelerier.CreativeControls 1.0


// An oscilliscope.
// No user input.
// Properties:
// * points: an array of values that will be displayed.
// * symmetrize: render a waveform instead of a scope
// * yMin / yMax: bounds (in the value domain) that should be shown. Default is [-1; 1]
// TODO allow to display a "fill" under the scope in non-symmetrized mode
Item {
    property alias symmetrize: scope.symmetrize
    property alias points: scope.points
    property var styles: DarkStyle

    Rectangle {
        anchors.fill: parent
        color: styles.background
    }

    ScopeImpl {
        anchors.fill: parent
        id: scope
        yMin: -1
        yMax: 1
        baseColor: styles.colorOn
        detailColor: styles.base
        symmetrize: false
    }
}
