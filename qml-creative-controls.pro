QT += qml quick
CONFIG += c++11 plugin
TEMPLATE = lib

# QMAKE_CXXFLAGS += -fsanitize=address -fsanitize=undefined -O0
# QMAKE_LFLAGS += -fsanitize=address -fsanitize=undefined -O0
QML_IMPORT_PATH += $$PWD
QML2_IMPORT_PATH += $$PWD
QML_DESIGNER_IMPORT_PATH += $$PWD

DEFINES += QT_DEPRECATED_WARNINGS
DEFINES += QT_DISABLE_DEPRECATED_BEFORE=0x060000

HEADERS += \
    $$PWD/src/graph.hpp \
    $$PWD/src/creativecontrolsplugin.hpp \
    $$PWD/src/angleslider.hpp \
    $$PWD/src/scope.hpp \
    $$PWD/src/cpputils.hpp \
    $$PWD/src/xytarget.hpp \
    $$PWD/src/polygon.hpp \
    $$PWD/src/toucharea.hpp \
    $$PWD/src/painted_polygon.hpp

SOURCES += \
    $$PWD/src/graph.cpp \
    $$PWD/src/creativecontrolsplugin.cpp \
    $$PWD/src/angleslider.cpp \
    $$PWD/src/scope.cpp \
    $$PWD/src/cpputils.cpp \
    $$PWD/src/xytarget.cpp \
    $$PWD/src/polygon.cpp \
    $$PWD/src/toucharea.cpp \
    $$PWD/src/painted_polygon.cpp

DESTDIR = $$_PRO_FILE_PWD_/CreativeControls/

OTHER_FILES += \
    $$PWD/CreativeControls/AngleSlider.qml \
    $$PWD/CreativeControls/ArcSlider.qml \
    $$PWD/CreativeControls/ColorChooser.qml \
    $$PWD/CreativeControls/ColorSlider.qml \
    $$PWD/CreativeControls/ColorWheel.qml \
    $$PWD/CreativeControls/Container.qml \
    $$PWD/CreativeControls/CosInfluence.qml \
    $$PWD/CreativeControls/DarkStyle.qml \
    $$PWD/CreativeControls/DonutSlider.qml \
    $$PWD/CreativeControls/Frame.qml \
    $$PWD/CreativeControls/Graph2D.qml \
    $$PWD/CreativeControls/Graph.qml \
    $$PWD/CreativeControls/HRangeSlider.qml \
    $$PWD/CreativeControls/HSlider.qml \
    $$PWD/CreativeControls/HSLSlider.qml \
    $$PWD/CreativeControls/HSVSlider.qml \
    $$PWD/CreativeControls/Joystick.qml \
    $$PWD/CreativeControls/Keyboard.qml \
    $$PWD/CreativeControls/Label.qml \
    $$PWD/CreativeControls/Leds.qml \
    $$PWD/CreativeControls/LightStyle.qml \
    $$PWD/CreativeControls/Matrix.qml \
    $$PWD/CreativeControls/MultiSlider.qml \
    $$PWD/CreativeControls/Random1D.qml \
    $$PWD/CreativeControls/Random2D.qml \
    $$PWD/CreativeControls/Random3D.qml \
    $$PWD/CreativeControls/RGBSlider.qml \
    $$PWD/CreativeControls/Scale.qml \
    $$PWD/CreativeControls/Scope.qml \
    $$PWD/CreativeControls/Spat.qml \
    $$PWD/CreativeControls/Spectrum.qml \
    $$PWD/CreativeControls/Step.qml \
    $$PWD/CreativeControls/Switch.qml \
    $$PWD/CreativeControls/ToggleSwitch.qml \
    $$PWD/CreativeControls/Trajectory.qml \
    $$PWD/CreativeControls/Utils.qml \
    $$PWD/CreativeControls/VRangeSlider.qml \
    $$PWD/CreativeControls/VSlider.qml \
    $$PWD/CreativeControls/XYPad.qml \
    $$PWD/CreativeControls/qmldir \
    $$PWD/CreativeControls/designer/CreativeControls.metainfo \
    $$PWD/README.md

DISTFILES += \
    $$PWD/examples/Limiter.qml \
    $$PWD/examples/Gallery.qml \
    $$PWD/examples/OssiaClientExample.qml \
    $$PWD/examples/OssiaServerExample.qml \
    $$PWD/examples/Overview.qml \
    $$PWD/examples/SimpleStep.qml \
    $$PWD/examples/ContainerExample.qml \
    $$PWD/examples/Spectrogram.qml \
    $$PWD/tests/SliderTest.qml \
    $$PWD/tests/Various.qml
