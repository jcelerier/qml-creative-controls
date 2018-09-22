#pragma once

#include <QQuickItem>

namespace CreativeControls
{
class TouchArea : public QQuickItem
{
  Q_OBJECT
  Q_PROPERTY(bool pressState READ pressState WRITE setPressState NOTIFY pressStateChanged)
  bool m_pressState{};

public:
  TouchArea();

  bool pressState() const;

public slots:
  void setPressState(const bool pressState);

signals:
  void pressed(QPointF point);
  void positionChanged(QPointF point);
  void released(QPointF point);
  void doubleClicked(QPointF point);

  void pressStateChanged(bool pressState);

protected:
  void mousePressEvent(QMouseEvent* event) final override;
  void mouseMoveEvent(QMouseEvent* event) final override;
  void mouseReleaseEvent(QMouseEvent* event) final override;
  void mouseDoubleClickEvent(QMouseEvent* event) final override;
  void touchEvent(QTouchEvent* event) final override;
};
}
