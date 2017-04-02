QT += qml quick
TEMPLATE = lib
TARGET = CreativeControls
CONFIG += c++14

OTHER_FILES += examples/Gallery.qml controls/qmldir
RESOURCES += CreativeControls/controls.qrc

QML_IMPORT_PATH = $$_PRO_FILE_PWD_
QML2_IMPORT_PATH = $$_PRO_FILE_PWD_
QML_DESIGNER_IMPORT_PATH = $$_PRO_FILE_PWD_/  $$PWD/ $$DLLDESTDIR/

DEFINES += QT_DEPRECATED_WARNINGS
DEFINES += QT_DISABLE_DEPRECATED_BEFORE=0x060000

# Default rules for deployment.
qnx: target.path = /tmp/$${TARGET}/bin
else: unix:!android: target.path = /opt/$${TARGET}/bin
!isEmpty(target.path): INSTALLS += target

HEADERS += \
    src/graph.hpp \
    src/creativecontrolsplugin.hpp

SOURCES += \
    src/graph.cpp \
    src/creativecontrolsplugin.cpp

DESTDIR = $$_PRO_FILE_PWD_/CreativeControls/
