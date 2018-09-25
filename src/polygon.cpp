#include "polygon.hpp"

#include <QSGFlatColorMaterial>
#include <QSGGeometryNode>
#include <QtMath>

namespace CreativeControls
{
Polygon::Polygon()
{
  setFlag(ItemHasContents, true);
  setAntialiasing(true);
}

QSGNode*
Polygon::updatePaintNode(QSGNode* oldNode, QQuickItem::UpdatePaintNodeData*)
{
  // Attention les yeux...
  QSGGeometryNode *fillNode{}, *borderNode{};
  QSGGeometry *fillGeometry{}, *borderGeometry{};

  if (!oldNode)
  {
    // D'abord un noeud racine pour le "fill"
    fillNode = new QSGGeometryNode;
    fillGeometry
        = new QSGGeometry(QSGGeometry::defaultAttributes_Point2D(), m_sides);

    fillGeometry->setLineWidth(0);
    fillGeometry->setDrawingMode(GL_TRIANGLE_FAN);

    fillNode->setGeometry(fillGeometry);
    fillNode->setFlag(QSGNode::OwnsGeometry);

    auto fill = new QSGFlatColorMaterial;
    fill->setColor(m_color);
    fillNode->setMaterial(fill);

    fillNode->setFlag(QSGNode::OwnsMaterial);

    borderNode = new QSGGeometryNode;
    borderGeometry
        = new QSGGeometry(QSGGeometry::defaultAttributes_Point2D(), m_sides);

    borderGeometry->setLineWidth(m_borderWidth);
    borderGeometry->setDrawingMode(GL_LINE_LOOP);

    borderNode->setGeometry(borderGeometry);
    borderNode->setFlag(QSGNode::OwnsGeometry);

    auto border = new QSGFlatColorMaterial;
    border->setColor(m_borderColor);
    borderNode->setMaterial(border);

    borderNode->setFlag(QSGNode::OwnsMaterial);
    fillNode->appendChildNode(borderNode);
  }
  else
  {
    fillNode = static_cast<QSGGeometryNode*>(oldNode);
    fillGeometry = fillNode->geometry();
    fillGeometry->allocate(m_sides);
    auto fill = static_cast<QSGFlatColorMaterial*>(fillNode->material());
    fill->setColor(m_color);

    borderNode = static_cast<QSGGeometryNode*>(fillNode->childAtIndex(0));
    borderGeometry = borderNode->geometry();
    borderGeometry->allocate(m_sides);

    auto border = static_cast<QSGFlatColorMaterial*>(borderNode->material());
    border->setColor(m_borderColor);
  }

  const auto bounds = boundingRect();
  const auto w = bounds.width();
  const auto h = bounds.height();
  const auto half_w = w / 2.;
  const auto half_h = h / 2.;
  auto fillVertices = fillGeometry->vertexDataAsPoint2D();
  auto borderVertices = borderGeometry->vertexDataAsPoint2D();

  const auto theta = 2. * M_PI / m_sides;

  // The user gives the rotation in degrees, we convert to radians for sin /
  // cos.
  const auto rotation = 2. * M_PI * m_rotation / 360.;
  for (int i = 0; i < m_sides; ++i)
  {
    const auto x
        = bounds.x() + half_w + std::cos(i * theta + rotation) * half_w;
    const auto y
        = bounds.y() + half_h + std::sin(i * theta + rotation) * half_h;
    fillVertices[i].set(x, y);
    borderVertices[i].set(x, y);
  }

  fillNode->markDirty(QSGNode::DirtyGeometry);
  fillNode->markDirty(QSGNode::DirtyMaterial);
  borderNode->markDirty(QSGNode::DirtyGeometry);
  borderNode->markDirty(QSGNode::DirtyMaterial);

  return fillNode;
}

int Polygon::sides() const
{
  return m_sides;
}

QColor Polygon::borderColor() const
{
  return m_borderColor;
}

QColor Polygon::fillColor() const
{
  return m_color;
}

qreal Polygon::borderWidth() const
{
  return m_borderWidth;
}

qreal Polygon::rotation() const
{
  return m_rotation;
}

void Polygon::setSides(const int sides)
{
  if (m_sides == sides)
    return;

  m_sides = sides;
  emit sidesChanged(m_sides);
  update();
}

void Polygon::setBorderColor(const QColor borderColor)
{
  if (m_borderColor == borderColor)
    return;

  m_borderColor = borderColor;
  emit borderColorChanged(borderColor);
  update();
}

void Polygon::setFillColor(const QColor color)
{
  if (m_color == color)
    return;

  m_color = color;
  emit fillColorChanged(m_color);
  update();
}

void Polygon::setBorderWidth(const qreal borderWidth)
{
  if (qFuzzyCompare(m_borderWidth, borderWidth))
    return;

  m_borderWidth = borderWidth;
  emit borderWidthChanged(m_borderWidth);
  update();
}

void Polygon::setRotation(const qreal rotation)
{
  if (qFuzzyCompare(m_rotation, rotation))
    return;

  m_rotation = rotation;
  emit rotationChanged(m_rotation);
  update();
}
}
