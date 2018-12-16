#include "latexadapter.h"
#include <cstdlib>
#include <fstream>
#include <iostream>
#include"emboinvoicedata.h"

latexAdapter::latexAdapter(QObject *parent) : QObject(parent)
{
}

void latexAdapter::buildInvoice(emBO::emBOInvoiceData & data){


    std::system("cd %userprofile% & "
                "mkdir nf1-Invoices & "
                "cd nf1-Invoices &"
                "mkdir 1");




}
