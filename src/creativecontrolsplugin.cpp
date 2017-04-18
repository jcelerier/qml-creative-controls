#include "creativecontrolsplugin.hpp"
#include "graph.hpp"
#include "angleslider.hpp"
#include "scope.hpp"

CreativeControlsPlugin::CreativeControlsPlugin()
{

}

void CreativeControlsPlugin::registerTypes(const char *uri)
{
  qmlRegisterType<Graph>(uri, 1, 0, "GraphImpl");
  qmlRegisterType<AngleSlider>(uri, 1, 0, "AngleSliderImpl");
  qmlRegisterType<Scope>(uri, 1, 0, "ScopeImpl");
}

