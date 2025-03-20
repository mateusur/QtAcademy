import QtQuick

Window {
    id:root
    // TODO: change the size to ensure it forms the standard business card ratio of approx 1:1.586
    // HINT: you may wish to use a binding

    width: height*1.1586
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
                border.color: "black"
                Text{
                    text: "Details"
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
                leftPadding: 15
                topPadding: 15
            }
            Item {
                id: basicInfo
                anchors {
                    // below the nameText
                    top: nameText.bottom
                    topMargin: 10
                    left: parent.left
                    right: parent.right
                    bottom: parent.bottom
                }
                Text {
                    id: address
                    text: myContactInfo.address
                    font.pixelSize: 10
                }
                Text {
                    id: country
                    text: myContactInfo.country
                    font.pixelSize: 10
                    anchors.top: address.bottom
                }
                Text {
                    id: phone
                    text: myContactInfo.phone
                    font.pixelSize: 10
                    anchors.top: country.bottom
                }

            }
            Item{
                id: details
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

    /* Your solution should contain these key features:

        - A Text element for each of the ContactInfo properties.
        - The name and photo image should be shown all the time.
        - These should be grouped into two categories "Basic Info" and "Details".
        - Create a button using a MouseArea or TapHandler that can be used to
          toggle between showing the two categories of information.
        - Use a larger font size for the name
    */
}
