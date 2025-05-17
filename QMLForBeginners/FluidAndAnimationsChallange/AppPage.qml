pragma ComponentBehavior: Bound
import QtQuick
import QtQuick.Window
import QtQuick.Controls.Basic
import QtQuick.Layouts

Page{
    id: root
    property string pageName
    property color pageColor
    property string pageIcon
    property StackView stackViewRef
    property int windowState
    property int animationDuration: 250

    enum WindowState {
        OPEN,
        MAXIMIZED
    }
    Component.onCompleted: {
        root.windowState = AppPage.OPEN
    }
    title: qsTr(pageName)

    implicitWidth: 400
    implicitHeight: 300

    Rectangle{
        id:delegateRect
        anchors.fill: parent
        color: pageColor
    }
    header: ToolBar{
        RowLayout{
            anchors.fill: parent
            ToolButton {
                icon.source: Qt.resolvedUrl(pageIcon)
            }
            Label {
                text: pageName
                elide: Label.ElideRight
                horizontalAlignment: Qt.AlignHCenter
                verticalAlignment: Qt.AlignVCenter
                Layout.fillWidth: true
            }
            ToolButton {
                id: maximizeMinimizeButton
                text: qsTr("O")
                onClicked: {
                    if(root.windowState === AppPage.OPEN){
                        root.windowState = AppPage.MAXIMIZED
                    } else {
                        root.windowState = AppPage.OPEN
                    }
                }
            }
            ToolButton {
                id: closeButton
                text: qsTr("X")
                onClicked: {
                    stackViewRef.clear()
                }
            }
        }
    }
    states:[
        State {
            name: "open"
            when: root.windowState === AppPage.OPEN
            PropertyChanges {
            }
        },
        State {
            name: "maximized"
            when: root.windowState === AppPage.MAXIMIZED
            PropertyChanges {
                root.width: parent.width
                root.height: parent.height
                maximizeMinimizeButton.text: "o"
                delegateRect.color: Qt.darker(pageColor,1.3)
            }
        }
    ]
    transitions: [
        Transition{
            from: "*"
            to: "*"
            NumberAnimation {
                properties: "width,height"
                duration: root.animationDuration
                easing.type: Easing.InOutCubic
            }
        }
    ]


    anchors.horizontalCenter: parent.horizontalCenter
    anchors.top: parent.top
}
