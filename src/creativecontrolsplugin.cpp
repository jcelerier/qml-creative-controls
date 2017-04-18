#include "creativecontrolsplugin.hpp"
#include "graph.hpp"
#include "angleslider.hpp"
#include "scope.hpp"
#include "circle.hpp"
#include "cpputils.hpp"
#include "xytarget.hpp"

CreativeControlsPlugin::CreativeControlsPlugin()
{

}

void CreativeControlsPlugin::registerTypes(const char *uri)
{
  qmlRegisterType<Graph>(uri, 1, 0, "GraphImpl");
  qmlRegisterType<AngleSlider>(uri, 1, 0, "AngleSliderImpl");
  qmlRegisterType<Scope>(uri, 1, 0, "ScopeImpl");
  qmlRegisterType<Polygon>(uri, 1, 0, "Polygon");
  qmlRegisterType<XYTarget>(uri, 1, 0, "XYTarget");

  qmlRegisterSingletonType<CppUtils>(uri, 1, 0, "CppUtils",
                                     [] (QQmlEngine *engine, QJSEngine *scriptEngine) -> QObject* {
    return new CppUtils;
  });
}

