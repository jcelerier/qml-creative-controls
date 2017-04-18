#include "cpputils.hpp"

CppUtils::CppUtils(QObject *parent) : QObject(parent)
{

}

double CppUtils::getHSVHue(QColor col)
{
  return col.hsvHueF();
}

double CppUtils::getHSVSaturation(QColor col)
{
  return col.hsvSaturationF();
}

double CppUtils::getHSVValue(QColor col)
{
  return col.valueF();
}

QColor CppUtils::setHSVHue(QColor col, double h)
{
  auto s = col.hsvSaturationF();
  auto v = col.valueF();

  return QColor::fromHsvF(h, s, v);
}

QColor CppUtils::setHSVSaturation(QColor col, double s)
{
  auto h = col.hsvHueF();
  auto v = col.valueF();

  return QColor::fromHsvF(h, s, v);
}

QColor CppUtils::setHSVValue(QColor col, double v)
{
  auto h = col.hsvHueF();
  auto s = col.hsvSaturationF();

  return QColor::fromHsvF(h, s, v);
}
