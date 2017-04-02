#include "creativecontrolsplugin.hpp"
#include "graph.hpp"

CreativeControlsPlugin::CreativeControlsPlugin()
{

}

void CreativeControlsPlugin::registerTypes(const char *uri)
{
  qmlRegisterType<Graph>(uri, 1, 0, "Plot1D");
}

