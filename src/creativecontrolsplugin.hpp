#pragma once
#include <QQmlExtensionPlugin>

namespace CreativeControls
{
class Plugin final : public QQmlExtensionPlugin
{
  Q_OBJECT
  Q_PLUGIN_METADATA(IID "org.qt-project.Qt.QQmlExtensionInterface")
public:
  Plugin();
  void registerTypes(const char *uri) final override;
};
}
