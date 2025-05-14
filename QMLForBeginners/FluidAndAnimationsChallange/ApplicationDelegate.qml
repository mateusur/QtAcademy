import QtQuick
import QtQuick.Controls.Basic

Rectangle{
    id:root
    width: 200
    height: 200
    color: "red"

    Image {
        id: backgroundImage
        source: Qt.resolvedUrl(appIcon)
        fillMode: Image.PreserveAspectFit
        width: root.width
        height: root.height

    }
    Label{
        anchors.fill: parent
        text: appName
    }

}
