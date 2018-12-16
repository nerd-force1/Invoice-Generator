#ifndef MAINWINDOW_H
#define MAINWINDOW_H

#include <QMainWindow>
#include "slothandler.h"
#include"emboinvoicedata.h"
#include<QDir>

namespace Ui {
class MainWindow;
}

class MainWindow : public QMainWindow
{
    Q_OBJECT

public:


    explicit MainWindow(QWidget *parent = nullptr);
    ~MainWindow();


private:
    Ui::MainWindow *ui;

    emBO::items_t positions{};
    emBO::emBOInvoiceData data{};

    void collectRecipientData();
    void getInvoiceNumber();
    void collectPositions();
    std::string makeStringFromData();
    void writeInvoiceFile(std::string);

public slots:
    void generateClicked();
    void addPositionClicked();
};

#endif // MAINWINDOW_H
