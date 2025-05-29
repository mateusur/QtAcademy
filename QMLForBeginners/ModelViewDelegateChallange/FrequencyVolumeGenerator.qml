import QtQuick

ListModel{
    id: root
    property int interval: 50
    property int frequencyBands: 50
    property real meanVolume: 0

    onFrequencyBandsChanged: updateBands()
    Component.onCompleted: updateBands()

    function updateBands() {
        if(frequencyBands > root.count){
            root.addBars(frequencyBands-root.count)
        } else if (frequencyBands < root.count){
            root.removeBars(root.count - frequencyBands)
        }
    }

    function addBars(count: int){
        for(let index=0; index < count; index++){
            root.append({currentVolume: 0, maxVolume:0})
        }
    }

    function removeBars(count: int){
        root.remove(root.count - count, count)
    }

    function updateBandData(){
        let mean = 0
        for(let index =0; index<root.count; index++){
            const oldValue = root.get(index)["currentVolume"]
            const newValue = Math.min(1, Math.max(oldValue + ((Math.random() - 0.5) * 0.1),0))
            mean = mean + newValue;
            root.setProperty(index, "currentVolume",newValue)
            let maxVolume = root.get(index)["maxVolume"]
            if(maxVolume>newValue){
                root.setProperty(index, "maxVolume",newValue)
            }
            console.log("NewValue: ", newValue)
        }
        meanVolume = mean / root.count;
    }

    property Timer dataGenerator: Timer {
        interval: root.interval
        repeat: true
        running: root.count > 0
        onTriggered: root.updateBandData()
    }
}
