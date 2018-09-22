#pragma once
#include <QQuickPaintedItem>
#include <QPen>
#include <QBrush>

namespace CreativeControls
{
class XYTarget : public QQuickPaintedItem
{
  Q_OBJECT
  Q_PROPERTY(double centerX READ centerX WRITE setCenterX NOTIFY centerXChanged FINAL)
  Q_PROPERTY(double centerY READ centerY WRITE setCenterY NOTIFY centerYChanged FINAL)
  Q_PROPERTY(double radiusScale READ radiusScale WRITE setRadiusScale NOTIFY radiusScaleChanged FINAL)
  Q_PROPERTY(QColor color READ color WRITE setColor NOTIFY colorChanged FINAL)
  Q_PROPERTY(bool pressed READ pressed WRITE setPressed NOTIFY pressedChanged FINAL)

public:
  XYTarget();

  double centerX() const;
  double centerY() const;
  double radiusScale() const;
  QColor color() const;
  bool pressed() const;

public slots:
  void setCenterX(const double centerX);
  void setCenterY(const double centerY);
  void setRadiusScale(const double radiusScale);
  void setColor(const QColor color);
  void setPressed(const bool pressed);

signals:
  void centerXChanged(double centerX);
  void centerYChanged(double centerY);
  void radiusScaleChanged(double radiusScale);
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

  double m_centerX{0.5};
  double m_centerY{0.5};
  double m_width{};
  double m_radius{35.};
  double m_radiusScale{35.};

  QColor m_color{};
  QPen m_pen;
  QBrush m_brush;
  QPointF m_lastPos{};

  bool m_pressed{};
};
}
