import QtQuick
import QtQuick.Controls.Basic
import QtQuick.Layouts

RowLayout{

    property string name
    property real cost: 0
    readonly property real value: foodCounter.value * cost
    Label {
        id: dishNamelabel
        text: `${parent.name}: $${parent.cost}`
        Layout.fillWidth: true
    }
    SpinBox{
        id: foodCounter
        value: 0
    }
}
