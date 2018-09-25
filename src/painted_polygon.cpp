#include "painted_polygon.hpp"

#include <QPainter>
#include <QSGFlatColorMaterial>
#include <QSGGeometryNode>
#include <QtMath>

namespace CreativeControls
{
PaintedPolygon::PaintedPolygon()
{
  setFlag(ItemHasContents, true);
  setAntialiasing(true);
}

int PaintedPolygon::sides() const
{
  return m_sides;
}

QColor PaintedPolygon::borderColor() const
{
  return m_borderColor;
}

QColor PaintedPolygon::fillColor() const
{
  return m_color;
}

qreal PaintedPolygon::borderWidth() const
{
  return m_borderWidth;
}

qreal PaintedPolygon::rotation() const
{
  return m_rotation;
}

void PaintedPolygon::setSides(const int sides)
{
  if (m_sides == sides)
    return;

  m_sides = sides;
  emit sidesChanged(m_sides);
  update();
}

void PaintedPolygon::setBorderColor(const QColor borderColor)
{
  if (m_borderColor == borderColor)
    return;

  m_borderColor = borderColor;
  emit borderColorChanged(m_borderColor);
  update();
}

void PaintedPolygon::setFillColor(const QColor color)
{
  if (m_color == color)
    return;

  m_color = color;
  emit fillColorChanged(m_color);
  update();
}

void PaintedPolygon::setBorderWidth(const qreal borderWidth)
{
  if (qFuzzyCompare(m_borderWidth, borderWidth))
    return;

  m_borderWidth = borderWidth;
  emit borderWidthChanged(m_borderWidth);
  update();
}

void PaintedPolygon::setRotation(const qreal rotation)
{
  if (qFuzzyCompare(m_rotation, rotation))
    return;

  m_rotation = rotation;
  emit rotationChanged(m_rotation);
  update();
}

void PaintedPolygon::paint(QPainter* painter)
{
  const auto bounds = boundingRect();
  const auto w = bounds.width() - 4.;
  const auto h = bounds.height() - 4.;
  const auto half_w = w / 2.;
  const auto half_h = h / 2.;
  const auto theta = 2. * M_PI / m_sides;

  QPolygonF poly;
  poly.reserve(m_sides);
  // The user gives the rotation in degrees, we convert to radians for sin /
  // cos.
  const auto rotation = 2. * M_PI * m_rotation / 360.;
  for (int i = 0; i < m_sides; ++i)
  {
    const auto x
        = 2. + bounds.x() + half_w + std::cos(i * theta + rotation) * half_w;
    const auto y
        = 2. + bounds.y() + half_h + std::sin(i * theta + rotation) * half_h;

    poly.push_back(QPointF{x, y});
  }

  painter->setPen(m_borderColor);
  painter->setBrush(m_color);
  painter->drawConvexPolygon(poly);
}
}
