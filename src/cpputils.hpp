#pragma once
#include <QObject>
#include <QColor>

namespace CreativeControls
{
class CppUtils final : public QObject
{
  Q_OBJECT
public:
  explicit CppUtils(QObject *parent = 0);

signals:

public slots:
  double getHSVHue(const QColor col);
  double getHSVSaturation(const QColor col);
  double getHSVValue(const QColor col);

  QColor setHSVHue(const QColor col, const double h);
  QColor setHSVSaturation(const QColor col, const double s);
  QColor setHSVValue(const QColor col, const double v);
};
}
