import QtQuick 2.0
import QtQuick.Controls 2.1
import QtQuick.Layouts 1.1
import CreativeControls 1.0
import Ossia 1.0 as Ossia

Rectangle {
    width: 400
    height: 600
    id: root

    Ossia.MidiSink
    {
        id: midiOutDevice
        // look at the console output to know MIDI devices' port number
        // and report the one you want to use below
        midiPort: 0
    }

    Ossia.MidiSource
    {
        id: midiInDevice
        // look at the console output to know MIDI input devices' port number
        // and report the one you want to use below
        midiPort: 0
    }

    Ossia.OSCQueryClient
    {
        id: oscqDevice
        // connect to oscquery_publication_example provided with libossia
        address: "ws://127.0.0.1:5678"
    }

    Column {
        Row {
            AngleSlider
            {
                width: 200
                height: 200

                // Scale the angle between 0 - 127
                property real midiangle: 127 * (180 + angle) / 360

                // The value changes are sent to CC 34 on Channel 1
                Ossia.Reader on midiangle {
                    node: '/1/control/13'
                    device: midiOutDevice
                }
            }

            AngleSlider
            {
                width: 200
                height: 200
                angle: 0

                Ossia.Writer on angle {
                    node: '/1/control/13'
                    device: midiInDevice
                }
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
        console.log("get MIDI output devices...");
        var midi_outs = midiOutDevice.getMIDIOutputDevices();
        for(var midi in midi_outs)
            console.log("device: \"", midi, "\"\t\tport number: ", midi_outs[midi])
        // midi_outs[midi] is the value to pass to "midiPort"

        console.log("get MIDI input devices...");
        var midi_ins = midiInDevice.getMIDIInputDevices();
        for(var midi in midi_ins)
            console.log("device: \"", midi, "\"\t\tport number: ", midi_ins[midi])
        // midi_ins[midi] is the value to pass to "midiPort"

        oscqDevice.openOSCQueryClient(oscqDevice.address, oscqDevice.localPort)
        oscqDevice.remap(root)
    }
}
