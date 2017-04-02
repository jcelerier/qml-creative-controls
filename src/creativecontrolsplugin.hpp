#ifndef CREATIVECONTROLSPLUGIN_HPP
#define CREATIVECONTROLSPLUGIN_HPP

#include <QQmlExtensionPlugin>

class CreativeControlsPlugin : public QQmlExtensionPlugin
{
  Q_OBJECT
  Q_PLUGIN_METADATA(IID "org.qt-project.Qt.QQmlExtensionInterface")
public:
  CreativeControlsPlugin();

public:
  void registerTypes(const char *uri);
};

#endif // CREATIVECONTROLSPLUGIN_HPP
