#include "toucharea.hpp"

namespace CreativeControls
{

TouchArea::TouchArea()
{
  this->setAcceptedMouseButtons(Qt::LeftButton);
}

bool TouchArea::pressState() const
{
  return m_pressState;
}

void TouchArea::setPressState(const bool pressState)
{
  if (m_pressState == pressState)
    return;

  m_pressState = pressState;
  emit pressStateChanged(m_pressState);
}

void TouchArea::mousePressEvent(QMouseEvent* event)
{
  emit pressed(event->localPos());
  setPressState(true);
  event->accept();
}

void TouchArea::mouseMoveEvent(QMouseEvent* event)
{
  emit positionChanged(event->localPos());
  event->accept();
}

void TouchArea::mouseReleaseEvent(QMouseEvent* event)
{
  emit released(event->localPos());
  setPressState(false);
  event->accept();
}

void TouchArea::mouseDoubleClickEvent(QMouseEvent* event)
{
  emit doubleClicked(event->localPos());
  event->accept();
}

void TouchArea::touchEvent(QTouchEvent* event)
{
  setPressState(event->touchPoints().size() > 0);
  if (m_pressState)
  {
    const auto& touchpoint = *event->touchPoints().begin();
    switch (touchpoint.state())
    {
      case Qt::TouchPointPressed:
        emit pressed(touchpoint.pos());
        break;
      case Qt::TouchPointMoved:
        emit positionChanged(touchpoint.pos());
        break;
      case Qt::TouchPointStationary:
        break;
      case Qt::TouchPointReleased:
        emit released(touchpoint.pos());
        break;
      default:
        break;
    }
  }
  event->accept();
}
}
