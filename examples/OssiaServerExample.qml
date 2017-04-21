import QtQuick 2.0
import CreativeControls 1.0
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
Item {
    id: root
    Column
    {
        Graph {
            width: 400
            height: 200
            property real nextVal
            onNextValChanged: pushValue(nextVal)

            // This creates a new node '/units/float'
            // with the type of nextVal.
            Ossia.Property on nextVal {
                node: '/units/float'
            }
        }

        Item {
            width: 400
            height: 200

            // From this point, we enter the /test namespace level
            // If no name is given, the parent object's objectName will be used.
            // If there is no objectName, the name of the parent class will be used.
            Ossia.Node { node: 'test' }
            Row {
                MultiSlider {
                    count: 2
                    height: 100
                    // Reads and writes from /test/values
                    Ossia.Property on values { }
                    onValuesChanged: console.log(values)
                }
                AngleSlider {
                    // Reads and writes from /test/angle
                    Ossia.Property on angle { }
                }
            }
        }
    }


    Component.onCompleted: {
        Ossia.SingleDevice.openOSCQueryServer(5678,1234)
        Ossia.SingleDevice.recreate(root)
    }
}
