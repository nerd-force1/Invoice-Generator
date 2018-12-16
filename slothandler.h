#ifndef SLOTHANDLER_H
#define SLOTHANDLER_H

#include <QObject>

class slotHandler : public QObject
{
    Q_OBJECT
public:
    explicit slotHandler(QObject *parent = nullptr);

signals:

public slots:
};

#endif // SLOTHANDLER_H