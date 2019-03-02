import QtQuick 2.6
import com.github.jcelerier.CreativeControls 1.0
import QtQuick.Layouts 1.3


// Three to four sliders to control red, green, blue, alpha of a color
// Properties:
// * color: the current color
// * colorSpace: the colorSpace for these sliders
// * enableAlpha: show the alpha channel slider
Rectangle {
    id: colorSlider

    height: 200
    width: 200

    color: colorSpace(x.value, y.value, z.value, alphaValue)
    property color contourColor: colorSpace(x.value, y.value, 1. - z.value, 0.5)

    // add an alpha slider
    property bool enableAlpha: false
    property real alphaValue: enableAlpha ? a.value : 1.0

    // slider width varies according to channel number (3 without alpha and 4 with alpha)
    property real sliderWidth: enableAlpha ? width / 4. : width / 3.
    property var colorSpace: Qt.hsla

    RowLayout {
        width: parent.width
        height: parent.height * 2 / 3
        anchors.centerIn: parent

        VSlider {
            id: x

            text: colorSpace == Qt.rgba ? "R" : "H"

            border {
                width: 2
                color: colorSlider.contourColor
            }

            Layout.fillHeight: true
            Layout.alignment: Qt.AlignHCenter
            Layout.preferredWidth: colorSlider.sliderWidth - 10

            initialValue: 153. / 255.

            handleColor: colorSpace == Qt.rgba
                         ? colorSpace(value, 0, 0, 1.)
                         : colorSpace(value, 0.5, 0.5, 1.)
        }

        VSlider {
            id: y

            text: colorSpace == Qt.rgba ? "G" : "S"

            border {
                width: 2
                color: colorSlider.contourColor
            }

            Layout.fillHeight: true
            Layout.alignment: Qt.AlignHCenter
            Layout.preferredWidth: colorSlider.sliderWidth - 10

            initialValue: 187. / 255.
            handleColor: colorSpace == Qt.rgba
                         ? colorSpace(0, value, 0.,1.)
                         : colorSpace(x.value, value, 0.5, 1.)
        }

        VSlider {
            id: z
            text: colorSpace == Qt.rgba ? "B" : colorSpace == Qt.hsla ? "L" : "V"

            border {
                width: 2
                color: colorSlider.contourColor
            }

            Layout.fillHeight: true
            Layout.alignment: Qt.AlignHCenter
            Layout.preferredWidth: colorSlider.sliderWidth - 10

            initialValue: 153. / 255.

            handleColor: colorSpace == Qt.rgba
                         ? colorSpace(0, 0., value, 1.)
                         : colorSpace(x.value, 0.5, value, 1.)
        }

        VSlider {
            id: a

            visible: colorSlider.enableAlpha
            text: "A"

            border {
                width: 2
                color: colorSlider.contourColor
            }

            Layout.fillHeight: true
            Layout.alignment: Qt.AlignHCenter
            Layout.preferredWidth: colorSlider.sliderWidth - 10

            initialValue: 0.7

            handleColor: Qt.rgba(value, value, value, 1.0)
        }
    }
}
