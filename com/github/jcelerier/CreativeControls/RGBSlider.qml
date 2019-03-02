import QtQuick 2.6
import com.github.jcelerier.CreativeControls 1.0
import QtQuick.Layouts 1.3


// Three to four sliders to control red, green, blue, alpha of a color
// Properties:
// * color: the current color
// * enableAlpha: show the alpha channel slider
ColorSlider {
    colorSpace: Qt.rgba
    enableAlpha: false
}
