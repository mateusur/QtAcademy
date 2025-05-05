import QtQuick
import QtQuick.Layouts
import QtQuick.Controls

Window {
    id: window
    width: 640
    height: 480
    visible: true
    title: qsTr("ModelViewDelegate")

    /*

    The requirements for this challenge can be broken down into
    three steps:

    1) First make a suitable LED-style element, quite small,
    that needs to be the individual visual unit in the LED bar.
    Each LED should define its own level threshold above which
    it turns on and below which it turns off.

    2) Next, make the LED bar. Decide the bar's orientation and
    how many LEDs you want in your bar. Arrange the LEDs to fill
    the bar. The LED bar should define the level for the whole
    bar, so that each of the LEDs in the bar can decide if that
    level passes their individual thresholds or not.
    You should consider this the first time you need a model,
    a delegate and a View or a Repeater with a Layout.

    3) Finally, complete the graphic equaliser display that shows
    multiple bars, each with their own level. Define a model that
    contains level data at each index which should generate some
    random level data at a given interval. Choose a suitable View
    to create LED Bar delegates and ensure that each delegate
    reads its respective frequency level out of the model.

    */
    color: "black"
    FrequencyVolumeGenerator {
        id: frequencyVolumeGenerator
        frequencyBands: sliderNumOfFreqBands.value
    }
    Rectangle{
        id: meanVolume
        color: "grey"
        width: window.width
        implicitHeight: 7
        y: equlizer.height - (equlizer.height * frequencyVolumeGenerator.meanVolume)
        z:1
    }
    ColumnLayout{
        anchors.fill: parent
        RowLayout{
            Layout.fillWidth: true
            Label{
                text: "Number of LEDs in a bar"
                font.pixelSize: 17
                color: "white"
                Layout.preferredWidth: window.width/2
            }
            Slider {
                id: sliderNumOfLEDs
                from: 10
                value: 50
                to: 78
                Layout.preferredWidth: window.width/2
                height: 30
                stepSize: 1
                onValueChanged: {
                    console.log("value: ", value);
                }
            }
        }
        RowLayout{
            Layout.fillWidth: true
            Label{
                text: "Number of frequency bands"
                font.pixelSize: 17
                color: "white"
                Layout.preferredWidth: window.width/2
            }
            Slider {
                id: sliderNumOfFreqBands
                from: 10
                value: 50
                to: 100
                Layout.preferredWidth: window.width/2
                height: 30
                stepSize: 1
                onValueChanged: {
                    console.log("value: ", value);
                }
            }
        }
        ComboBox {
            id: comboBoxIntervals
            height: 50
            Layout.fillWidth: true
            textRole: "key"
            valueRole: "interval"
            model: ListModel {
                id: model
                ListElement { key: "Fast"; interval: 25 }
                ListElement { key: "Medium"; interval: 50 }
                ListElement { key: "Slow"; interval: 75 }
            }
            currentIndex: 1
            onCurrentValueChanged: {
                frequencyVolumeGenerator.interval = currentValue
            }
        }
        Rectangle{
            id: equlizer
            height: window.height - sliderNumOfLEDs.height-sliderNumOfFreqBands.height - comboBoxIntervals.height
            width: window.width
            color: window.color
            ListView{
                id: root
                anchors.fill: parent
                model: frequencyVolumeGenerator
                orientation: ListView.Horizontal
                delegate: LedBar {
                    width: (ListView.view.width - (root.spacing*(root.count-1)))/root.count
                    height: ListView.view.height
                    ledNumber: slider.value
                }
            }
        }
    }
}
