import QtQuick 2.6
import com.github.jcelerier.CreativeControls 1.0
import QtQuick.Layouts 1.3


// Sliders to control hue, saturation, luminance, alpha, of a color
// Properties:
// * color: the current color
// * enableAlpha: show the alpha channel slider
ColorSlider {
    colorSpace: Qt.hsla
    enableAlpha: false
}
