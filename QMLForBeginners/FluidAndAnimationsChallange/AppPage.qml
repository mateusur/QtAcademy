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
    property Drawer drawerRef

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
                        drawerRef.close()
                    } else {
                        root.windowState = AppPage.OPEN
                        drawerRef.open()
                    }
                }
            }
            ToolButton {
                id: closeButton
                text: qsTr("X")
                onClicked: {
                    dialog.open()
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
    Dialog {
        id: dialog
        title: pageName
        anchors.centerIn: parent
        modal: true

        contentItem: Text {
            text: `Are you sure you want close ${pageName} window?`
            wrapMode: Text.Wrap
            padding: 10
        }

        standardButtons: Dialog.Ok | Dialog.Cancel

        onAccepted:{
            stackViewRef.clear()
        }
        onRejected:{
            dialog.close()
        }

    }

    anchors.horizontalCenter: parent.horizontalCenter
    anchors.top: parent.top
}
