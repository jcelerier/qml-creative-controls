#include "scope.hpp"
#include <QPainter>
#include <cmath>

Scope::Scope()
{
  setAntialiasing(true);
  setFlag(ItemHasContents, true);
  connect(this, &Scope::heightChanged, this, &Scope::updatePath);
  connect(this, &Scope::widthChanged, this, &Scope::updatePath);

  m_scopePen.setCapStyle(Qt::RoundCap);
  m_scopePen.setJoinStyle(Qt::RoundJoin);
  m_scopePen.setWidth(3);
  m_scopeBrush.setStyle(Qt::SolidPattern);
}

void Scope::paint(QPainter* painter)
{
  painter->setRenderHint(QPainter::Antialiasing);
  painter->setRenderHint(QPainter::HighQualityAntialiasing);
  painter->setRenderHint(QPainter::SmoothPixmapTransform);
  painter->setBrush(m_scopeBrush);
  painter->setPen(m_scopePen);
  if(m_symmetrize)
  {
    painter->drawPolygon(m_data);
  }
  else
  {
    painter->drawLines(m_data);
  }

}

QVector<qreal> Scope::points() const
{
  return m_points;
}

qreal Scope::yMin() const
{
  return m_yMin;
}

qreal Scope::yMax() const
{
  return m_yMax;
}

QColor Scope::baseColor() const
{
  return m_baseColor;
}

QColor Scope::detailColor() const
{
  return m_detailColor;
}

bool Scope::symmetrize() const
{
  return m_symmetrize;
}

void Scope::setPoints(QVector<qreal> points)
{
  if (m_points == points)
    return;

  m_points = points;
  emit pointsChanged(points);
  updatePath();
}

void Scope::setYMin(qreal yMin)
{
  if (m_yMin == yMin)
    return;

  m_yMin = yMin;
  emit yMinChanged(yMin);
  updatePath();
}

void Scope::setYMax(qreal yMax)
{
  if (m_yMax == yMax)
    return;

  m_yMax = yMax;
  emit yMaxChanged(yMax);
  updatePath();
}

void Scope::setBaseColor(QColor baseColor)
{
  if (m_baseColor == baseColor)
    return;

  m_baseColor = baseColor;
  m_scopeBrush.setColor(m_baseColor);
  emit baseColorChanged(baseColor);
  update();
}

void Scope::setDetailColor(QColor detailColor)
{
  if (m_detailColor == detailColor)
    return;

  m_detailColor = detailColor;
  m_scopePen.setColor(m_detailColor);
  emit detailColorChanged(detailColor);
  update();
}

void Scope::setSymmetrize(bool symmetrize)
{
  if (m_symmetrize == symmetrize)
    return;

  m_symmetrize = symmetrize;
  emit symmetrizeChanged(symmetrize);
  updatePath();
}


auto ease(double x, double min, double max)
{
  return min + x * (max - min);
}

void Scope::updatePath()
{
  if(!m_symmetrize)
  {
    // y = yMin -> height
    // y = yMax -> 0
    const auto y0 = yMin();
    const auto y1 = yMax();
    const auto h0 = height();
    const auto h1 = 0;
    const auto coeff = (h1 - h0) / (y1 - y0);
    auto scale = [=] (auto val) { return h0 + coeff * (val - y0); };

    m_data.resize(2 * m_points.size());
    if(m_points.size() > 0)
    {
      const auto inc = width() / m_points.size();

      auto it = m_points.cbegin();
      auto x = 0;
      QPointF start{x, scale(*it)};
      int i = 0;
      for(; it != m_points.cend(); ++it)
      {
        m_data[i] = start;
        ++i;
        x += inc;
        m_data[i] = {x, scale(*it)};
        start = m_data[i];
        ++i;
      }
    }
  }
  else
  {

    // yMin is not used, we assume it's zero
    // y = yMax -> 0 for the upper part, height for the lower part

    const auto h = height();
    const auto y0 = 0.;
    const auto y1 = yMax();
    const auto h0 = height() / 2.;
    const auto h1 = 0.;
    const auto coeff = (h1 - h0) / (y1 - y0);
    auto scale = [=] (auto val) { return h0 + coeff * (std::fabs(val) - y0); };

    m_data.resize(2 * m_points.size());

    if(m_points.size() > 0.)
    {
      const auto inc = width() / (m_points.size() - 1);
      auto x = 0.;

      // Draw the upper part
      const auto Npts = m_points.size();
      for(int i = 0; i < Npts; i++)
      {
        m_data[i] = {x, scale(m_points[i])};
        x += inc;
      }

      // Symmetrize
      for(int i = 0; i < Npts; i++)
      {
        const auto top_pt = m_data[Npts - i - 1];
        m_data[Npts + i] = {top_pt.x(), (h - top_pt.y())};
      }
    }
  }

  update();
}
