import QtQuick 2.6
import CreativeControls 1.0

// An oscilliscope.
// No user input.
// Properties:
// * points: an array of values that will be displayed.
// * symmetrize: render a waveform instead of a scope
// * yMin / yMax: bounds (in the value domain) that should be shown. Default is [-1; 1]
// TODO allow to display a "fill" under the scope in non-symmetrized mode

ScopeImpl
{
    id: scope
    yMin: -1
    yMax: 1
    baseColor: Styles.dark
    detailColor: Styles.detail
    symmetrize: false
}
