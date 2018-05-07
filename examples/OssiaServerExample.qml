import QtQuick 2.0
import QtQuick.Controls 2.0
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
 * In the current example, the application we are writing acts as a server:
 * nodes are declared through the OSCQuery protocol, and other applications
 * can connect to this one. It is also possible to query the state through a
 * web browser, by going to http://localhost:5678/
 */
Page {
    id: root
    header: Text { font.pointSize: 30 ; text: "Server example" }
    width: 800
    height: 500


    // From this point, we enter the /test relative namespace level
    // If no 'node' is given, the parent object's objectName will be used.
    // If there is no objectName, the name of the parent class will be used.
    // Nodes with an absolute address repsect their given address.
    Ossia.Node { node: 'test' }

    GridLayout
    {
        Text { Layout.row: 0; Layout.column: 0; width: 50; wrapMode: Text.Wrap;
            text: "Graph" }
        Rectangle {
            Layout.row: 0
            Layout.column: 1
            width: 400
            height: 200
            border.width: 2

            Graph {
                width: parent.width - 2
                height: parent.height - 4
                y: 2

                // A value we add for receiving the new message
                property real nextVal
                onNextValChanged: pushValue(nextVal)

                // This creates a new node '/units/float'
                // with the type of nextVal.
                Ossia.Property on nextVal {
                    node: '/units/float'
                }
            }
        }

        Text { Layout.row: 1; Layout.column: 0; width: 50; wrapMode: Text.Wrap;
            text: "Sliders (controlled by the Joystick in the client)" }
        MultiSlider {
            Layout.row: 1
            Layout.column: 1

            count: 2
            height: 100
            // Reads and writes from /test/values
            Ossia.Property on values { }
        }

        Text { Layout.row: 2; Layout.column: 0; width: 50; wrapMode: Text.Wrap;
            text: "Angle slider (changes the text in client)" }
        AngleSlider {
            Layout.row: 2
            Layout.column: 1

            // Reads and writes from /test/angle
            Ossia.Property on angle {
                // The value will be bounded between these:
                min: -90
                max: 0
                bounding: Ossia.Context.Clip
            }
        }
    }

    Component.onCompleted: {
        Ossia.SingleDevice.openOSCQueryServer(5678,1234)
        Ossia.SingleDevice.recreate(root)
    }
}
