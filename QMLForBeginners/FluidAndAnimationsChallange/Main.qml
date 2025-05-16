import QtQuick
import QtQuick.Window
import QtQuick.Controls.Basic
import QtQuick.Layouts
Window {
    id: mainWindow
    width: 1280
    height: 720
    visible: true
    title: qsTr("FluidAnimations")

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
