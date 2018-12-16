#ifndef LATEXADAPTER_H
#define LATEXADAPTER_H

#include <QObject>

class latexAdapter : public QObject
{
    Q_OBJECT
public:
    explicit latexAdapter(QObject *parent = nullptr);

signals:

public slots:
};

#endif // LATEXADAPTER_H