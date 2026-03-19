# UDP Chat Client (Qt + QML)

This project is a simple real-time chat application built using Qt (C++) and QML. It uses UDP (User Datagram Protocol) for communication and works within a local network without requiring a server.

---

## Overview

The application allows multiple clients on the same network to exchange messages in real time. It uses UDP broadcast to send messages to all connected clients.

---

## Technologies

* Qt (C++)
* Qt Quick (QML)
* QUdpSocket

---

## How It Works

UDP is a connectionless protocol, meaning there is no persistent connection between clients. Messages are sent as datagrams and may not be delivered or ordered reliably.

Each client:

* Binds to a specific port (e.g., 12345)
* Sends messages to the broadcast address
* Listens for incoming datagrams from other clients

---

## Project Structure

```
UdpClient/
 ├── main.cpp
 ├── udpclient.h
 ├── udpclient.cpp
 ├── main.qml
 └── README.md
```

---

## Core Class: UdpClient

The `UdpClient` class handles all networking operations.

### Methods

Start listening on a port:

```cpp
void start(quint16 port);
```

Send a message:

```cpp
void sendMessage(QString msg);
```

### Signals

* `messageReceived(QString msg)`
* `messageSent(QString msg)`
* `statusChanged()`

---

## Message Flow

### Sending

1. User enters text in the UI
2. QML calls `client.sendMessage()`
3. The message is broadcast using `QUdpSocket`
4. The UI updates via `messageSent` signal

### Receiving

1. The socket receives a datagram
2. `readyRead` signal is triggered
3. Message is read and emitted via `messageReceived`
4. The UI displays the message

---

## User Interface

The UI is built using QML and includes:

* Message list (ListView)
* Input field (TextField)
* Send button (Button)
* Status display

Messages are aligned differently depending on whether they are sent or received.

---

## How to Run

1. Build the project using Qt Creator
2. Run multiple instances of the application
3. Ensure all instances are on the same network
4. Start sending messages

---

## Limitations

* No guaranteed message delivery
* No ordering of messages
* Messages may be lost
* Works only within local network
* No user identification system

---

## Possible Improvements

* Add usernames
* Allow sending to specific IP instead of broadcast
* Implement message acknowledgment system
* Improve UI with message bubbles
* Store message history

---

## Conclusion

This project demonstrates basic UDP networking in Qt and integration between C++ backend and QML UI. It provides a simple and lightweight solution for local network chat applications.
