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
    property int windowState: AppPage.CLOSED



    enum WindowState {
        CLOSED,
        OPEN,
        MAXIMIZED
    }
    Component.onCompleted: {
        root.windowState = AppPage.OPEN
    }
    title: qsTr(pageName)

    width: 400
    height: 300
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
                text: qsTr("O")
                onClicked: {
                   root.windowState = AppPage.MAXIMIZED
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
                closeButton.text: "Y"
            }
        },
        State {
            name: "maximized"
            when: root.windowState === AppPage.MAXIMIZED
            PropertyChanges {
                root.anchors.fill: parent
            }
        }
    ]
    anchors.horizontalCenter: parent.horizontalCenter
    anchors.top: parent.top
}
