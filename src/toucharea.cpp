#include "toucharea.hpp"

namespace CreativeControls
{

TouchArea::TouchArea()
{
  this->setAcceptedMouseButtons(Qt::LeftButton);
}

void TouchArea::mousePressEvent(QMouseEvent* event)
{
  emit pressed(event->localPos());
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
  event->accept();
}

void TouchArea::mouseDoubleClickEvent(QMouseEvent* event)
{
  emit doubleClicked(event->localPos());
  event->accept();
}

void TouchArea::touchEvent(QTouchEvent* event)
{
  if(event->touchPoints().size() > 0)
  {
    const auto& touchpoint = *event->touchPoints().begin();
    switch(touchpoint.state())
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
