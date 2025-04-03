import QtQuick
import QtQuick.Controls.Basic
import QtQuick.Layouts
ApplicationWindow {
    id: window

    /* Your menu ordering application should contain the following:

        - A variety of Controls from the Qt Quick Controls module
          such as Page, Pane, Button, Slider, RadioButton or Dials.
        - An ApplicationWindow that has a suitably appetising background
        - A cuisine-themed font to use across your whole design.
        - A restaurant name that you can put in the ApplicationWindow header.
        - Customise the ApplicationWindow palette to adjust your Controls' colors
        - Organise your menu into visual Pages with titles for Starters, Mains and Desserts,
          listing some menu items, showing a price and a quantity selection.
        - The total cost of the selected items should be shown in the ApplicationWindow footer
        - Consider how your design could be made from re-usable components as QML Files
        - Add a Button for "submitting" the order and show a visual status that the order
          is busy being processed, and then completed. A Timer can be used to simulate this.
        - If using anchors to arrange your design becomes complex, try using
          RowLayout and ColumnLayout from the Qt Quick Layouts module.
    */

    width: 640
    height: 800
    visible: true
    title: qsTr("Gaji Baji")
    readonly property real totalCost: starters.subtotal + mains.subtotal + sides.subtotal + breads.subtotal + tipSlider.value
    background: Image {
        source: Qt.resolvedUrl("images/curry.jpg")
        fillMode: Image.PreserveAspectCrop
        opacity: 0.5
    }
    header: Pane{
        padding: 8

        background: Rectangle {
            color: palette.window
            opacity: 0.5
        }
        Label {
            text: window.title
            font.pixelSize: 30
            anchors.centerIn: parent
        }
    }
    footer: Pane{
        padding: 8

        background: Rectangle {
            color: palette.window
            opacity: 0.5
        }
        RowLayout{
            anchors.fill: parent
            Label {
                text: `Total Order cost: ${window.totalCost}$`
                font.pixelSize: 30
                Layout.fillWidth: true
            }
        }
    }
    Palette {
        id: lightPalette
        dark: "black"
        window: "white"
        windowText: "black"
    }

    palette: lightPalette

    Item{
        id: menu
        anchors.fill: parent
        Pane{
            anchors{
                top: parent.top
                bottom: parent.bottom
                left: parent.left
                right: parent.horizontalCenter
            }
            padding: 8

            background: Rectangle {
                color: "transparent"
                border.color: palette.windowText
            }
            ColumnLayout{
                anchors.fill: parent
                Category{
                    id: starters
                    title: qsTr("Starters")
                    Layout.fillWidth: true
                    item1 {
                        name: qsTr("Onion Bhaji")
                        cost: 10
                    }
                    item2 {
                        name: qsTr("Meat Samosa")
                        cost: 12
                    }
                    item3 {
                        name: qsTr("Nargis Kebab")
                        cost: 15
                    }
                }
                Category{
                    id: mains
                    title: qsTr("Mains")
                    Layout.fillWidth: true
                    item1 {
                        name: qsTr("Paneer Tikka")
                        cost: 20
                    }
                    item2 {
                        name: qsTr("Lamb Bhuna")
                        cost: 25
                    }
                    item3 {
                        name: qsTr("Murgh Tikka")
                        cost: 28
                    }
                }
                Label {
                    id: spiceLevelLabel

                    text: qsTr("Spice Level")
                    font.pixelSize: 30
                }
                Dial {
                    id: spiceLevelDial

                    Layout.preferredWidth: 150
                    Layout.preferredHeight: 150
                    from: 0
                    to: 5
                    stepSize: 1
                    Layout.alignment: Qt.AlignHCenter
                }
            }
        }
        Pane {
            anchors{
                top: parent.top
                bottom: parent.bottom
                left: parent.horizontalCenter
                right: parent.right
            }
            padding: 8

            background: Rectangle {
                color: "transparent"
                border.color: palette.windowText
            }

            ColumnLayout{
                anchors.fill: parent
                Category{
                    id: sides
                    title: qsTr("Sides")
                    Layout.fillWidth: true
                    item1 {
                        name: qsTr("Pilau Rice")
                        cost: 10
                    }
                    item2 {
                        name: qsTr("Aloo Ghobi")
                        cost: 12
                    }
                    item3 {
                        name: qsTr("Ahji Bahji")
                        cost: 15
                    }
                }
                Category{
                    id: breads
                    title: qsTr("Breads")
                    Layout.fillWidth: true
                    item1 {
                        name: qsTr("Garlic Naan")
                        cost: 15
                    }
                    item2 {
                        name: qsTr("Keema Naan")
                        cost: 18
                    }
                    item3 {
                        name: qsTr("Naan at all")
                        cost: 1
                    }
                }
                Page{
                    header: Label {
                        text: qsTr("Dining Options")
                        font.pixelSize: 30
                    }
                    padding: 0
                    spacing: 8
                    background: null
                    RowLayout{
                        RadioButton{
                            text: qsTr("Eat in")
                            checked: true
                        }
                        RadioButton{
                            id: takeAway
                            text: qsTr("Take away")
                        }
                    }
                }
                Page{
                    header: Label {
                        text: qsTr("Tip Amount")
                        font.pixelSize: 30
                    }
                    padding: 0
                    spacing: 8
                    background: null
                    RowLayout{
                        Slider{
                            id: tipSlider
                            from: 0
                            to: 100
                            stepSize: 1
                        }
                        Label {
                            text: `$${tipSlider.value}`
                        }
                    }
                }
            }
        }
    }

}
