import QtQuick 2.6
import CreativeControls 1.0

// An angular slider.
// Parameter: angle. Range: [0; 360[
// TODO: infinite mode that uses the delta instead of the position.
AngleSliderImpl
{
    anchors.fill: parent
    baseColor: Styles.detail
    detailColor: Styles.base
    angle: 0
}
