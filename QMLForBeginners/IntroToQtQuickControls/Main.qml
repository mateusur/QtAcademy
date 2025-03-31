import QtQuick
import QtQuick.Controls.Basic
import QtQuick.Layouts

// ApplicationWindow {

//     id: window

//     width: 1024
//     height: 800
//     visible: true

//     title: qsTr("Home Controls")

//     font.pixelSize: 24

//     background: Image {

//         source: Qt.resolvedUrl("assets/BrushedMetal.jpg")
//         fillMode: Image.PreserveAspectCrop
//     }

//     ClimateControls {
//         anchors.fill: parent
//     }
// }

ApplicationWindow{
    Page {
        anchors.fill: parent
        ColumnLayout {
            anchors.fill: parent
            Pane {
                id: root
                RowLayout {
                    anchors.fill: parent
                    ColumnLayout {
                        RowLayout {
                            CheckBox {}
                            Switch {}
                        }
                        RowLayout {
                            Image {}
                            Dial {}
                            Image {}
                        }
                    }
                    ColumnLayout {
                        Label {}
                        RowLayout {
                            Image {}
                            Slider {}
                            Image {}
                        }
                    }
                }
            }

            Pane {
                RowLayout {
                    anchors.fill: parent
                    ColumnLayout {
                        RowLayout {
                            CheckBox {}
                            Switch {}
                        }

                        RowLayout {
                            Image {
                                Layout.alignment: Qt.AlignBottom
                            }
                            Dial {}
                            Image {
                                Layout.alignment: Qt.AlignBottom
                            }
                        }
                    }
                    ColumnLayout {
                        Label {
                            Layout.fillWidth: true
                            horizontalAlignment: Qt.AlignRight
                        }
                        RowLayout {
                            Image {}
                            Slider {
                                Layout.fillWidth: true
                            }
                            Image {}
                        }
                    }
                }
            }

        }
    }
}
