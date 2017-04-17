#include "creativecontrolsplugin.hpp"
#include "graph.hpp"
#include "angleslider.hpp"

CreativeControlsPlugin::CreativeControlsPlugin()
{

}

void CreativeControlsPlugin::registerTypes(const char *uri)
{
  qmlRegisterType<Graph>(uri, 1, 0, "Plot1D");
  qmlRegisterType<AngleSlider>(uri, 1, 0, "AngleSliderImpl");
}

