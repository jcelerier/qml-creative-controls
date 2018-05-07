import QtQuick 2.0
import QtQuick.Controls 2.1
import QtQuick.Layouts 1.1
import com.github.jcelerier.CreativeControls 1.0
import Ossia 1.0 as Ossia

/**
 * This file presents an example of usage of the controls
 * provided by this library, with libossia.
 * libossia is a library that provides multiple network and message
 * protocols useful for creative coding: MIDI, OSC, OSCQuery, etc.
 *
 * More information is available on :
 * https://github.com/OSSIA/libossia
 *
 * In the current example, the application we are writing acts as a client:
 * that is, it connects to existing adresses / parameters of a remote
 * software / hardware.
 */
Page {
    header: Text { font.pointSize: 30 ; text: "Client example" }
    width: 800
    height: 500

    id: root

    // A midi device to which one can send messages to.
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
        // Connect to an OSCQuery server. See for instance OssiaServerExample.qml
        // or libossia's oscquery_publication_example
        address: "ws://127.0.0.1:5678"
    }

    Row {
        spacing: 100
    Column {
        AngleSlider
        {
            id: slider
            width: 200
            height: 200

            Ossia.Binding {
                // Scale the angle between 0 - 127
                on:  127 * (180 + slider.angle) / 360

                // The value changes are sent to CC 34 on channel 1
                node: '/1/control/34'
                device: midiOutDevice

            }
        }
        Label { text: "To Midi CC 34" }

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
        Label { text: "From Midi CC 13" }
    }
    ColumnLayout {
        Joystick
        {
            id: joystick
            width: 200
            height: 200

            // Modify a single propriety using a property value source
            Ossia.Reader on stickR {
                node: '/units/float'
                device: oscqDevice
            }

            // /units/vec2 will be updated whenever the bound expression changes
            Ossia.Binding {
                on: Qt.point(0.5 * (1 + joystick.stickX), 0.5 * (1 + joystick.stickY))
                node: '/test/values'
                device: oscqDevice
            }
        }
        Label { text: "To OSCQuery server (graph and sliders)" }

        Item { height: 50 }

        Text {
            id: txt
            anchors.topMargin: 50
            text: "Callback from OSCQuery server (angle slider)"

            // This updates the text according to messages sent
            // by the remote software
            Ossia.Callback
            {
                device: oscqDevice
                onValueChanged: txt.text = "foo " + value.toFixed(2) + " bar"
                node: '/test/angle'
            }
        }

        // More concise form using a property value source:
        Text {
            anchors.topMargin: 50
            text: "Callback from OSCQuery server (angle slider)"
            Ossia.Writer on text {
                node: '/test/angle'
                device: oscqDevice
            }
        }
    }
    }

    Component.onCompleted:
    {
        // List midi devices
        console.log("get MIDI output devices...");
        var midi_outs = midiOutDevice.getMIDIOutputDevices();
        for(var midi in midi_outs)
            console.log("device: '" + midi + "'\t\tport number: ", midi_outs[midi])
        // midi_outs[midi] is the value to pass to "midiPort"

        console.log("get MIDI input devices...");
        var midi_ins = midiInDevice.getMIDIInputDevices();
        for(var midi in midi_ins)
            console.log("device: '" + midi + "'\t\tport number: ", midi_ins[midi])
        // midi_ins[midi] is the value to pass to "midiPort"

        // Call this at the end to set-up the connections
        oscqDevice.openOSCQueryClient(oscqDevice.address, oscqDevice.localPort)
        oscqDevice.remap(root)
    }
}
