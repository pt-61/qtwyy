#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <QIcon>
#include "songmodel.h"
int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    app.setWindowIcon(QIcon(":/Src/image/logo.png"));

    QQmlApplicationEngine engine;
    Songmodel songmodel;
    //songmodel.scanDirectory(":/mp3/mp3.1");

    Songmodel songmodel1;
    songmodel1.scanDirectory(":/mp3/mp3.3");
    engine.rootContext()->setContextProperty("songmodel1",&songmodel1);
    engine.rootContext()->setContextProperty("songmodel",&songmodel);
    QObject::connect(
        &engine,
        &QQmlApplicationEngine::objectCreationFailed,
        &app,
        []() { QCoreApplication::exit(-1); },
        Qt::QueuedConnection);
    engine.loadFromModule("PMusic", "Main");

    return app.exec();
}
