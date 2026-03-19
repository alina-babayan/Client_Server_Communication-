#ifndef UDPCLIENT_H
#define UDPCLIENT_H

#include <QObject>
#include <QUdpSocket>

class UdpClient : public QObject {
    Q_OBJECT
    Q_PROPERTY(QString status READ status NOTIFY statusChanged)

public:
    explicit UdpClient(QObject *parent = nullptr);

    QString status() const;

signals:
    void messageReceived(QString msg);
    void messageSent(QString msg);
    void statusChanged();

public slots:
    void start(quint16 port);
    void sendMessage(QString msg);

private:
    QUdpSocket socket;
    QString m_status;
    quint16 m_port;
};

#endif
