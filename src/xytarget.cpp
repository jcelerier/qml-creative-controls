#include "xytarget.hpp"
#include <QPainter>
#include <QDebug>
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
  painter->drawEllipse(w - m_radius, h - m_radius, 2. * m_radius, 2. * m_radius);
}

void XYTarget::mousePressEvent(QMouseEvent* event)
{
  if(contains(event->pos()))
  {
    m_lastPos = event->pos();
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
  event->accept();
}

bool XYTarget::contains(const QPointF& point) const
{
  const auto w = m_centerX * width();
  const auto h = m_centerY * height();
  return point.x() > (w - m_radius)
      && point.x() < (w + m_radius)
      && point.y() > (h - m_radius)
      && point.y() < (h + m_radius);
}

void XYTarget::updatePenWidth()
{
  using namespace std;
  m_pen.setWidthF(lround(std::min(height(), width()) / 40.));

  m_radius = std::min(height(), width()) / 35.;
}

double XYTarget::centerX() const
{
  return m_centerX;
}

double XYTarget::centerY() const
{
  return m_centerY;
}

QColor XYTarget::color() const
{
  return m_color;
}

void XYTarget::setCenterX(double centerX)
{
  if (m_centerX == centerX)
    return;

  m_centerX = qBound(0., centerX, 1.);
  emit centerXChanged(centerX);
  update();
}

void XYTarget::setCenterY(double centerY)
{
  if (m_centerY == centerY)
    return;

  m_centerY = qBound(0., centerY, 1.);
  emit centerYChanged(centerY);
  update();
}

void XYTarget::setColor(QColor color)
{
  if (m_color == color)
    return;

  m_color = color;
  m_pen.setColor(m_color);
  m_brush.setColor(m_color);
  emit colorChanged(color);
  update();
}
}
