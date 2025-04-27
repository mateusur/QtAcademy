import QtQuick

ListModel{
    id: root
    property int interval: 50
    property int frequencyBands: 50

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
            root.append({currentVolume: 0})
        }
    }

    function removeBars(count: int){
        root.remove(root.count - count, count)
    }

    function updateBandData(){
        for(let index =0; index<root.count; index++){
            const oldValue = root.get(index)["currentVolume"]
            const newValue = Math.min(1, Math.max(oldValue + ((Math.random() - 0.5) * 0.1),0))
            root.setProperty(index, "currentVolume",newValue)
        }
    }

    property Timer dataGenerator: Timer {
        interval: root.interval
        repeat: true
        running: root.count > 0
        onTriggered: root.updateBandData()
    }
}
