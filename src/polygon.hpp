#pragma once
#include <QQuickItem>

namespace CreativeControls
{
class Polygon : public QQuickItem
{
  Q_OBJECT
  Q_PROPERTY(int sides READ sides WRITE setSides NOTIFY sidesChanged FINAL)
  Q_PROPERTY(qreal rotation READ rotation WRITE setRotation NOTIFY rotationChanged FINAL)
  Q_PROPERTY(qreal borderWidth READ borderWidth WRITE setBorderWidth NOTIFY borderWidthChanged FINAL)
  Q_PROPERTY(QColor borderColor READ borderColor WRITE setBorderColor NOTIFY borderColorChanged FINAL)
  Q_PROPERTY(QColor fillColor READ fillColor WRITE setFillColor NOTIFY fillColorChanged FINAL)

public:
  Polygon();

  int sides() const;
  QColor borderColor() const;
  QColor fillColor() const;
  qreal borderWidth() const;
  qreal rotation() const;

public slots:
  void setSides(const int sides);
  void setBorderColor(const QColor borderColor);
  void setFillColor(const QColor fillColor);
  void setBorderWidth(const qreal borderWidth);
  void setRotation(const qreal rotation);

signals:
  void sidesChanged(int sides);
  void borderColorChanged(QColor borderColor);
  void fillColorChanged(QColor fillColor);
  void borderWidthChanged(qreal borderWidth);
  void rotationChanged(qreal rotation);

private:
  QSGNode* updatePaintNode(QSGNode*, UpdatePaintNodeData*) final override;

  int m_sides = 64;
  QColor m_borderColor = Qt::red;
  QColor m_color = Qt::white;
  qreal m_borderWidth = 4;
  qreal m_rotation = 0;
};
}
