#include "creativecontrolsplugin.hpp"
#include "graph.hpp"
#include "angleslider.hpp"
#include "scope.hpp"
#include "polygon.hpp"
#include "painted_polygon.hpp"
#include "cpputils.hpp"
#include "xytarget.hpp"
#include "toucharea.hpp"

namespace CreativeControls
{

Plugin::Plugin()
{

}

void Plugin::registerTypes(const char *uri)
{
  qmlRegisterType<Graph>(uri, 1, 0, "GraphImpl");
  qmlRegisterType<AngleSlider>(uri, 1, 0, "AngleSliderImpl");
  qmlRegisterType<Scope>(uri, 1, 0, "ScopeImpl");
  qmlRegisterType<PaintedPolygon>(uri, 1, 0, "Polygon");
  qmlRegisterType<XYTarget>(uri, 1, 0, "Crosshair");
  qmlRegisterType<TouchArea>(uri, 1, 0, "TouchArea");

  qmlRegisterSingletonType<CppUtils>(uri, 1, 0, "CppUtils",
                                     [] (QQmlEngine*, QJSEngine*) -> QObject* {
    return new CppUtils;
  });
}
}
