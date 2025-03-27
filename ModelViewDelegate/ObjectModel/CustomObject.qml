import QtQuick

Item {
    id: root

    height: 30
    width: 640

    required property string objColor
    required property int elementNum

    Rectangle{
        id: myRect
        anchors.fill: parent
        color: parent.objColor
        border.width: 2

        MouseArea{
            anchors.fill: parent
            hoverEnabled: true

            onEntered: {
                root.objColor = "lightblue"
            }
            onExited: {
                root.objColor = "lightgreen"
            }
            onPressed:{
                root.objColor = "gray"
            }
            onReleased: {
                root.objColor = "lightcoral"
            }
        }
    }

    Text{
        anchors.centerIn: parent
        text: "Element number: " + root.elementNum
    }
}
