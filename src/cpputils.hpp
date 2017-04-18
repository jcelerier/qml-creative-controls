#pragma once
#include <QObject>
#include <QColor>

class CppUtils : public QObject
{
  Q_OBJECT
public:
  explicit CppUtils(QObject *parent = 0);

signals:

public slots:
  double getHSVHue(QColor col);
  double getHSVSaturation(QColor col);
  double getHSVValue(QColor col);

  QColor setHSVHue(QColor col, double h);
  QColor setHSVSaturation(QColor col, double s);
  QColor setHSVValue(QColor col, double v);
};
