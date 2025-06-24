#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QIcon>
#include<QQmlContext>
#include"songmodel.h"
int main(int argc, char *argv[])
{
#if QT_VERSION < QT_VERSION_CHECK(6, 0, 0)
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
#endif
    QGuiApplication app(argc, argv);

    app.setWindowIcon(QIcon(":/blackImg.png"));

    Songmodel songmodel;
    songmodel.scanDirectory("/root/mp3");
    QQmlApplicationEngine engine;

    engine.rootContext()->setContextProperty("songmodel",&songmodel);
    const QUrl url(QStringLiteral("qrc:/main.qml"));
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);
    engine.load(url);

    return app.exec();
}
