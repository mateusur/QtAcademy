pragma ComponentBehavior: Bound
import QtQuick
import QtQuick.Controls.Basic
Window {
    width: 640
    height: 480
    visible: true
    title: qsTr("Contacts ModelView")

    ListModel{
        id: contactsModel

        ListElement{
            firstName: "John"
            lastName: "Doe"
            age: 39
            phoneNumber: "111-111-1111"
        }
        ListElement{
            firstName: "Chris"
            lastName: "Doe"
            age: 82
            phoneNumber: "321-111-1111"
        }
        ListElement{
            firstName: "Emilly"
            lastName: "Doe"
            age: 81
            phoneNumber: "111-111-1111"
        }
        ListElement{
            firstName: "Geogre"
            lastName: "Davos"
            age: 58
            phoneNumber: "222-222-1111"
        }
        ListElement{
            firstName: "Mike"
            lastName: "Davos"
            age: 13
            phoneNumber: "222-131-1111"
        }
        ListElement{
            firstName: "Nicole"
            lastName: "Davos"
            age: 18
            phoneNumber: "222-131-9873"
        }
        ListElement{
            firstName: "Kate"
            lastName: "Smith"
            age: 39
            phoneNumber: "321-111-1234"
        }
        ListElement{
            firstName: "Jose"
            lastName: "Wolf"
            age: 38
            phoneNumber: "888-888-8888"
        }

        ListElement{
            firstName: "Joe"
            lastName: "Wolf"
            age: 35
            phoneNumber: "999-999-9999"
        }
    }
    Component{
        id: constactsDelegate

        Rectangle{
            id: delegateRect

            required property string firstName
            required property string lastName
            required property int age
            required property string phoneNumber
            required property int index
            property ItemView listView: ListView.view
            height: 50
            width: parent ? parent.width : 0
            border.color:  "black"

            Text {
                anchors.left: parent.left
                anchors.leftMargin: 5
                text: "Name: %1 %2 \nAge: %3 \nPhone: %4"
                .arg(delegateRect.firstName).arg(delegateRect.lastName)
                .arg(delegateRect.age).arg(delegateRect.phoneNumber)
            }

            MouseArea{
                anchors.fill: parent
                hoverEnabled: true

                onReleased: {
                    delegateRect.listView.currentIndex = delegateRect.index
                    delegateRect.color = "white"
                }

                onPressed: {
                    delegateRect.color = "gray"
                }

                onEntered: {
                    delegateRect.color = "lightgray"
                }

                onExited: {
                    delegateRect.color = "white"
                }
            }
            Keys.onTabPressed: {
                if (contactsView.currentIndex < 0) {
                    console.log("Must select an element to insert a new entry")
                } else {
                    listView.model.insert(contactsView.currentIndex,
                                          {"firstName": delegateRect.firstName,
                                              "lastName": delegateRect.lastName,
                                              "age": delegateRect.age,
                                              "phoneNumber": delegateRect.phoneNumber})
                }
            }
        }
    }

    ListView{
        id:contactsView

        anchors.fill: parent
        model: contactsModel
        delegate:  constactsDelegate
        header: contactsHeader
        footer: contactsFooter

        highlight: contactsHighlight
        highlightFollowsCurrentItem: true
        focus: true
        highlightMoveDuration: 1
        highlightResizeDuration: 1

        section.delegate: contactsSeciton
        section.criteria: ViewSection.FullString
        section.labelPositioning: ViewSection.InlineLabels
        section.property: "lastName"

        add: addTransition

        Keys.onDeletePressed: {
            if(contactsView.currentIndex<0){
                console.log("Must select an element to delete an entry")
            } else {
                contactsView.model.remove(contactsView.currentIndex)
            }
        }
    }

    Component{
        id: contactsHeader
        Rectangle{
            id: headerRect

            height: 35
            width: parent.width
            border.color: "black"
            color: "mediumturquoise"
            z: 2

            Text{
                anchors.centerIn: parent
                text: "Contacts List"
                font.pointSize: 18
            }
        }
    }
    Component{
        id: contactsFooter
        Rectangle{
            id: footerRect

            height: 20
            width: parent.width
            border.color: "black"
            color: "mediumturquoise"
        }
    }
    Component{
        id: contactsHighlight
        Rectangle{
            id: highlightRect
            border.color: "black"
            color: "yellow"
            opacity: 0.15
            z:2
        }
    }
    Component{
        id: contactsSeciton
        Rectangle{
            id: sectionRect
            required property string section
            height:30
            width: parent.width
            border.color: "black"
            color: "lightblue"

            Text{
                anchors.centerIn: parent
                text: sectionRect.section + " Family"
                font.bold: true
                font.pointSize: 12
            }
        }
    }

    Transition{
        id: addTransition

        NumberAnimation{
            property: "opacity"
            from: 0
            to: 1.0
            duration: 300
        }
        NumberAnimation{
            property: "scale"
            from: 0
            to: 1.0
            duration: 300
        }
    }
}
