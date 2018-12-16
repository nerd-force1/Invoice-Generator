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
    void generateClicked();
    void addPositionsClicked();
};

#endif // SLOTHANDLER_H
