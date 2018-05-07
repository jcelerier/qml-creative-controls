import QtQuick 2.6
import com.github.jcelerier.CreativeControls 1.0

// A label displaying text
// Properties:
// * selected: if the the control is selected the label changes

Text
{
    id: label

   // anchors.centerIn: parent

    property bool selected: false
    property var styles : DarkStyle

    color : styles.labelColor//selected ? Styles.colorOn : Styles.base

    horizontalAlignment: Text.AlignHCenter
    verticalAlignment: Text.AlignVCenter

    font.bold: true
    font.pointSize: selected ? 15 : 14
}
