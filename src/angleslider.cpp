#include "angleslider.hpp"

#include <QPainter>
#include <QtMath>

#include <complex>

namespace CreativeControls
{
static const constexpr auto deg_to_rad = 2. * M_PI / 360.;
static const constexpr auto rad_to_deg = 360. / (2. * M_PI);

AngleSlider::AngleSlider()
{
  setFlag(ItemHasContents, true);
  setAcceptedMouseButtons(Qt::LeftButton);
  setAntialiasing(true);
}

void AngleSlider::paint(QPainter* painter)
{
  const auto rect = boundingRect();
  auto borderWidth = (rect.width() / 2) * 1. / 15.;
  const auto radius = rect.width() / 2. - borderWidth / 2. - 1;
  QPen p;
  p.setWidth(borderWidth);
  p.setColor(m_detailColor);

  painter->setPen(p);
  painter->setBrush(m_baseColor);
  painter->drawEllipse(rect.center(), radius, radius);

  std::complex<double> pt = std::polar(radius - 2, angle() * deg_to_rad);
  std::complex<double> pt_min = std::polar(radius - 2, min() * deg_to_rad);
  std::complex<double> pt_min_end = std::polar(radius - 5, min() * deg_to_rad);
  std::complex<double> pt_max = std::polar(radius - 2, max() * deg_to_rad);
  std::complex<double> pt_max_end = std::polar(radius - 5, max() * deg_to_rad);

  const auto cx = rect.center().x();
  const auto cy = rect.center().y();
  painter->setBrush(m_detailColor);
  painter->drawLine(rect.center(), QPointF{pt.real() + cx, pt.imag() + cy});
  painter->drawEllipse(rect.center(), radius / 20., radius / 20.);

  p.setWidth(borderWidth * 0.75);
  painter->setPen(p);
  painter->drawLine(
      QPointF{pt_min_end.real() + cx, pt_min_end.imag() + cy},
      QPointF{pt_min.real() + cx, pt_min.imag() + cy});
  painter->drawLine(
      QPointF{pt_max_end.real() + cx, pt_max_end.imag() + cy},
      QPointF{pt_max.real() + cx, pt_max.imag() + cy});
}

qreal AngleSlider::angle() const
{
  return m_angle;
}

qreal AngleSlider::min() const
{
  return m_min;
}

qreal AngleSlider::max() const
{
  return m_max;
}

QColor AngleSlider::baseColor() const
{
  return m_baseColor;
}

QColor AngleSlider::detailColor() const
{
  return m_detailColor;
}

void AngleSlider::setAngle(const qreal angle)
{
  if (qFuzzyCompare(m_angle, angle))
    return;

  if (angle < min())
    m_angle = min();
  else if (angle > max())
    m_angle = max();
  else
    m_angle = angle;
  emit angleChanged(m_angle);
  update();
}

void AngleSlider::setMin(const qreal angle)
{
  if (qFuzzyCompare(m_min, angle))
    return;

  m_min = angle;
  update();
}

void AngleSlider::setMax(const qreal angle)
{
  if (qFuzzyCompare(m_max, angle))
    return;

  m_max = angle;
  update();
}

void AngleSlider::setBaseColor(const QColor baseColor)
{
  if (m_baseColor == baseColor)
    return;

  m_baseColor = baseColor;
  emit baseColorChanged(m_baseColor);
  update();
}

void AngleSlider::setDetailColor(const QColor detailColor)
{
  if (m_detailColor == detailColor)
    return;

  m_detailColor = detailColor;
  emit detailColorChanged(m_detailColor);
  update();
}

void AngleSlider::updateAngle(QPointF point)
{
  const auto c = boundingRect().center();

  std::complex<double> pt(point.x() - c.x(), point.y() - c.y());
  setAngle(std::arg(pt) * rad_to_deg);
}

void AngleSlider::mousePressEvent(QMouseEvent* event)
{
  updateAngle(event->localPos());

  event->accept();
}

void AngleSlider::mouseDoubleClickEvent(QMouseEvent* event)
{
  setAngle(0);
  event->accept();
}

void AngleSlider::mouseMoveEvent(QMouseEvent* event)
{
  updateAngle(event->localPos());

  event->accept();
}

void AngleSlider::mouseReleaseEvent(QMouseEvent* event)
{
  event->accept();
}

void AngleSlider::touchEvent(QTouchEvent* event)
{
  if (!event->touchPoints().empty())
    updateAngle(event->touchPoints().first().pos());
  event->accept();
}
}
