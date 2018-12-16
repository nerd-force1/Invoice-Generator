#include "mainwindow.h"
#include "ui_mainwindow.h"
#include "latexadapter.h"
#include<chrono>

MainWindow::MainWindow(QWidget *parent) :
    QMainWindow(parent),
    ui(new Ui::MainWindow)
{
    ui->setupUi(this);

    connect(ui->generateButton,SIGNAL(clicked()),this,SLOT(generateClicked()));
    connect(ui->addPositionButton,SIGNAL(clicked()),this,SLOT(addPositionClicked()));




}

MainWindow::~MainWindow()
{
    delete ui;
}

void MainWindow::collectRecipientData(){
    this->data.recipient.company            =(ui->companyLineEdit->text()).toLocal8Bit().constData();
    this->data.recipient.name               =(ui->nameLineEdit->text()).toLocal8Bit().constData();
    this->data.recipient.address            =(ui->addressLineEdit->text()).toLocal8Bit().constData();
    this->data.recipient.addressAdditional  =(ui->additionalLineEdit->text()).toLocal8Bit().constData();
    this->data.recipient.postal             =(ui->postalLineEdit->text()).toLocal8Bit().constData();
    this->data.recipient.city               =(ui->postalLineEdit->text()).toLocal8Bit().constData();
    this->data.recipient.country            =(ui->countryLineEdit->text()).toLocal8Bit().constData();

}

void MainWindow::getInvoiceNumber(){
    this->data.invoiceNumber                =(ui->countryLineEdit->text()).toLong();
    this->data.invoiceTime                  =std::chrono::system_clock::now();
}

void MainWindow::collectPositions(){
    this->data.positions                    =this->positions;
}

std::string MainWindow::makeStringFromData(){
    std::string returnString{};

    return returnString;
}



void MainWindow::generateClicked(){

}
void MainWindow::addPositionClicked(){

}
