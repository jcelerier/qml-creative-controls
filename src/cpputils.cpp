#include "cpputils.hpp"

namespace CreativeControls
{
CppUtils::CppUtils(QObject* parent) : QObject(parent)
{
}

double CppUtils::getHSVHue(const QColor col)
{
  return col.hsvHueF();
}

double CppUtils::getHSVSaturation(const QColor col)
{
  return col.hsvSaturationF();
}

double CppUtils::getHSVValue(const QColor col)
{
  return col.valueF();
}

QColor CppUtils::setHSVHue(const QColor col, double h)
{
  auto s = col.hsvSaturationF();
  auto v = col.valueF();

  return QColor::fromHsvF(h, s, v);
}

QColor CppUtils::setHSVSaturation(const QColor col, const double s)
{
  auto h = col.hsvHueF();
  auto v = col.valueF();

  return QColor::fromHsvF(h, s, v);
}

QColor CppUtils::setHSVValue(const QColor col, const double v)
{
  auto h = col.hsvHueF();
  auto s = col.hsvSaturationF();

  return QColor::fromHsvF(h, s, v);
}
}
