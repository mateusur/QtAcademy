import QtQuick
import QtQuick.Controls.Basic
import QtQuick.Layouts

ColumnLayout{
    id:root

    required property string name

    Repeater{
        model: 6
        Button{
            id: button
            text: root.name
            checkable: true
            background : Rectangle{
                color: button.checked ? "black" : button.pressed ? "lightgrey" : "grey"
            }
            Layout.fillWidth: true
        }
    }
}
