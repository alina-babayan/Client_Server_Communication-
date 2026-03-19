#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include "udpclient.h"

int main(int argc, char *argv[]) {
    QGuiApplication app(argc, argv);

    UdpClient client;

    QQmlApplicationEngine engine;
    engine.rootContext()->setContextProperty("client", &client);

    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));

    return app.exec();
}
