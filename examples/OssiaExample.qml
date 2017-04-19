import QtQuick 2.0
import QtQuick.Controls 2.1
import QtQuick.Layouts 1.1
import CreativeControls 1.0
import Ossia 1.0 as Ossia

Item {

    id: root
    AngleSlider
    {
        anchors.fill: parent

        // Scale the angle between 0 - 127
        property real midiangle: 127 * (180 + angle) / 360

        // The value changes are sent to CC 34 on Channel 1
        Ossia.Reader on midiangle {
            node: '/1/control/34'
        }
    }

    Component.onCompleted:
    {
        var midi_ins = Ossia.SingleDevice.getMIDIInputDevices();
        for(var midi in midi_ins)
            console.log(midi, midi_ins[midi])
        Ossia.SingleDevice.openMIDIOutputDevice(1)
        Ossia.SingleDevice.remap(root)
    }
}
