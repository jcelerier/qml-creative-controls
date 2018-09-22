#pragma once
#include <QQuickPaintedItem>
#include <QPen>

namespace CreativeControls
{
class Scope : public QQuickPaintedItem
{
  Q_OBJECT
  Q_PROPERTY(QVector<qreal> points READ points WRITE setPoints NOTIFY pointsChanged FINAL)
  Q_PROPERTY(qreal yMin READ yMin WRITE setYMin NOTIFY yMinChanged FINAL)
  Q_PROPERTY(qreal yMax READ yMax WRITE setYMax NOTIFY yMaxChanged FINAL)
  Q_PROPERTY(QColor baseColor READ baseColor WRITE setBaseColor NOTIFY baseColorChanged FINAL)
  Q_PROPERTY(QColor detailColor READ detailColor WRITE setDetailColor NOTIFY detailColorChanged FINAL)
  Q_PROPERTY(bool symmetrize READ symmetrize WRITE setSymmetrize NOTIFY symmetrizeChanged FINAL)

public:
  Scope();

  QVector<qreal> points() const;
  qreal yMin() const;
  qreal yMax() const;
  QColor baseColor() const;
  QColor detailColor() const;
  bool symmetrize() const;

public slots:
  void setPoints(QVector<qreal> points);
  void setYMin(const qreal yMin);
  void setYMax(const qreal yMax);
  void setBaseColor(const QColor baseColor);
  void setDetailColor(const QColor detailColor);
  void setSymmetrize(const bool symmetrize);

signals:
  void pointsChanged(QVector<qreal> points);
  void yMinChanged(qreal yMin);
  void yMaxChanged(qreal yMax);
  void baseColorChanged(QColor baseColor);
  void detailColorChanged(QColor detailColor);
  void symmetrizeChanged(bool symmetrize);

private:
  void paint(QPainter* painter) final override;
  void updatePath();

  QVector<qreal> m_points;
  QVector<QPointF> m_data;
  qreal m_yMin{-1};
  qreal m_yMax{1};
  QColor m_baseColor;
  QColor m_detailColor;
  QPen m_scopePen;
  QBrush m_scopeBrush;
  bool m_symmetrize{true};
};
}
