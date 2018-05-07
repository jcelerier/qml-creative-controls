config += c++14
RESOURCES += $$PWD/com_github_jcelerier_qml-creative-controls.qrc

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
