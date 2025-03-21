import QtQuick

Window {
    id:root

    width: height*1.586
    height: 480

    visible: true
    title: qsTr("Business Card")

    component ContactInfo: QtObject {

        // This is a ContactInfo object which provides the properties to fill in.
        // You can create as many instances of this as you like with different property values.

        // show these properties all the time:
        property string name
        property url photo

        // Basic Info properties:
        property string occupation
        property string company

        // Detailed Info properties:
        property string address
        property string country
        property string phone
        property string email
        property url webSite
    }
    Rectangle{
        id:outter
        anchors.fill: parent
        anchors.margins: 10

        border.color: "black"
        border.width: 3
        radius: 10
        Item {
            id: borderItem
            anchors{
                fill: parent
                margins: outter.radius
            }
            Rectangle{
                id:inner
                width: 150
                height: width
                color: "transparent"
                anchors.right: parent.right
                anchors.top: parent.top

                border.color: "grey"
                border.width: 3
                radius: 5
                Image {
                    id: idPhoto
                    source: myContactInfo.photo
                    fillMode: Image.PreserveAspectFit
                    anchors{
                        fill: parent
                        margins: parent.radius
                    }

                }
            }
            Rectangle{
                id: detailsButton

                property bool checked: false
                property bool checkable: true

                signal clicked

                width: 100
                height: 50
                anchors.left: parent.left
                anchors.bottom: parent.bottom
                border.width: 3
                border.color: checked ? "grey" : "black"
                radius: outter.radius
                Text{
                    text: detailsButton.checked ? "Hide details" :"Show details"
                    font.weight: Font.Bold
                    anchors.centerIn: parent
                }
                MouseArea{
                    anchors.fill: parent
                    onClicked: {
                        if(detailsButton.checkable){
                            detailsButton.checked = !detailsButton.checked
                        }
                        detailsButton.clicked()
                    }
                }
            }

            Text {
                id: nameText
                text: myContactInfo.name
                font.pixelSize: 50
            }
            Item {
                id: basicInfo
                anchors {
                    top: nameText.bottom
                    topMargin: 10
                    left: parent.left
                    right: parent.right
                    bottom: parent.bottom
                }
                Text {
                    id: address
                    text: myContactInfo.address
                    font.pixelSize: 20
                }
                Text {
                    id: country
                    text: myContactInfo.country
                    font.pixelSize: 20
                    anchors.top: address.bottom
                }
                Text {
                    id: phone
                    text: myContactInfo.phone
                    font.pixelSize: 20
                    anchors.top: country.bottom
                }

                Item {
                    id: details
                    visible: detailsButton.checked
                    anchors {
                        top: phone.bottom
                        // topMargin: 10
                        left: parent.left
                        right: parent.right
                        bottom: parent.bottom
                    }
                    Text {
                        id: email
                        text: myContactInfo.email
                        font.pixelSize: 20
                    }
                    Text {
                        id: website
                        text: myContactInfo.webSite
                        font.pixelSize: 20
                        anchors.top: email.bottom
                    }
                }
            }


        }

    }

    ContactInfo {
        id: myContactInfo

        // this is one example instance of a ContactInfo inline Component
        // showing how the properties are populated.

        name: "Your Name"
        photo: Qt.resolvedUrl("IDPhoto.png")
        occupation: "QML Enthusiast"
        company: "Indie Soft"
        address: "Candy Cane Lane"
        country: "North Pole"
        phone: "+01 2345 567 890"
        email: "email@server.com"
        webSite: Qt.url("https://www.qt.io")
    }

}
