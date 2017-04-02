#ifndef GRAPH_HPP
#define GRAPH_HPP

#include <QQuickItem>
#include <QQmlListProperty>
#include <QVector>

class Graph : public QQuickItem
{
  Q_OBJECT
  Q_PROPERTY(QColor graphColor READ graphColor WRITE setGraphColor NOTIFY graphColorChanged)
  Q_PROPERTY(QVector<qreal> values READ values WRITE setValues NOTIFY valuesChanged)
  Q_PROPERTY(bool lines READ lines WRITE setLines NOTIFY linesChanged)

public:
  Graph();

  QColor graphColor() const;
  QVector<qreal> values() const;
  bool lines() const;

signals:
  void graphColorChanged(QColor graphColor);
  void valuesChanged(QVector<qreal> values);
  void linesChanged(bool lines);

public slots:
  void setGraphColor(QColor graphColor);
  void setValues(QVector<qreal> values);
  void setLines(bool lines);

private:
  QSGNode* updatePaintNode(QSGNode*, UpdatePaintNodeData*) override;

  QColor m_graphColor;

  QVector<qreal> m_values;
  bool m_lines{};
};

#endif // GRAPH_HPP
