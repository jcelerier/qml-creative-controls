#pragma once
#include <QQuickPaintedItem>

namespace CreativeControls
{
class AngleSlider : public QQuickPaintedItem
{
  Q_OBJECT
  Q_PROPERTY(qreal angle READ angle WRITE setAngle NOTIFY angleChanged FINAL)
  Q_PROPERTY(qreal min READ min WRITE setMin FINAL)
  Q_PROPERTY(qreal max READ max WRITE setMax FINAL)
  Q_PROPERTY(QColor baseColor READ baseColor WRITE setBaseColor NOTIFY baseColorChanged FINAL)
  Q_PROPERTY(QColor detailColor READ detailColor WRITE setDetailColor NOTIFY detailColorChanged FINAL)

public:
  AngleSlider();

  qreal angle() const;
  qreal min() const;
  qreal max() const;
  QColor baseColor() const;
  QColor detailColor() const;

public slots:
  void setAngle(qreal angle);
  void setMin(qreal angle);
  void setMax(qreal angle);
  void setBaseColor(QColor baseColor);
  void setDetailColor(QColor detailColor);

signals:
  void angleChanged(qreal angle);
  void baseColorChanged(QColor baseColor);
  void detailColorChanged(QColor detailColor);

private:
  void paint(QPainter* painter) final override;
  void mousePressEvent(QMouseEvent* event) final override;
  void mouseDoubleClickEvent(QMouseEvent* event) final override;
  void mouseMoveEvent(QMouseEvent* event) final override;
  void mouseReleaseEvent(QMouseEvent* event) final override;
  void touchEvent(QTouchEvent*) final override;

  void updateAngle(QPointF point);

  qreal m_angle{};
  qreal m_min{-180};
  qreal m_max{180};
  QColor m_baseColor{Qt::blue};
  QColor m_detailColor{Qt::black};
};
}
