#include "graph.hpp"

#include <QSGFlatColorMaterial>
#include <QSGGeometry>
#include <QSGGeometryNode>
#include <QtMath>

namespace CreativeControls
{
Graph::Graph()
{
  setFlag(ItemHasContents, true);
  setAntialiasing(true);
}

QColor Graph::color() const
{
  return m_graphColor;
}

QVector<qreal> Graph::values() const
{
  return m_values;
}

bool Graph::lines() const
{
  return m_lines;
}

void Graph::setColor(const QColor main)
{
  if (m_graphColor == main)
    return;

  m_graphColor = main;
  emit colorChanged(m_graphColor);
  update();
}

/*!
 * \brief Move given values to inner member.
 * \note \c values could be empty after executing of this method.
 * \param values vector of values that should be moved.
 */
void Graph::setValues(QVector<qreal> values)
{
  if (m_values == values)
    return;

  m_values = std::move(values);
  emit valuesChanged(m_values);
  update();
}

void Graph::setLines(const bool lines)
{
  if (m_lines == lines)
    return;

  m_lines = lines;
  emit linesChanged(m_lines);
  update();
}

QSGNode*
Graph::updatePaintNode(QSGNode* oldNode, QQuickItem::UpdatePaintNodeData*)
{
  QSGGeometryNode* dotsNode{};
  QSGGeometry* dotsGeometry{};

  const auto n_pts = m_values.size();
  if (n_pts == 0)
  {
    if (dotsNode)
      delete dotsNode;
    return nullptr;
  }

  if (!oldNode)
  {
    dotsNode = new QSGGeometryNode;
    dotsGeometry
        = new QSGGeometry(QSGGeometry::defaultAttributes_Point2D(), n_pts);

    dotsGeometry->setLineWidth(2);
    dotsGeometry->setDrawingMode(
        m_lines ? QSGGeometry::DrawLineStrip : QSGGeometry::DrawPoints);

    dotsNode->setGeometry(dotsGeometry);
    dotsNode->setFlag(QSGNode::OwnsGeometry);

    auto border = new QSGFlatColorMaterial;
    border->setColor(m_graphColor);
    dotsNode->setMaterial(border);

    dotsNode->setFlag(QSGNode::OwnsMaterial);
  }
  else
  {
    dotsNode = static_cast<QSGGeometryNode*>(oldNode);
    dotsGeometry = dotsNode->geometry();

    dotsGeometry->allocate(n_pts);
    dotsGeometry->setDrawingMode(
        m_lines ? QSGGeometry::DrawLineStrip : QSGGeometry::DrawPoints);

    auto border = static_cast<QSGFlatColorMaterial*>(dotsNode->material());
    border->setColor(m_graphColor);
  }

  const auto w = width();
  const auto h = height();

  auto dotsVertices = dotsGeometry->vertexDataAsPoint2D();

  for (int i = 0; i < n_pts; ++i)
  {
    const auto x = qBound(0., w - 2 * (n_pts - i), w);
    const auto y = qBound(0., h - h * m_values[i], h);
    dotsVertices[i].set(x, y);
  }

  dotsNode->markDirty(QSGNode::DirtyGeometry);

  return dotsNode;
}
}
