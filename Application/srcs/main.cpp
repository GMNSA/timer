#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include "stopwatch.hpp"
#include "timer.hpp"

int main(int argc, char *argv[])
{
#if QT_VERSION < QT_VERSION_CHECK(6, 0, 0)
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
#endif

    QGuiApplication app(argc, argv);

    StopWatch stopWatch;
    Timer timer;

    QQmlApplicationEngine engine;
    engine.addImportPath(":/qml");

    // StopWatch::registerMe("cus.stopWatch");
    qmlRegisterType<StopWatch>("cus.stopWatch", 1, 0, "ModuleStopWatch");
    qmlRegisterType<Timer>("cus.timer", 1, 0, "ModuleTimer");

    const QUrl url(QStringLiteral("qrc:/main.qml"));
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);
    engine.load(url);

    return app.exec();
}
