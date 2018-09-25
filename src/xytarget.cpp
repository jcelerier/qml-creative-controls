#include "xytarget.hpp"

#include <QDebug>
#include <QPainter>

#include <cmath>

namespace CreativeControls
{
XYTarget::XYTarget()
{
  setFlag(ItemHasContents, true);
  setAcceptedMouseButtons(Qt::LeftButton);
  setAntialiasing(true);
  m_pen.setCosmetic(true);
  m_brush.setStyle(Qt::SolidPattern);

  connect(this, &QQuickItem::widthChanged, this, &XYTarget::updatePenWidth);
  connect(this, &QQuickItem::heightChanged, this, &XYTarget::updatePenWidth);
}

void XYTarget::paint(QPainter* painter)
{
  const auto w = m_centerX * width();
  const auto h = m_centerY * height();

  painter->setRenderHint(QPainter::RenderHint::Antialiasing, false);
  painter->setPen(m_pen);
  painter->setBrush(m_brush);
  painter->drawLine(w, 0., w, height());
  painter->drawLine(0., h, width(), h);
  painter->setRenderHint(QPainter::RenderHint::Antialiasing, true);
  painter->drawEllipse(
      w - m_radius, h - m_radius, 2. * m_radius, 2. * m_radius);
}

void XYTarget::mousePressEvent(QMouseEvent* event)
{
  if (contains(event->pos()))
  {
    auto new_x = event->pos().x() / width();
    auto new_y = event->pos().y() / height();

    m_lastPos = event->pos();
    setCenterX(new_x);
    setCenterY(new_y);
    setPressed(true);
    event->accept();
    return;
  }
  event->ignore();
}

void XYTarget::mouseDoubleClickEvent(QMouseEvent* event)
{
  event->ignore();
}

void XYTarget::mouseMoveEvent(QMouseEvent* event)
{
  auto new_x = event->pos().x() / width();
  auto new_y = event->pos().y() / height();

  m_lastPos = event->pos();
  setCenterX(new_x);
  setCenterY(new_y);
  event->accept();
}

void XYTarget::mouseReleaseEvent(QMouseEvent* event)
{
  setPressed(false);
  event->accept();
}

void XYTarget::touchEvent(QTouchEvent* event)
{
  if (!event->touchPoints().empty())
  {
    setPressed(true);
    const auto& first = event->touchPoints().first();
    switch (first.state())
    {
      case Qt::TouchPointPressed:
      {
        if (contains(first.pos()))
        {
          m_lastPos = first.pos();
          event->accept();
        }
        else
        {
          event->ignore();
        }
        break;
      }
      case Qt::TouchPointMoved:
      {
        auto new_x = first.pos().x() / width();
        auto new_y = first.pos().y() / height();

        m_lastPos = first.pos();
        setCenterX(new_x);
        setCenterY(new_y);
        event->accept();

        break;
      }
      case Qt::TouchPointStationary:
        break;
      case Qt::TouchPointReleased:
        event->accept();
        break;
      default:
        break;
    }
  }
  else
  {
    setPressed(false);
  }
}

bool XYTarget::contains(const QPointF& point) const
{
  const auto w = m_centerX * width();
  const auto h = m_centerY * height();
  return point.x() > (w - m_radius) && point.x() < (w + m_radius)
         && point.y() > (h - m_radius) && point.y() < (h + m_radius);
}

void XYTarget::updatePenWidth()
{
  using namespace std;
  m_pen.setWidthF(lround(std::min(height(), width()) / 40.));

  m_radius = std::min(height(), width()) / m_radiusScale;
}

qreal XYTarget::centerX() const
{
  return m_centerX;
}

qreal XYTarget::centerY() const
{
  return m_centerY;
}

qreal XYTarget::radiusScale() const
{
  return m_radiusScale;
}

QColor XYTarget::color() const
{
  return m_color;
}

bool XYTarget::pressed() const
{
  return m_pressed;
}

void XYTarget::setCenterX(const qreal centerX)
{
  if (qFuzzyCompare(m_centerX, centerX))
    return;

  m_centerX = qBound(0., centerX, 1.);
  emit centerXChanged(centerX);
  update();
}

void XYTarget::setCenterY(const qreal centerY)
{
  if (qFuzzyCompare(m_centerY, centerY))
    return;

  m_centerY = qBound(0., centerY, 1.);
  emit centerYChanged(centerY);
  update();
}

void XYTarget::setRadiusScale(const qreal radiusScale)
{
  if (qFuzzyCompare(m_radiusScale, radiusScale))
    return;

  m_radiusScale = radiusScale;
  emit radiusScaleChanged(m_radiusScale);
  updatePenWidth();
  update();
}

void XYTarget::setColor(const QColor color)
{
  if (m_color == color)
    return;

  m_color = color;
  m_pen.setColor(m_color);
  m_brush.setColor(m_color);
  emit colorChanged(m_color);
  update();
}

void XYTarget::setPressed(const bool pressed)
{
  if (pressed != m_pressed)
  {
    m_pressed = pressed;
    pressedChanged(m_pressed);
  }
}
}
