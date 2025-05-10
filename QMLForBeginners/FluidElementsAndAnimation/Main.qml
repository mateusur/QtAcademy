import QtQuick
import QtQuick.Controls

ApplicationWindow {
    id: root
    visible: true
    width: 800
    height: 600
    title: "Behavior Animation Example"

    Rectangle {
        id: sky
        width: root.width
        height: 20
        color: "lightblue"
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top
    }
    Rectangle {
        id: trampoline
        width: root.width
        height: 100
        color: "green"
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: parent.bottom
    }
    Rectangle {
        id: ball
        width: 50
        height: width
        radius: width / 2
        color: "red"
        anchors.horizontalCenter: parent.horizontalCenter
        y: trampoline.y - height

        Behavior on y {
            SpringAnimation { id: behaviorAnimation; spring: 3; damping: 0.2 }
        }
        MouseArea {
            anchors.fill: parent
            onClicked: {
                if (ball.y === 20) {
                    ball.y = trampoline.y - ball.height;
                }
                else {
                    ball.y = 20;
                }
            }
        }
        Text {
            anchors.centerIn: parent
            text: "Click me"
            font.pixelSize: 25
            color: "white"
            visible: !behaviorAnimation.running
        }
    }

}
