import QtQuick 2.0
import QtQuick.Controls 2.1
import QtQuick.Layouts 1.1
import CreativeControls 1.0
import Ossia 1.0 as Ossia

Item {
    id: root

    Ossia.MidiSink
    {
        id: midiDevice
        midiPort: 1
    }

    Ossia.OSCQueryClient
    {
        id: oscqDevice
        address: "ws://127.0.0.1:5678"
    }

    Row {
        AngleSlider
        {
            width: 200
            height: 200

            // Scale the angle between 0 - 127
            property real midiangle: 127 * (180 + angle) / 360

            // The value changes are sent to CC 34 on Channel 1
            Ossia.Reader on midiangle {
                node: '/1/control/34'
                device: midiDevice
            }
        }

        Joystick
        {
            width: 200
            height: 200
            property point stick: Qt.point(stickX, stickY)

            // This example uses the oscquery_publication_example provided with libossia
            // TODO add possibility to do a binding instead. eg
            // Ossia.Binding { on: stickX + stickY, node: '/units/vec2' }
            Ossia.Reader on stick {
                node: '/units/vec2'
                device: oscqDevice
            }
        }
    }

    Component.onCompleted:
    {
        // List midi devices
        var midi_ins = midiDevice.getMIDIOutputDevices();
        for(var midi in midi_ins)
            console.log(midi, midi_ins[midi])
        // midi_ins[midi] is the value to pass to "midiPort"
    }
}
