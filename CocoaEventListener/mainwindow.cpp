#include "mainwindow.h"
#include "ui_mainwindow.h"

MainWindow::MainWindow(QWidget *parent) :
    QMainWindow(parent),
    ui(new Ui::MainWindow)
{
    ui->setupUi(this);
    QObject::connect(this->ui->widget, SIGNAL(searchRequested(QString)), this, SLOT(updateText(QString)));
    this->updateText(this->ui->widget->text());
}

MainWindow::~MainWindow()
{
    delete ui;
}

void MainWindow::updateText(QString str)
{
    if (!str.isEmpty())
    {
        this->ui->label->setText(tr("You searched for: %1").arg(str));
    }
    else
    {
        this->ui->label->setText(str);
    }
}
