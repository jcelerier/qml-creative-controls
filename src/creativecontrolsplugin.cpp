#include "creativecontrolsplugin.hpp"

#include "angleslider.hpp"
#include "cpputils.hpp"
#include "graph.hpp"
#include "painted_polygon.hpp"
#include "polygon.hpp"
#include "scope.hpp"
#include "toucharea.hpp"
#include "xytarget.hpp"

namespace CreativeControls
{

Plugin::Plugin()
{
}

void Plugin::registerTypes(const char* uri)
{
  qmlRegisterType<Graph>(uri, 1, 0, "GraphImpl");
  qmlRegisterType<AngleSlider>(uri, 1, 0, "AngleSliderImpl");
  qmlRegisterType<Scope>(uri, 1, 0, "ScopeImpl");
  qmlRegisterType<PaintedPolygon>(uri, 1, 0, "Polygon");
  qmlRegisterType<XYTarget>(uri, 1, 0, "Crosshair");
  qmlRegisterType<TouchArea>(uri, 1, 0, "TouchArea");

  qmlRegisterSingletonType<CppUtils>(
      uri, 1, 0, "CppUtils",
      [](QQmlEngine*, QJSEngine*) -> QObject* { return new CppUtils; });
}
}

#if defined(QPM_INIT)
static void creative_controls_init()
{
  static CreativeControls::Plugin p;
  p.registerTypes("com.github.jcelerier.CreativeControls");
}
Q_COREAPP_STARTUP_FUNCTION(creative_controls_init)
#endif
