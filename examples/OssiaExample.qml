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
        midiPort: 0
    }

    // This example uses the oscquery_publication_example
    // provided with libossia
    Ossia.OSCQueryClient
    {
        id: oscqDevice
        address: "ws://127.0.0.1:5678"
    }

    Column {
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
            id: joystick
            width: 200
            height: 200

            // Send whenever the bound expression changes
            Ossia.Binding {
                on: Qt.point(joystick.stickX, joystick.stickX)
                node: '/units/vec2'
                device: oscqDevice
            }

            // Modify a single propriety using a property value source
            Ossia.Reader on stickR {
                node: '/test/my_string'
                device: oscqDevice
            }
        }

        // This updates the text according to what is sent
        Text {
            id: txt
            font.pointSize: 50

            Ossia.Callback
            {
                device: oscqDevice
                onValueChanged: txt.text = "foo " + value + " bar"
                node: '/test/my_float'
            }
        }

        // More concise form using a property value source:
        Text {
            font.pointSize: 70
            text: "foo"
            Ossia.Writer on text {
                node: '/test/my_float'
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

        oscqDevice.openOSCQueryClient(oscqDevice.address, oscqDevice.localPort)
        oscqDevice.remap(root)
    }
}
