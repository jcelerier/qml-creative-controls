#pragma once
#include <QQuickPaintedItem>

class AngleSlider : public QQuickPaintedItem
{
  Q_OBJECT
  Q_PROPERTY(qreal angle READ angle WRITE setAngle NOTIFY angleChanged FINAL)
  Q_PROPERTY(QColor baseColor READ baseColor WRITE setBaseColor NOTIFY baseColorChanged)
  Q_PROPERTY(QColor detailColor READ detailColor WRITE setDetailColor NOTIFY detailColorChanged)

public:
  AngleSlider();

  qreal angle() const;

  QColor baseColor() const;

  QColor detailColor() const;


public slots:
  void setAngle(qreal angle);

  void setBaseColor(QColor baseColor);

  void setDetailColor(QColor detailColor);

signals:
  void angleChanged(qreal angle);

  void baseColorChanged(QColor baseColor);

  void detailColorChanged(QColor detailColor);


private:
  void paint(QPainter* painter) override;
  void mousePressEvent(QMouseEvent* event) override;
  void mouseDoubleClickEvent(QMouseEvent* event) override;
  void mouseMoveEvent(QMouseEvent* event) override;
  void mouseReleaseEvent(QMouseEvent* event) override;

  qreal m_angle{};
  void updateAngle(QPointF point);
  QColor m_baseColor{Qt::blue};
  QColor m_detailColor{Qt::black};
};
