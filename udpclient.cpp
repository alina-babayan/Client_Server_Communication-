#include "udpclient.h"
#include <QHostAddress>

UdpClient::UdpClient(QObject *parent) : QObject(parent), m_port(12345) {

    connect(&socket, &QUdpSocket::readyRead, this, [=]() {
        while (socket.hasPendingDatagrams()) {
            QByteArray data;
            data.resize(socket.pendingDatagramSize());

            QHostAddress sender;
            quint16 senderPort;

            socket.readDatagram(data.data(), data.size(), &sender, &senderPort);

            QString msg = QString::fromUtf8(data).trimmed();
            emit messageReceived("[" + sender.toString() + "] " + msg);
        }
    });
}

QString UdpClient::status() const {
    return m_status;
}

void UdpClient::start(quint16 port) {
    m_port = port;

    if (socket.bind(QHostAddress::AnyIPv4, port,
                    QUdpSocket::ShareAddress | QUdpSocket::ReuseAddressHint)) {
        m_status = "UDP listening on port " + QString::number(port);
    } else {
        m_status = "Bind failed!";
    }

    emit statusChanged();
}

void UdpClient::sendMessage(QString msg) {
    if (msg.trimmed().isEmpty())
        return;

    QByteArray data = msg.toUtf8();

    socket.writeDatagram(data, QHostAddress::Broadcast, m_port);

    emit messageSent(msg);
}
