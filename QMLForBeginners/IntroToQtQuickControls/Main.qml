// import QtQuick
// import QtQuick.Controls.Basic
// import QtQuick.Layouts

// // ApplicationWindow {

// //     id: window

// //     width: 1024
// //     height: 800
// //     visible: true

// //     title: qsTr("Home Controls")

// //     font.pixelSize: 24

// //     background: Image {

// //         source: Qt.resolvedUrl("assets/BrushedMetal.jpg")
// //         fillMode: Image.PreserveAspectCrop
// //     }

// //     ClimateControls {
// //         anchors.fill: parent
// //     }
// // }

// ApplicationWindow{
//     Page {
//         anchors.fill: parent
//         ColumnLayout {
//             anchors.fill: parent
//             Pane {
//                 id: root
//                 RowLayout {
//                     anchors.fill: parent
//                     ColumnLayout {
//                         RowLayout {
//                             CheckBox {}
//                             Switch {}
//                         }
//                         RowLayout {
//                             Image {}
//                             Dial {}
//                             Image {}
//                         }
//                     }
//                     ColumnLayout {
//                         Label {}
//                         RowLayout {
//                             Image {}
//                             Slider {}
//                             Image {}
//                         }
//                     }
//                 }
//             }

//             Pane {
//                 RowLayout {
//                     anchors.fill: parent
//                     ColumnLayout {
//                         RowLayout {
//                             CheckBox {}
//                             Switch {}
//                         }

//                         RowLayout {
//                             Image {
//                                 Layout.alignment: Qt.AlignBottom
//                             }
//                             Dial {}
//                             Image {
//                                 Layout.alignment: Qt.AlignBottom
//                             }
//                         }
//                     }
//                     ColumnLayout {
//                         Label {
//                             Layout.fillWidth: true
//                             horizontalAlignment: Qt.AlignRight
//                         }
//                         RowLayout {
//                             Image {}
//                             Slider {
//                                 Layout.fillWidth: true
//                             }
//                             Image {}
//                         }
//                     }
//                 }
//             }

//         }
//     }
// }
import QtQuick
import QtQuick.Controls.Basic
import QtQuick.Layouts

ApplicationWindow {
    id: window
    width: 640
    height: 480
    visible: true
    title: qsTr("Gaji Baji")

    color: "white"

    ColumnLayout {
        anchors.fill: parent
        spacing: 10

        // Header
        Label {
            text: qsTr("Gaji Baji")
            color: "black"
            font.pixelSize: 32
            Layout.alignment: Qt.AlignHCenter
        }

        // Main content area with two columns
        RowLayout {
            Layout.fillWidth: true
            spacing: 20

            // First Column
            ColumnLayout {
                spacing: 10
                Category {
                    categoryName: "Main Dishes"
                    SingleDish {
                        dishName: "Onion"
                        dishCost: 5
                    }
                    SingleDish {
                        dishName: "Schabowy"
                        dishCost: 10
                    }
                }
                Category {
                    categoryName: "Soups"
                    SingleDish {
                        dishName: "Tomato Soup"
                        dishCost: 7
                    }
                    SingleDish {
                        dishName: "Chicken Soup"
                        dishCost: 8
                    }
                }
            }

            // Second Column
            ColumnLayout {
                spacing: 10
                Category {
                    categoryName: "Desserts"
                    SingleDish {
                        dishName: "Cheesecake"
                        dishCost: 6
                    }
                    SingleDish {
                        dishName: "Brownie"
                        dishCost: 5
                    }
                }
                Category {
                    categoryName: "Drinks"
                    SingleDish {
                        dishName: "Tea"
                        dishCost: 3
                    }
                    SingleDish {
                        dishName: "Coffee"
                        dishCost: 4
                    }
                }
            }
        }

        // Footer
        Label {
            text: qsTr("Total Order Cost: $0")
            color: "black"
            font.pixelSize: 24
            Layout.alignment: Qt.AlignHCenter
        }
    }

    // Components
    component Category: ColumnLayout {
        property alias categoryName: categoryLabel.text
        spacing: 5

        Label {
            id: categoryLabel
            font.bold: true
            font.pixelSize: 20
            color: "black"
            Layout.alignment: Qt.AlignTop
        }
    }

    component SingleDish: RowLayout {
        property string dishName
        property int dishCost

        Label {
            text: qsTr("%1: $%2").arg(dishName).arg(dishCost)
            Layout.alignment: Qt.AlignLeft
        }

        SpinBox {
            id: foodCounter
            value: 1
            from: 0
            Layout.alignment: Qt.AlignRight
        }
    }
}
