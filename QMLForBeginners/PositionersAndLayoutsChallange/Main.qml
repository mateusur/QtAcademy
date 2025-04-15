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
        }

        ColumnLayout{
            id:chatInput
            Pane {
                padding: 10
                Label{
                    text: `Chatting with ${Backend.chattingWith}`
                    anchors.centerIn: parent
                }
            }
            Pane{
                ColumnLayout{
                    anchors.fill: parent
                    spacing: 10
                    TextArea{
                        id:textArea

                        Layout.fillHeight: true
                        Layout.fillWidth: true
                        background: Rectangle {
                            color: "white"

                        }
                        placeholderText: meCheckBox.checked? "My reply" : "Their reply"
                    }
                    CheckBox{
                        id: meCheckBox
                        checked: true

                    }
                    Button{
                        id: sendButton
                        Layout.fillWidth: true
                        enabled: textArea.text.length >0

                        onClicked: {
                            Backend.addReply(meCheckBox.checked, textArea.text)
                            textArea.clear()
                        }
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
