#include <QtGui/QApplication>
#include "mainwindow.h"
#import <Cocoa/Cocoa.h>

int main(int argc, char *argv[])
{
    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
    QApplication a(argc, argv);
    MainWindow w;
    w.show();

    int code = a.exec();
    [pool drain];
    return code;
}
