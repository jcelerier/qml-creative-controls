#pragma once
#include <QQuickPaintedItem>
#include <QPen>
#include <QBrush>

namespace CreativeControls
{
class XYTarget : public QQuickPaintedItem
{
  Q_OBJECT
  Q_PROPERTY(qreal centerX READ centerX WRITE setCenterX NOTIFY centerXChanged FINAL)
  Q_PROPERTY(qreal centerY READ centerY WRITE setCenterY NOTIFY centerYChanged FINAL)
  Q_PROPERTY(qreal radiusScale READ radiusScale WRITE setRadiusScale NOTIFY radiusScaleChanged FINAL)
  Q_PROPERTY(QColor color READ color WRITE setColor NOTIFY colorChanged FINAL)
  Q_PROPERTY(bool pressed READ pressed WRITE setPressed NOTIFY pressedChanged FINAL)

public:
  XYTarget();

  qreal centerX() const;
  qreal centerY() const;
  qreal radiusScale() const;
  QColor color() const;
  bool pressed() const;

public slots:
  void setCenterX(const qreal centerX);
  void setCenterY(const qreal centerY);
  void setRadiusScale(const qreal radiusScale);
  void setColor(const QColor color);
  void setPressed(const bool pressed);

signals:
  void centerXChanged(qreal centerX);
  void centerYChanged(qreal centerY);
  void radiusScaleChanged(qreal radiusScale);
  void colorChanged(QColor color);
  void pressedChanged(bool pressed);

private:
  void paint(QPainter* painter) final override;
  void mousePressEvent(QMouseEvent* event) final override;
  void mouseDoubleClickEvent(QMouseEvent* event) final override;
  void mouseMoveEvent(QMouseEvent* event) final override;
  void mouseReleaseEvent(QMouseEvent* event) final override;
  void touchEvent(QTouchEvent* event) final override;
  bool contains(const QPointF &point) const final override;

  void updatePenWidth();

  qreal m_centerX{0.5};
  qreal m_centerY{0.5};
  qreal m_width{};
  qreal m_radius{35.};
  qreal m_radiusScale{35.};

  QColor m_color{};
  QPen m_pen;
  QBrush m_brush;
  QPointF m_lastPos{};

  bool m_pressed{};
};
}
