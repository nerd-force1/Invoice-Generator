#ifndef LATEXADAPTER_H
#define LATEXADAPTER_H

#include <QObject>
#include <QStringList>
#include <QProcess>
#include <string>
#include"emboinvoicedata.h"


class latexAdapter : public QObject
{
    Q_OBJECT
public:
    explicit latexAdapter(QObject *parent = nullptr);

    void buildInvoice(emBO::emBOInvoiceData&);
private:

    std::string formatInvoiceData(emBO::emBOInvoiceData);
    void writeTexInputfile(std::string formattedInvoiceData);
    void callXelatex(std::string outputName);


signals:

public slots:

};

#endif // LATEXADAPTER_H
