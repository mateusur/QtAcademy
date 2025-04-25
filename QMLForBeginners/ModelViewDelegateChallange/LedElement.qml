import QtQuick

Rectangle {
    id: root
    required property int currentVolume
    required property int treshold
    required property color ledColor

    visible: currentVolume > treshold
    color: ledColor

}
