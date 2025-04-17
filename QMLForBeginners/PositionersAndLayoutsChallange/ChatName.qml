import QtQuick
import QtQuick.Controls.Basic

Pane {
    id:root
    padding: 10
    background: GradBack{
        color: "grey"
    }

    Label{
        text: `Chatting with ${Backend.chattingWith}`
        anchors.centerIn: parent
    }
}
