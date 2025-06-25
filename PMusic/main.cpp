#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include<QQmlContext>
#include"songmodel.h"
int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;
    Songmodel songmodel;
    songmodel.scanDirectory("/root/mp3");
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
