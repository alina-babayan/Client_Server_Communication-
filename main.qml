import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

ApplicationWindow {
    visible: true
    width: 600
    height: 600
    title: "UDP Chat Client"
    color: "#1E1E1E"

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 20
        spacing: 8

        Text {
            text: "UDP CHAT"
            color: "#AAAAAA"
            font.pixelSize: 25
            font.bold: true
        }

        Text {
            text: client.status
            color: "#4ecca3"
            font.pixelSize: 15
        }

        ListView {
            id: chatList
            Layout.fillWidth: true   // FIX: was missing, caused zero width → messages invisible
            Layout.fillHeight: true
            clip: true

            model: ListModel {}

            delegate: Rectangle {
                width: chatList.width  // FIX: use chatList.width, not parent.width (parent is the ListView's contentItem, unreliable)
                height: msgText.implicitHeight + 16  // FIX: dynamic height instead of fixed 42
                radius: 6
                color: model.bg

                Text {
                    id: msgText
                    text: model.text
                    color: model.color
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.left: model.alignRight ? undefined : parent.left
                    anchors.right: model.alignRight ? parent.right : undefined
                    anchors.margins: 10
                    width: parent.width - 20
                    wrapMode: Text.Wrap
                }
            }
        }

        RowLayout {
            spacing: 8

            TextField {
                id: inputField
                placeholderText: "Type a message..."
                Layout.fillWidth: true

                background: Rectangle {
                    color: "#AAAAAA"
                    radius: 8
                    border.color: inputField.activeFocus ? "#AAAAAA" : "#1E1E1E"
                }

                onAccepted: sendBtn.clicked()
            }

            Button {
                id: sendBtn
                text: "Send"

                background: Rectangle {
                    color: "#AAAAAA"
                    radius: 8
                }

                contentItem: Text {
                    text: "Send"
                    color: "white"
                    font.bold: true
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                }

                onClicked: {
                    if (inputField.text.trim() !== "") {
                        client.sendMessage(inputField.text)
                        inputField.clear()
                    }
                }
            }
        }
    }

    Component.onCompleted: {
        client.start(12345)
    }

    Connections {
        target: client

        function now() {
            return Qt.formatTime(new Date(), "hh:mm")
        }

        function onMessageReceived(msg) {
            chatList.model.append({
                text: "[" + now() + "] " + msg,
                color: "#d0d0f0",
                bg: "#16213e",
                alignRight: false
            })
            chatList.positionViewAtEnd()
        }

        function onMessageSent(msg) {
            chatList.model.append({
                text: "You [" + now() + "] " + msg,
                color: "#4ecca3",
                bg: "#0f2a1e",
                alignRight: true
            })
            chatList.positionViewAtEnd()
        }
    }
}
