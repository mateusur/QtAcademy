import QtQuick
import QtQuick.Controls.Basic
import QtQuick.Layouts

ColumnLayout{
    id:root
    spacing: 10

    Repeater{
        model: Backend.chatModel

        Button{
            id: button

            required property int index
            required property string name

            text: name

            checked: index === Backend.currentIndex
            onClicked: Backend.currentIndex = index

            checkable: true
            background : GradBack{
                color: button.checked ? "black" : button.pressed ? "lightgrey" : "grey"
            }
            Layout.fillWidth: true
        }
    }
}
