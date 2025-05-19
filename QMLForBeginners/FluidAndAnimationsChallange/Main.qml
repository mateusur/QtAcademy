import QtQuick
import QtQuick.Window
import QtQuick.Controls
import QtQuick.Controls.Basic
import QtQuick.Layouts
ApplicationWindow {
    id: mainWindow
    width: 1280
    height: 720
    visible: true
    title: qsTr("FluidAnimations")

    Image {
        id:backgroundImage
        fillMode: Image.PreserveAspectCrop
        source: "assets/wallpaper.jpg"
        z:-1
    }

    StackView {
        id: stackView
        anchors.fill: parent
    }

    Drawer{
        id: drawer
        width: mainWindow.width
        height: 120
        edge: Qt.BottomEdge
        dragMargin: 20
        closePolicy: Popup.NoAutoClose
        modal: false
        Component.onCompleted: open()

        ListView {
            id: listView
            width: 450; height: 100
            spacing: 20
            anchors{
                horizontalCenter: parent.horizontalCenter
                bottom: parent.bottom
            }
            orientation: ListView.Horizontal
            Component {
                id: contactsDelegate
                Rectangle{
                    id:delegateRect
                    width: 50
                    height: 70
                    color: "transparent"
                    Rectangle{
                        id: backgroundRect
                        anchors.bottom: parent.bottom
                        width: delegateRect.width
                        height: width
                        radius: 7
                        color: appColor
                        Image {
                            id: backgroundImage
                            source: Qt.resolvedUrl(appIcon)
                            anchors.centerIn: parent
                            fillMode: Image.PreserveAspectFit
                            width: backgroundRect.width
                            height: width
                        }
                    }
                    Label{
                        anchors.top: parent.top
                        anchors.horizontalCenter: parent.horizontalCenter
                        color: "black"
                        text: appName
                    }
                    MouseArea{
                        anchors.fill: parent
                        hoverEnabled: true
                        onEntered: {
                            scaleDown.stop()
                            scaleUp.restart()
                        }
                        onExited: {
                            scaleUp.stop()
                            scaleDown.restart()
                        }
                        onClicked: {
                            const component = Qt.createComponent("AppPage.qml");
                            if(component.status ===Component.Ready){
                                const page = component.createObject(stackView,{
                                                                        pageName: appName,
                                                                        pageColor: appColor,
                                                                        pageIcon: appIcon,
                                                                        width: mainWindow.width-100,
                                                                        height: mainWindow.height-150,
                                                                        stackViewRef: stackView,
                                                                        drawerRef: drawer
                                                                    });
                                if(page){
                                    stackView.clear();
                                    stackView.push(page);
                                }else {
                                    console.log("Failed to create page")
                                }
                            } else {
                                console.log("Failed to create AppPage");
                            }
                        }
                    }

                    PropertyAnimation {
                        id:scaleUp
                        target: delegateRect
                        property: "scale"
                        from: 1.0
                        to: 1.5
                        duration: 250
                    }

                    PropertyAnimation {
                        id:scaleDown
                        target: delegateRect
                        property: "scale"
                        from: 1.5
                        to: 1.0
                        duration: 100
                    }
                }
            }

            model: AppModel {}
            delegate: contactsDelegate
            focus: true
        }
    }
}
