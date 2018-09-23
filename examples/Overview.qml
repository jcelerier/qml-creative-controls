import QtQuick 2.0
import QtQuick.Controls 2.1
import QtQuick.Layouts 1.1
import com.github.jcelerier.CreativeControls 1.0

Item {
    width: 1920
    height: 1080

    Rectangle {
        x: 0
        y: 0
        width: 1920
        height: 1080
        color: "#555"
    }

    GridLayout {
        x: 0
        y: 0

        scale: 1
        rows: 4
        columns: 8

        AngleSlider { }
        ArcSlider { }
        ColorChooser { }
        ColorSlider { }
        ColorWheel { }
        CosInfluence { }
        DonutSlider { }
        Frame { }

        Graph { }
        Graph2D { }
        HSLSlider { }
        HSVSlider { }
        Joystick { }
        Keyboard { }
        Leds { }

        Matrix { }
        MultiSlider { }
        Random1D { }
        Random2D { }
        Random3D { }
        RangeSlider { }
        RGBSlider { }
        Scale { }

        Scope { }
        Spat { }
        Spectrum { }
        Step { }
        Switch { }
        Trajectory { }
        XYPad { }
    }
}
