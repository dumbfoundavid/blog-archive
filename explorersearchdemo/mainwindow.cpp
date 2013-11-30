#include "mainwindow.h"
#include "ui_mainwindow.h"
#include "searchlineedit.h"

MainWindow::MainWindow(QWidget *parent) :
    QMainWindow(parent),
    ui(new Ui::MainWindow)
{
    ui->setupUi(this);

    QWidget *spacer = new QWidget(this);
    spacer->setSizePolicy(QSizePolicy::Expanding, QSizePolicy::Fixed);
    this->ui->mainToolBar->addWidget(spacer);

    SearchLineEdit *search = new SearchLineEdit(this);
    this->ui->mainToolBar->addWidget(search);
}

MainWindow::~MainWindow()
{
    delete ui;
}
