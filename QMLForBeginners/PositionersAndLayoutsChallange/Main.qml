import QtQuick
import QtQuick.Controls.Basic
import QtQuick.Layouts

ApplicationWindow {
    id: window

    width: 800
    height: 480
    visible: true
    title: qsTr("Chat App")

    /* Requirements:

    Design and build the basic elements of a chat
    application - focusing on the task of making the design
    responsive rather than making it actually functional.

    Use QUTE Quick Layouts to design a suitable Desktop Layout for your application.
    Using the Layout attached properties such as
    Layout.fillWidth/fillHeight, Layout.alignment,
    Layout.preferredWidth/preferredHeight,
    and Layout.margins to customise the Layouts.

    There should be sections in your application showing
    - the name of the person who you are chatting with
    - a two-way conversation using static “chat bubbles”
    - a text input for writing a potential reply
    - and a send button

    The chat bubble should contain some text, and be
    positioned on the left or right depending on whose chat
    bubble it is, much like popular messaging apps.
    You should consider how to add an alternating color
    for the chat bubbles.

    */
    font.pixelSize: 20


    RowLayout{
        anchors.fill: parent

        ChatList{
            id: chatList

            Layout.fillWidth: false
            Layout.preferredWidth: 100
            Layout.alignment: Qt.AlignTop
            name: "Bob"
        }

        ColumnLayout{
            id:chatInput
            Text {
                text: qsTr("Chatting with $")
            }
            Rectangle{
                TextInput{
                    text: "My reply"
                }
                color: "gray"
                radius: 5
                Button{
                    text: "Send"
                    background: Rectangle {
                        implicitWidth: 100
                        implicitHeight: 40
                        color: control.down ? "#cccccc" : "#ffffff"
                        border.color: "#333333"
                        radius: 5  // Higher value = more rounded
                    }
                }
            }
        }
        ColumnLayout{
            id:chatMessages
            Rectangle{

            }
        }
    }
}
