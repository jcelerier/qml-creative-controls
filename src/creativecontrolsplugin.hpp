#pragma once
#include <QQmlExtensionPlugin>

class CreativeControlsPlugin : public QQmlExtensionPlugin
{
  Q_OBJECT
  Q_PLUGIN_METADATA(IID "org.qt-project.Qt.QQmlExtensionInterface")
public:
  CreativeControlsPlugin();

private:
  void registerTypes(const char *uri) final override;
};
