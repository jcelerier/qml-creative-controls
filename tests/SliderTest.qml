import CreativeControls 1.0 as CC
import QtQuick 2.10
import QtQuick.Controls 2.2

ApplicationWindow
{
    Column {
        spacing: 16
    Row
    {
        spacing: 16
        CC.HSlider { }
        CC.VSlider { }
    }
    Row
    {
        spacing: 16
        CC.Slider { orientation: Qt.Horizontal }
        CC.Slider { orientation: Qt.Vertical }
    }
    }
}
