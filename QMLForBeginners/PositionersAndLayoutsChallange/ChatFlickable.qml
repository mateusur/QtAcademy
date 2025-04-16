import QtQuick
import QtQuick.Layouts

Flickable{
    id:root
    contentHeight: chatColumnLayout.height
    contentWidth: chatColumnLayout.width

    clip: true

    ColumnLayout{
        id: chatColumnLayout

        width: root.width
        spacing: 10

        Repeater{
            model: Backend.chat
            ChatBubble{
                Layout.alignment: me ? Qt.AlignRight : Qt.AlignLeft
                Layout.maximumWidth: parent.width * 0.75
                Layout.rightMargin: -rightInset
            }
        }
    }
    Binding{
        root.contentY: root.contentHeight - root.height
        when: root.height < root.contentHeight
    }
}
