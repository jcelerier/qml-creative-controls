#include "graph.hpp"

#include <QSGFlatColorMaterial>
#include <QSGGeometryNode>
#include <QSGGeometry>

Graph::Graph()
{
  setFlag(ItemHasContents, true);
  setAntialiasing(true);
}

QColor Graph::graphColor() const
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

void Graph::setGraphColor(QColor main)
{
  if (m_graphColor == main)
    return;

  m_graphColor = main;
  emit graphColorChanged(main);
  update();
}

void Graph::setValues(QVector<qreal> values)
{
  if (m_values == values)
    return;

  m_values = std::move(values);
  emit valuesChanged(values);
  update();
}

void Graph::setLines(bool lines)
{
  if (m_lines == lines)
    return;

  m_lines = lines;
  emit linesChanged(lines);
  update();
}

QSGNode* Graph::updatePaintNode(
    QSGNode* oldNode,
    QQuickItem::UpdatePaintNodeData* )
{
  // Attention les yeux...
  QSGGeometryNode *dotsNode{};
  QSGGeometry *dotsGeometry{};

  const auto n_pts = m_values.size();
  if (!oldNode)
  {
    // Ensuite un noeud ou on dessine les points
    dotsNode = new QSGGeometryNode;
    dotsGeometry = new QSGGeometry(QSGGeometry::defaultAttributes_Point2D(), n_pts);

    dotsGeometry->setLineWidth(2);
    dotsGeometry->setDrawingMode(m_lines ? QSGGeometry::DrawLineStrip : QSGGeometry::DrawPoints);

    dotsNode->setGeometry(dotsGeometry);
    dotsNode->setFlag(QSGNode::OwnsGeometry);

    // La couleur des bords
    auto border = new QSGFlatColorMaterial;
    border->setColor(m_graphColor);
    dotsNode->setMaterial(border);

    dotsNode->setFlag(QSGNode::OwnsMaterial);
  }
  else
  {
    // Mise à jour si les noeuds ont déjà été créés.
    dotsNode = static_cast<QSGGeometryNode *>(oldNode);
    dotsGeometry = dotsNode->geometry();
    dotsGeometry->allocate(n_pts);
    dotsGeometry->setDrawingMode(m_lines ? QSGGeometry::DrawLineStrip : QSGGeometry::DrawPoints);

    auto border = static_cast<QSGFlatColorMaterial*>(dotsNode->material());
    border->setColor(m_graphColor);
  }

  const auto w = width();
  const auto h = height();

  auto dotsVertices = dotsGeometry->vertexDataAsPoint2D();

  for (int i = 0; i < n_pts; ++i)
  {
    dotsVertices[i].set(w - 2 * (n_pts - i),  h - h * (1. + m_values[i]) / 2.);
  }

  dotsNode->markDirty(QSGNode::DirtyGeometry);

  return dotsNode;
}
