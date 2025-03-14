pragma ComponentBehavior: Bound
import QtQuick
import QtQuick.Controls.Basic
import Qt.labs.qmlmodels

Window {
    width: 640
    height: 480
    visible: true
    title: qsTr("Table model")

    TableModel {
        id: contactsModel

        TableModelColumn { display: "firstName" }
        TableModelColumn { display: "lastName" }
        TableModelColumn { display: "age" }
        TableModelColumn { display: "phoneNumber" }

        rows: [
            {
                firstName: "John",
                lastName: "Doe",
                age: "49",
                phoneNumber: "111-111-1111"
            },
            {
                firstName: "Jane",
                lastName: "Doe",
                age: "48",
                phoneNumber: "222-222-2222"
            },
            {
                firstName: "George",
                lastName: "Doe",
                age: "12",
                phoneNumber: "333-333-3333"
            },
        ]
    }

    Component {
        id: contactsDelegate

        Rectangle {
            id: delegateRect

            required property bool current
            required property string display

            implicitWidth: 100
            implicitHeight: 50
            color: current ? "pink" : "lightgray"
            border.width: current ? 2 : 0
            TableView.editDelegate: contactsEditDelegate

            Text {
                text: delegateRect.display
                padding: 12
                anchors.fill: parent
            }
        }
    }

    ScrollView {
        id: scrollView

        anchors.left: contactsVHeader.right
        anchors.top: contactsHHeader.bottom
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        clip: true

        TableView {
            id: contactsView

            anchors.fill: parent
            columnSpacing: 1
            rowSpacing: 1
            resizableColumns: true
            resizableRows: true
            editTriggers: TableView.DoubleTapped

            model: contactsModel
            delegate: contactsDelegate

            selectionModel: ItemSelectionModel {
                model: contactsView.model
            }

            Keys.onDigit1Pressed: {
                if(currentRow =>0){
                    contactsView.model.insertRow(contactsView.currentRow,{
                                                 "firstName": "Name",
                                                 "lastName": "Surname",
                                                 "age": 0,
                                                 "phoneNumber": "123-456-7891"})
                }
            }
        }
    }

    HorizontalHeaderView{
        id: contactsHHeader
        anchors.left: scrollView.left
        anchors.top: parent.top
        syncView: contactsView

        model: contactsHHeaderData
        delegate: contactsHorintalDelegate
    }

    VerticalHeaderView{
        id: contactsVHeader
        anchors.left: parent.left
        anchors.top: scrollView.top
        syncView: contactsView
        clip: true
    }

    ListModel{
        id: contactsHHeaderData

        ListElement{display: "First name"}
        ListElement{display: "Last name"}
        ListElement{display: "Age"}
        ListElement{display: "Phone number"}
    }

    Component{
        id: contactsHorintalDelegate
        Text{
            id: delegateText
            required property string display
            padding: 12
            text: display

            Rectangle{
                anchors.fill: parent
                color: "gray"
                z: -1
            }
        }
    }

    Component{
        id: contactsEditDelegate
        TextField{
            id: delegateTextField

            required property int column
            required property int row
            required property string display

            anchors.fill: parent
            text: display

            horizontalAlignment: TextInput.AlignHCenter
            verticalAlignment: TextInput.AlignVCenter

            TableView.onCommit: {
                let index = TableView.view.index(row,column)
                contactsModel.setData(index,"display",text)
            }
        }
    }
}
