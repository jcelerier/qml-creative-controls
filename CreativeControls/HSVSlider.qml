import QtQuick 2.6
import CreativeControls 1.0
import QtQuick.Layouts 1.3

// Sliders to control hue, saturation, value, alpha, of a color
// Properties:
// * enableAlpha: show the alpha channel slider
ColorSlider
{
    colorSpace : Qt.hsva
    enableAlpha : false
}
