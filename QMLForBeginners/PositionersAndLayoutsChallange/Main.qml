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
    readonly property int mobileBreakPoint: 500
    readonly property bool isMobileLayout: window.width <= mobileBreakPoint
    readonly property bool isDesktopLayout: window.width > mobileBreakPoint

    font.pixelSize: 20
    background: GradBack{
        color: Qt.alpha(Backend.theirColor,0.25)
    }

    ChatList{
        id: chatList
    }

    ChatName{
        id:chatName
    }

    Chat{
        id:mainChatWindow
    }

    ChatFlickable{
        id: chatFlickable
    }


    RowLayout{
        visible: window.isDesktopLayout
        anchors.fill: parent

        LayoutItemProxy{
            target: chatList

            Layout.fillWidth: false
            Layout.preferredWidth: 100
            Layout.alignment: Qt.AlignTop
        }

        ColumnLayout{
            id:chat
            spacing: 10
            Layout.fillWidth: false
            Layout.preferredWidth: 300

            LayoutItemProxy{
                target:chatName
                Layout.fillWidth: true
            }

            LayoutItemProxy{
                target:mainChatWindow
                Layout.fillHeight: true
                Layout.fillWidth: true
            }
        }
        LayoutItemProxy{
            target: chatFlickable

            Layout.fillHeight: true
            Layout.fillWidth: true
        }
    }


    ColumnLayout{
        //Mobile layout
        visible: window.isMobileLayout
        anchors.fill: parent
        TabBar {
            id: tabBar
            Layout.fillWidth: true
            currentIndex: Backend.currentIndex
            onCurrentIndexChanged: Backend.currentIndex = currentIndex
            Repeater{
                model: Backend.chatModel
                TabButton {
                    required property string name
                    text: name
                }
            }
        }
        StackLayout{
            id: stackLayout
            currentIndex: tabBar.currentIndex
            Layout.fillHeight: true
            Layout.fillWidth: true
            Repeater{
                model: Backend.chatModel
                ColumnLayout{
                    ColumnLayout{
                        spacing: 10

                        LayoutItemProxy{
                            target:chatName
                            Layout.fillWidth: true
                        }

                        LayoutItemProxy{
                            target: mainChatWindow
                            Layout.fillWidth: true
                        }
                    }
                    LayoutItemProxy{
                        target: chatFlickable

                        Layout.fillHeight: true
                        Layout.fillWidth: true
                    }
                }
            }
        }
    }
}
