#include "angleslider.hpp"
#include <QPainter>
#include <complex>
#include <QtMath>

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
  auto borderWidth = (rect.width() / 2) * 1./15.;
  const auto radius = rect.width() / 2. - borderWidth / 2. - 1;
  QPen p;
  p.setWidth(borderWidth);
  p.setColor(m_detailColor);

  painter->setPen(p);
  painter->setBrush(m_baseColor);
  painter->drawEllipse(rect.center(), radius, radius);

  std::complex<double> pt = std::polar(radius - 2, angle() * deg_to_rad);

  const auto cx = rect.center().x();
  const auto cy = rect.center().y();
  painter->setBrush(m_detailColor);
  painter->drawLine(rect.center(), QPointF{pt.real() + cx, pt.imag() + cy});
  painter->drawEllipse(rect.center(), radius / 20., radius / 20.);

  p.setWidth(borderWidth * 0.75);
  painter->setPen(p);
  painter->drawLine(cx + radius - 0.1 * radius, cy, cx + radius, cy);
}

qreal AngleSlider::angle() const
{
  return m_angle;
}

QColor AngleSlider::baseColor() const
{
  return m_baseColor;
}

QColor AngleSlider::detailColor() const
{
  return m_detailColor;
}

void AngleSlider::setAngle(qreal angle)
{
  if (m_angle == angle)
    return;

  m_angle = angle;
  emit angleChanged(angle);
  update();
}

void AngleSlider::setBaseColor(QColor baseColor)
{
  if (m_baseColor == baseColor)
    return;

  m_baseColor = baseColor;
  emit baseColorChanged(baseColor);
  update();
}

void AngleSlider::setDetailColor(QColor detailColor)
{
  if (m_detailColor == detailColor)
    return;

  m_detailColor = detailColor;
  emit detailColorChanged(detailColor);
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
