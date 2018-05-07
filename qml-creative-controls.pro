QT += qml quick
CONFIG += c++11 plugin
TEMPLATE = lib

QML_IMPORT_PATH += $$PWD
QML2_IMPORT_PATH += $$PWD
QML_DESIGNER_IMPORT_PATH += $$PWD

DEFINES += QT_DEPRECATED_WARNINGS
DEFINES += QT_DISABLE_DEPRECATED_BEFORE=0x060000

HEADERS += \
    src/graph.hpp \
    src/creativecontrolsplugin.hpp \
    src/angleslider.hpp \
    src/scope.hpp \
    src/cpputils.hpp \
    src/xytarget.hpp \
    src/polygon.hpp \
    src/toucharea.hpp \
    src/painted_polygon.hpp

SOURCES += \
    src/graph.cpp \
    src/creativecontrolsplugin.cpp \
    src/angleslider.cpp \
    src/scope.cpp \
    src/cpputils.cpp \
    src/xytarget.cpp \
    src/polygon.cpp \
    src/toucharea.cpp \
    src/painted_polygon.cpp

DESTDIR = $$_PRO_FILE_PWD_/CreativeControls/

OTHER_FILES += \
    examples/Gallery.qml

OTHER_FILES += \
    CreativeControls/AngleSlider.qml \
    CreativeControls/ArcSlider.qml \
    CreativeControls/ColorChooser.qml \
    CreativeControls/ColorSlider.qml \
    CreativeControls/ColorWheel.qml \
    CreativeControls/Container.qml \
    CreativeControls/CosInfluence.qml \
    CreativeControls/DarkStyle.qml \
    CreativeControls/DonutSlider.qml \
    CreativeControls/Frame.qml \
    CreativeControls/Graph2D.qml \
    CreativeControls/Graph.qml \
    CreativeControls/HSlider.qml \
    CreativeControls/HSLSlider.qml \
    CreativeControls/HSVSlider.qml \
    CreativeControls/Joystick.qml \
    CreativeControls/Keyboard.qml \
    CreativeControls/Label.qml \
    CreativeControls/Leds.qml \
    CreativeControls/LightStyle.qml \
    CreativeControls/Matrix.qml \
    CreativeControls/MultiSlider.qml \
    CreativeControls/Random1D.qml \
    CreativeControls/Random2D.qml \
    CreativeControls/Random3D.qml \
    CreativeControls/RangeSlider.qml \
    CreativeControls/RGBSlider.qml \
    CreativeControls/Scale.qml \
    CreativeControls/Scope.qml \
    CreativeControls/Spat.qml \
    CreativeControls/Spectrum.qml \
    CreativeControls/Step.qml \
    CreativeControls/Styles.qml \
    CreativeControls/Switch.qml \
    CreativeControls/Trajectory.qml \
    CreativeControls/Utils.qml \
    CreativeControls/VSlider.qml \
    CreativeControls/XYPad.qml

OTHER_FILES += \
    CreativeControls/qmldir \
    CreativeControls/designer/CreativeControls.metainfo \
    README.md \

DISTFILES += \
    examples/OssiaClientExample.qml \
    examples/OssiaServerExample.qml \
    examples/Overview.qml \
    examples/SimpleStep.qml \
    examples/ContainerExample.qml \
    examples/Spectrogram.qml \
    tests/SliderTest.qml \
    tests/Various.qml
