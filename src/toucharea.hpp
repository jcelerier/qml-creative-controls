#pragma once

#include <QQuickItem>

namespace CreativeControls
{
class TouchArea : public QQuickItem
{
  Q_OBJECT
public:
  TouchArea();

signals:
  void pressed(QPointF point);
  void positionChanged(QPointF point);
  void released(QPointF point);
  void doubleClicked(QPointF point);

protected:
  void mousePressEvent(QMouseEvent* event) final override;
  void mouseMoveEvent(QMouseEvent* event) final override;
  void mouseReleaseEvent(QMouseEvent* event) final override;
  void mouseDoubleClickEvent(QMouseEvent* event) final override;
  void touchEvent(QTouchEvent* event) final override;
};
}
