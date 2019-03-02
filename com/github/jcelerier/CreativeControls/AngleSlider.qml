import QtQuick 2.6
import com.github.jcelerier.CreativeControls 1.0


// An angular slider.
// Parameter: angle. Range: [0; 360[
// TODO: infinite mode that uses the delta instead of the position.
AngleSliderImpl {
    property var styles: DarkStyle

    width: 100
    height: 100
    baseColor: styles.background
    detailColor: styles.base
    angle: 0
}
