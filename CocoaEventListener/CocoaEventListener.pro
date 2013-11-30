!macx:error("This example project can only be compiled and run on Mac OS X")

QT += core gui

TARGET = CocoaEventListener
TEMPLATE = app

SOURCES += mainwindow.cpp main.mm
OBJECTIVE_SOURCES += cocoaeventlistener.mm icocoaeventreceiver.mm machelpers.mm mactoolbarsearchwidget.mm
HEADERS += mainwindow.h cocoaeventlistener.h icocoaeventreceiver.h machelpers.h mactoolbarsearchwidget.h
FORMS += mainwindow.ui
LIBS += -framework Cocoa
