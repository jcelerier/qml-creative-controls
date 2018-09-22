#pragma once
#include <QQuickItem>
#include <QQmlListProperty>
#include <QVector>

namespace CreativeControls
{
class Graph : public QQuickItem
{
  Q_OBJECT
  Q_PROPERTY(QColor color READ color WRITE setColor NOTIFY colorChanged FINAL)
  Q_PROPERTY(QVector<qreal> values READ values WRITE setValues NOTIFY valuesChanged FINAL)
  Q_PROPERTY(bool lines READ lines WRITE setLines NOTIFY linesChanged FINAL)

public:
  Graph();

  QColor color() const;
  QVector<qreal> values() const;
  bool lines() const;

signals:
  void colorChanged(QColor color);
  void valuesChanged(QVector<qreal> values);
  void linesChanged(bool lines);

public slots:
  void setColor(const QColor color);
  void setValues(QVector<qreal> values);
  void setLines(const bool lines);

private:
  QSGNode* updatePaintNode(QSGNode*, UpdatePaintNodeData*) final override;

  QVector<qreal> m_values;
  QColor m_graphColor{};
  bool m_lines{};
};
}
