QT += qml quick
CONFIG += c++14
TEMPLATE = lib

QML_IMPORT_PATH += $$PWD
QML2_IMPORT_PATH += $$PWD
QML_DESIGNER_IMPORT_PATH += $$PWD

DEFINES += QT_DEPRECATED_WARNINGS
DEFINES += QT_DISABLE_DEPRECATED_BEFORE=0x060000

# Default rules for deployment.
qnx: target.path = /tmp/$${TARGET}/bin
else: unix:!android: target.path = /opt/$${TARGET}/bin
!isEmpty(target.path): INSTALLS += target

HEADERS += \
    src/graph.hpp \
    src/creativecontrolsplugin.hpp \
    src/angleslider.hpp \
    src/scope.hpp \
    src/circle.hpp \
    src/painted_circle.hpp \
    src/cpputils.hpp \
    src/xytarget.hpp

SOURCES += \
    src/graph.cpp \
    src/creativecontrolsplugin.cpp \
    src/angleslider.cpp \
    src/scope.cpp \
    src/circle.cpp \
    src/painted_circle.cpp \
    src/cpputils.cpp \
    src/xytarget.cpp

DESTDIR = $$_PRO_FILE_PWD_/CreativeControls/

OTHER_FILES += \
    examples/Gallery.qml

OTHER_FILES += \
    CreativeControls/AngleSlider.qml \
    CreativeControls/ArcSlider.qml \
    CreativeControls/ColorChooser.qml \
    CreativeControls/ColorWheel.qml \
    CreativeControls/CosInfluence.qml \
    CreativeControls/DonutSlider.qml \
    CreativeControls/Frame.qml \
    CreativeControls/Graph2D.qml \
    CreativeControls/Graph.qml \
    CreativeControls/HSLSlider.qml \
    CreativeControls/HSVSlider.qml \
    CreativeControls/Joystick.qml \
    CreativeControls/Keyboard.qml \
    CreativeControls/Leds.qml \
    CreativeControls/LogSlider.qml \
    CreativeControls/Matrix.qml \
    CreativeControls/MultiSlider.qml \
    CreativeControls/Random1D.qml \
    CreativeControls/Random2D.qml \
    CreativeControls/Random3D.qml \
    CreativeControls/RangeSlider.qml \
    CreativeControls/RGBSlider.qml \
    CreativeControls/Scale.qml \
    CreativeControls/Scope.qml \
    CreativeControls/Slider.qml \
    CreativeControls/Spat.qml \
    CreativeControls/Spectrum.qml \
    CreativeControls/Step.qml \
    CreativeControls/Styles.qml \
    CreativeControls/Switch.qml \
    CreativeControls/Trajectory.qml \
    CreativeControls/Utils.qml \
    CreativeControls/XYPad.qml

OTHER_FILES += \
    CreativeControls/qmldir \
    CreativeControls/designer/CreativeControls.metainfo \
    README.md

DISTFILES += \
    examples/OssiaClientExample.qml \
    examples/OssiaServerExample.qml
