import QtQuick
import QtQuick.Controls

ApplicationWindow {
    id: rootWindow
    width: 640
    height: 480
    title: "Easing Types Example"
    visible: true

    Column {
        anchors.fill: parent
        spacing: 20

        Rectangle {
            id: red
            width: 100; height: 50; color: "red"
            Text {
                text: "InOutQuad"
                anchors.centerIn: red
            }
        }

        Rectangle {
            id: blue
            width: 100; height: 50; color: "blue"
            Text {
                text: "OutBounce"
                anchors.centerIn: blue
            }
        }

        Rectangle {
            id: green
            width: 100; height: 50; color: "green"
            Text {
                text: "InElastic"
                anchors.centerIn: green
            }
        }
    }

    PropertyAnimation {
        target: red
        property: "x"
        from: 0
        to: rootWindow.width - red.width
        running: true
        easing.type: Easing.InOutQuad
        loops: Animation.Infinite
        duration: 4000
    }
    PropertyAnimation {
        target: blue
        property: "x"
        from: 0
        to: rootWindow.width - blue.width
        running: true
        easing.type: Easing.OutBounce
        duration: 4000
        loops: Animation.Infinite
    }
    PropertyAnimation {
        target: green
        property: "x"
        from: 0
        to: rootWindow.width - green.width
        running: true
        easing.type: Easing.InElastic
        duration: 4000
        loops: Animation.Infinite
    }

}
