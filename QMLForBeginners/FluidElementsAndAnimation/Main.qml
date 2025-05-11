import QtQuick
import QtQuick.Controls
import QtQuick.Controls.Basic

ApplicationWindow {
    id: window
    visible: true
    width: 800
    height: 600
    title: "PathAnimation"

    property int pulse: 60
    property real speed: 3000 / (pulse / 60)

    Rectangle {
        id: root
        anchors.verticalCenter: parent.verticalCenter
        width: parent.width - heart.width
        height: 200
        color: "black"

        Path {
            id: path
            startX:0
            startY: root.height

            PathLine { x: root.width * 0.125; y: root.height / 2 }
            PathLine { x: root.width * 0.1875; y: root.height / 4 }
            PathLine { x: root.width * 0.25; y: root.height * 3 / 4 }
            PathLine { x: root.width * 0.3125; y: root.height / 2 }
            PathLine { x: root.width * 0.375; y: root.height / 2 }
            PathLine { x: root.width * 0.4375; y: root.height / 4 }
            PathLine { x: root.width * 0.5; y: root.height * 3 / 4 }
            PathLine { x: root.width * 0.5625; y: root.height / 2 }
            PathLine { x: root.width * (0.5+0.125); y: root.height / 2 }
            PathLine { x: root.width * (0.5+0.1875); y: root.height / 4 }
            PathLine { x: root.width * (0.5+0.25); y: root.height * 3 / 4 }
            PathLine { x: root.width * (0.5+0.3125); y: root.height / 2 }
            PathLine { x: root.width * (0.5+0.375); y: root.height / 2 }
            PathLine { x: root.width * (0.5+0.4375); y: root.height / 4 }
            PathLine { x: root.width * (0.5+0.5); y: root.height /2 }

        }
        Rectangle {
            id: pulseLine
            width: 10
            height: 10
            radius: 5
            color: "blue"

            PathAnimation {
                id: pathAnimation
                target: pulseLine
                path: path
                duration: window.speed
                loops: Animation.Infinite
                easing.type: Easing.Linear
                running: true
            }
        }
        Repeater {
            id: rep
            model: 20

            Rectangle {
                id: shadowLine
                // required property int index
                required property int modelData
                property var shadowPath: path
                property int delay: 20
                width: 10
                height: 10
                radius: 5
                color: "yellow"
                opacity: 1.0 - (index / rep.model)
                visible: true
                Component.onCompleted: animation.start()

                SequentialAnimation {
                    id:animation
                    loops: Animation.Infinite

                    PauseAnimation {
                        duration: shadowLine.delay * index
                    }
                    PathAnimation {
                        target: shadowLine
                        path: shadowLine.shadowPath
                        duration: root.speed - (shadowLine.delay * index)
                        easing.type: Easing.Linear
                  }
                    running: true
              }
           }
        }
        Item {
            id: heartArea
            width: 100
            height: root.height
            anchors.left: root.right
            anchors.leftMargin: -heart.width * .5

            Image {
                id: heart
                anchors.centerIn: parent
                width: 100
                height: 100
                source: "assets/heart.svg"

                Behavior on scale {
                    NumberAnimation {
                        duration: 20
                    }
                }
            }
            Timer {
                id: animationTimer
                interval: 16
                running: true
                repeat: true
                onTriggered: {
                    var heartScale = 1 + (root.height / 2 - pulseLine.y)
                                         / (root.height / 4)
                    heart.scale = Math.max(0.5, heartScale)
                }
            }
        }
    }
}
