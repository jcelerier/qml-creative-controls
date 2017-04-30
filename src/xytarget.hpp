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
  Q_PROPERTY(QColor color READ color WRITE setColor NOTIFY colorChanged FINAL)

public:
  XYTarget();

  double centerX() const;
  double centerY() const;
  QColor color() const;

public slots:
  void setCenterX(double centerX);
  void setCenterY(double centerY);
  void setColor(QColor color);

signals:
  void centerXChanged(double centerX);
  void centerYChanged(double centerY);
  void colorChanged(QColor color);

private:
  void paint(QPainter* painter) final override;
  void mousePressEvent(QMouseEvent* event) final override;
  void mouseDoubleClickEvent(QMouseEvent* event) final override;
  void mouseMoveEvent(QMouseEvent* event) final override;
  void mouseReleaseEvent(QMouseEvent* event) final override;
  bool contains(const QPointF &point) const final override;

  void updatePenWidth();

  double m_centerX{0.5};
  double m_centerY{0.5};
  double m_width{};
  double m_radius{};

  QColor m_color{};
  QPen m_pen;
  QBrush m_brush;
  QPointF m_lastPos;
};
}
