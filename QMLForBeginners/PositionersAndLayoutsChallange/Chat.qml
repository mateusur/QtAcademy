import QtQuick
import QtQuick.Controls.Basic
import QtQuick.Layouts

Pane{
    id:root
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
        RowLayout{
            CheckBox{
                id: meCheckBox
                checked: true

            }
            Button{
                id: sendButton
                Layout.fillWidth: true
                enabled: textArea.text.length >0
                icon {
                    color: "black"
                    width:30
                    height:30
                    source: Qt.resolvedUrl("sendIcon.svg")
                }

                onClicked: {
                    Backend.addReply(meCheckBox.checked, textArea.text)
                    textArea.clear()
                }
            }
        }

    }
}
