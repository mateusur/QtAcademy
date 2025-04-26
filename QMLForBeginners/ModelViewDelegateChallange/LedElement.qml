import QtQuick

Rectangle {
    id: root
    required property real currentVolume
    required property real threshold

    opacity: currentVolume > threshold ? 1 : 0
    color: Qt.hsla(threshold, 1, 0.5, 1)
    implicitWidth: 20
    implicitHeight: 10

}
