QT += qml quick
CONFIG += plugin
TEMPLATE = lib

# QMAKE_CXXFLAGS += -fsanitize=address -fsanitize=undefined -O0
# QMAKE_LFLAGS += -fsanitize=address -fsanitize=undefined -O0
QML_IMPORT_PATH += $$PWD
QML2_IMPORT_PATH += $$PWD
QML_DESIGNER_IMPORT_PATH += $$PWD

DEFINES += QT_DEPRECATED_WARNINGS
DEFINES += QT_DISABLE_DEPRECATED_BEFORE=0x060000
CCPATH = $$PWD/com/github/jcelerier
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
    $$CCPATH/CreativeControls/AngleSlider.qml \
    $$CCPATH/CreativeControls/ArcSlider.qml \
    $$CCPATH/CreativeControls/ColorChooser.qml \
    $$CCPATH/CreativeControls/ColorSlider.qml \
    $$CCPATH/CreativeControls/ColorWheel.qml \
    $$CCPATH/CreativeControls/Container.qml \
    $$CCPATH/CreativeControls/CosInfluence.qml \
    $$CCPATH/CreativeControls/DarkStyle.qml \
    $$CCPATH/CreativeControls/DonutSlider.qml \
    $$CCPATH/CreativeControls/Frame.qml \
    $$CCPATH/CreativeControls/Graph2D.qml \
    $$CCPATH/CreativeControls/Graph.qml \
    $$CCPATH/CreativeControls/HRangeSlider.qml \
    $$CCPATH/CreativeControls/HSlider.qml \
    $$CCPATH/CreativeControls/HSLSlider.qml \
    $$CCPATH/CreativeControls/HSVSlider.qml \
    $$CCPATH/CreativeControls/Joystick.qml \
    $$CCPATH/CreativeControls/Keyboard.qml \
    $$CCPATH/CreativeControls/Label.qml \
    $$CCPATH/CreativeControls/Leds.qml \
    $$CCPATH/CreativeControls/LightStyle.qml \
    $$CCPATH/CreativeControls/Matrix.qml \
    $$CCPATH/CreativeControls/MultiSlider.qml \
    $$CCPATH/CreativeControls/Random1D.qml \
    $$CCPATH/CreativeControls/Random2D.qml \
    $$CCPATH/CreativeControls/Random3D.qml \
    $$CCPATH/CreativeControls/RGBSlider.qml \
    $$CCPATH/CreativeControls/Scale.qml \
    $$CCPATH/CreativeControls/Scope.qml \
    $$CCPATH/CreativeControls/Spat.qml \
    $$CCPATH/CreativeControls/Spectrum.qml \
    $$CCPATH/CreativeControls/Step.qml \
    $$CCPATH/CreativeControls/Switch.qml \
    $$CCPATH/CreativeControls/ToggleSwitch.qml \
    $$CCPATH/CreativeControls/Trajectory.qml \
    $$CCPATH/CreativeControls/Utils.qml \
    $$CCPATH/CreativeControls/VRangeSlider.qml \
    $$CCPATH/CreativeControls/VSlider.qml \
    $$CCPATH/CreativeControls/XYPad.qml \
    $$CCPATH/CreativeControls/qmldir \
    $$CCPATH/CreativeControls/designer/CreativeControls.metainfo \
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
    $$PWD/tests/Various.qml \
    $$PWD/examples/DesignerExampleForm.ui.qml \
    $$PWD/examples/DesignerExample.qml

FORMS +=
