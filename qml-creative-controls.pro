QT += qml quick
CONFIG += c++14
TEMPLATE = lib
OTHER_FILES += examples/Gallery.qml controls/qmldir
RESOURCES += CreativeControls/controls.qrc

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
    src/cpputils.hpp \
    src/xytarget.hpp

SOURCES += \
    src/graph.cpp \
    src/creativecontrolsplugin.cpp \
    src/angleslider.cpp \
    src/scope.cpp \
    src/circle.cpp \
    src/cpputils.cpp \
    src/xytarget.cpp

DESTDIR = $$_PRO_FILE_PWD_/CreativeControls/
