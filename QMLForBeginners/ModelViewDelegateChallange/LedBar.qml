import QtQuick
import QtQuick.Layouts

ColumnLayout {
    id: root

    property int ledNumber: 50
    required property real currentVolume
    width: 20
    height: 100
    Repeater{
        model: root.ledNumber
        LedElement{
            required property int index
            Layout.fillHeight: true
            Layout.fillWidth: true
            threshold: 1 - index/root.ledNumber
            currentVolume: root.currentVolume
        }
    }
    
}
