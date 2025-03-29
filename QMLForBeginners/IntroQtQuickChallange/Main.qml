pragma ComponentBehavior: Bound
// for permitting access to window.themeColor
// from inside any component declarations in this file

import QtQuick

Window {
    id: window

    /* Your solution should contain these key features:

    - Add a Window with dimensions which resemble the kind of
      remote control shape you want

    - Using components from the Qt Quick module such as Text,
      Image, Rectangle and any other components you want to use
      in your design, construct your shape, colors and layout of
      the elements you need.

    - You should include a number of Buttons providing features
      such as Volume +/-, Mute, Channel +/-, Power on/off, and
      perhaps even some cursor arrows.

    - Add image resources to your project and use them in your
      design and try to show how the image URL might be changed
      using bindings inside a string template expression.

    - Add a font to your project and use a FontLoader to be able
      to use the font in your Text components.

    - Create re-usable items using inline components adding any
      "required" properties where necessary

    - Using bindings and signal handlers to connect your UI
      elements to the provided tvControl object (below) so that
      interacting with your Buttons for example, could change
      the visible, enabled, or color of some of the other
      elements based on the changed state of the tvControl
      object’s properties.

    */

    // Here we have chosen a reasonable shape for your
    // remote control, but feel free to design your own.
    width: 240
    height: 740
    visible: true
    color: "black"

    // the window provides a themeColor property which you
    // may use wherever you need to refer to the same color
    property color themeColor: "silver"

    /* Here are a few components you can use to get you going */

    FontLoader{
        id: silkscreenBoldLoader
        source: "fonts/Silkscreen/Silkscreen-Bold.ttf"
    }
    FontLoader{
        id: silkscreenLoader
        source: "fonts/Silkscreen/Silkscreen-Regular.ttf"
    }
    component BorderGradient: Rectangle {
        id: borderGradientRectangle

        // BorderGradient:
        // A simple Rectangle with a 2-color gradient

        // We use the Rectangle's own color property as
        // the first gradient stop color (so we upgrade the
        // color property to a required property)
        property color color2: borderGradientRectangle.color.darker()

        color: window.themeColor

        gradient: Gradient {
            GradientStop {
                position: 0
                color: borderGradientRectangle.color
            }
            GradientStop {
                position: 1
                color: borderGradientRectangle.color2
            }
        }
    }

    component DoubleBorderGradient: BorderGradient {
        id: doubleBorderGradient

        // DoubleBorderGradient:
        // A BorderGradient with another one nested inside
        // with a specified innerMargin

        property int innerMargin: 2

        BorderGradient {
            // inner gradient
            anchors {
                fill: parent
                margins: doubleBorderGradient.innerMargin
            }

            radius: doubleBorderGradient.radius - doubleBorderGradient.innerMargin

            // swap the colors around
            color: doubleBorderGradient.color2
            color2: doubleBorderGradient.color
        }
    }

    component Button: DoubleBorderGradient {
        id: button

        // Button:
        // A clickable DoubleBorderGradient with a useful
        // clicked signal and a pressed property alias

        readonly property alias pressed: tapHandler.pressed
        property alias imageSource: icon.source
        signal clicked

        implicitWidth: 100
        implicitHeight: 40

        radius: Math.min(width, height) / 2

        color: tapHandler.pressed ? window.themeColor : window.themeColor.darker()
        color2: tapHandler.pressed ? window.themeColor.darker() : window.themeColor
        Image{
            id: icon
            anchors.fill: parent
            anchors.margins: 7
        }
        TapHandler {
            id: tapHandler
            gesturePolicy: TapHandler.WithinBounds
            onTapped: button.clicked()
        }
    }

    component CircleButton: Button {
        id: circleButton

        // CircleButton:
        // A circular Button for convenience

        width: 200
        height: width // a circle

        // The CircleButton uses Item's containmentMask
        // property to return the boolean result of a
        // simplified test to check if the point is inside
        // the circle or not.
        containmentMask: QtObject {
            function contains(clickPoint: point) : bool {
                return (Math.pow(clickPoint.x - circleButton.radius, 2) +
                        Math.pow(clickPoint.y - circleButton.radius, 2))
                        < Math.pow(circleButton.radius, 2)
            }
        }
    }

    component LongVerticalButton: DoubleBorderGradient {
        id: longVerticalButton

        // Button:
        // A clickable DoubleBorderGradient with a useful
        // clicked signal and a pressed property alias

        readonly property alias topPressed: mouseAreaTop.pressed
        readonly property alias bottomPressed: mouseAreaTop.pressed

        property alias topImageSource: topIcon.source
        property alias bottomImageSource: bottomIcon.source
        signal upClicked
        signal downClicked

        implicitWidth: 40
        implicitHeight: 160

        radius: Math.min(width, height) / 2

        color: topPressed || bottomPressed ? window.themeColor : window.themeColor.darker()
        color2:  topPressed || bottomPressed ? window.themeColor.darker() : window.themeColor
        Image{
            id: topIcon
            anchors {
                horizontalCenter: parent.horizontalCenter
                top: parent.top
                topMargin: 20
            }
            width: 32
            height: 32
            fillMode: Image.PreserveAspectFit
        }
        Image{
            id: bottomIcon
            anchors {
                horizontalCenter: parent.horizontalCenter
                bottom: parent.bottom
                bottomMargin: 20
            }
            width: 32
            height: 32
            fillMode: Image.PreserveAspectFit

        }
        MouseArea {
            id: mouseAreaTop
            anchors{
                top: parent.top
                left: parent.left
                right: parent.right
                bottom: parent.verticalCenter
            }
            onClicked: longVerticalButton.upClicked()
        }
        MouseArea {
            id: mouseAreaBottom
            anchors{
                top: parent.verticalCenter
                left: parent.left
                right: parent.right
                bottom: parent.bottom
            }
            onClicked: longVerticalButton.downClicked()
        }
    }
    QtObject {
        id: tvControl

        // The tvControl object is provided for you to use as a
        // mock back-end providing a number of typical properties
        // and features you might find on a remote control.
        // There are even 5 channels with sample channelNames.

        property int channelNumber: 0
        readonly property string channelName: channelNames[channelNumber]

        // TV Features
        property bool closedCaptionsEnabled: true
        property bool hdrEnabled: true
        property bool castConnected: true
        property bool listening: false
        property bool muted: false
        property real volume: 0.75
        readonly property bool soundOn: !muted && volume > 0

        function incrementVolume() {
            volume = Math.min(1, volume + 0.1)
        }

        function decrementVolume() {
            volume = Math.max(0, volume - 0.1)
        }

        function incrementChannel() {
            channelNumber = Math.min(channelNames.length - 1, channelNumber + 1)
        }

        function decrementChannel() {
            channelNumber = Math.max(0, channelNumber - 1)
        }

        property list<string> channelNames: [
            "News Station",
            "Comedy Cable",
            "Eats and Beats",
            "Weather",
            "Cartoons",
            "Reality TV"
        ]
    }

    // Here we provide a suggested remote control background
    DoubleBorderGradient {
        id: remoteControlBackground

        anchors.fill: parent
        innerMargin: 8
        radius: 40
    }

    // As a demonstration of one of the Button types,
    // we add a power button.
    CircleButton {
        id: powerButton
        imageSource: "images/power.svg"
        anchors {
            top: parent.top
            right: parent.right
            topMargin: 20
            rightMargin: 20
        }
        width: 40
        height: 40
        color: "darkred"

        onClicked: window.close()
    }
    Rectangle{
        id: tvDisplay
        color: "#93AA4B"
        radius: 20
        opacity: 0.9
        width: parent.width - 40
        height: width/2
        // anchors.margins: 2

        anchors{
            top: powerButton.bottom
            margins: 20
            horizontalCenter: parent.horizontalCenter
        }
        Rectangle{
            id: volumeBorder
            height: parent.height-20
            width: 10
            color: "transparent"
            border{
                color: "black"
                width: 1.5
            }
            anchors{
                top: parent.top
                right: parent.right
                bottom: parent.bottom
                topMargin: 10
                bottomMargin: 10
                rightMargin: 20
            }
            Rectangle{
                id:volumeIdicator
                color: "black"
                opacity: 0.7
                width: parent.width-2*parent.border.width
                height: (parent.height-parent.border.width)*tvControl.volume
                anchors{
                    bottom: parent.bottom
                    left: parent.left
                    right: parent.right
                }
            }
        }
        Image {
            id: tvVolume
            visible: true
            source: Qt.resolvedUrl("images/speaker.svg")
            height: 30
            width: height
            fillMode: Image.PreserveAspectFit
            anchors{
                bottom: volumeBorder.bottom
                right: volumeBorder.left
            }
        }

        Text {
            id: channelNumberText
            text: `CHANNEL ${tvControl.channelNumber}`
            font.family: silkscreenBoldLoader.font.family
            font.weight: silkscreenBoldLoader.font.weight
            font.pixelSize: 15
            anchors{
                top: parent.top
                leftMargin: 20
                left: parent.left
            }
        }
        Text {
            id: station
            text: tvControl.channelName
            font.family: silkscreenLoader.font.family
            font.weight: silkscreenLoader.font.weight
            font.pixelSize: 13
            anchors{
                top: channelNumberText.bottom
                left: parent.left
                leftMargin: 20
            }
        }
        Image {
            id: tvCaption
            visible: tvControl.closedCaptionsEnabled
            source: Qt.resolvedUrl("images/closed_caption.svg")
            height: 30
            width: height
            fillMode: Image.PreserveAspectFit
            anchors{
                bottom: parent.bottom
                left: parent.left
                leftMargin: 20
            }
        }
        Image {
            id: tvHdr
            visible: tvControl.hdrEnabled
            source: Qt.resolvedUrl("images/hdr_on.svg")
            height: 30
            width: height
            fillMode: Image.PreserveAspectFit
            anchors{
                bottom: parent.bottom
                left: tvCaption.right
            }
        }
        Image {
            id: tvCast
            visible: tvControl.castConnected
            source: Qt.resolvedUrl("images/cast_connected.svg")
            height: 30
            width: height
            fillMode: Image.PreserveAspectFit
            anchors{
                bottom: parent.bottom
                left: tvHdr.right
            }
        }
        Image {
            id: tvMute
            visible: tvControl.muted
            source: Qt.resolvedUrl("images/speaker_muted.svg")
            height: 30
            width: height
            fillMode: Image.PreserveAspectFit
            anchors{
                bottom: parent.bottom
                left: tvCast.right
            }
        }
    }

    Item{
        id: featureButtons
        anchors{
            top: tvDisplay.bottom
            left: parent.left
            right: parent.right
            topMargin: 20
            leftMargin: 20
            rightMargin: 20
        }
        height: 40

        Button{
            id: caption
            width: 47
            property string imageInactive
            property string imageActive
            onClicked: tvControl.closedCaptionsEnabled = !tvControl.closedCaptionsEnabled
            imageInactive: "closed_caption_white"
            imageActive: "closed_caption"
            imageSource: Qt.resolvedUrl(`images/${tvControl.closedCaptionsEnabled? imageActive :imageInactive }.svg`)
        }

        Button{
            id: hdr
            width: 47
            property string imageInactive
            property string imageActive

            onClicked: tvControl.hdrEnabled = !tvControl.hdrEnabled
            imageInactive: "hdr_on_white"
            imageActive: "hdr_on"
            imageSource:  Qt.resolvedUrl(`images/${tvControl.hdrEnabled? imageActive :imageInactive }.svg`)
            anchors.left: caption.right
        }
        Button{
            id: casting
            width: 47
            property string imageInactive
            property string imageActive

            onClicked: tvControl.castConnected = !tvControl.castConnected
            imageInactive: "cast_white"
            imageActive: "cast_connected"
            imageSource:  Qt.resolvedUrl(`images/${tvControl.castConnected? imageActive  :imageInactive }.svg`)
            anchors.left: hdr.right
        }
        Button{
            id: muteButton
            width: 47
            property string imageInactive
            property string imageActive

            onClicked: tvControl.muted = !tvControl.muted
            imageInactive: "speaker_muted_white"
            imageActive: "speaker_muted"
            imageSource:  Qt.resolvedUrl(`images/${tvControl.muted?imageActive  :imageInactive }.svg`)
            anchors.left: casting.right
        }
    }

    Item{
        id:dpad
        anchors{
            top: featureButtons.bottom
            topMargin: 20
            horizontalCenter: parent.horizontalCenter
        }
        width: 200
        height: 200

        Item {
            id: rotatedButtons
            anchors.fill: parent
            rotation: 45
            Item {
                id: topButton
                width: 100
                height: 100
                anchors.left: parent.left
                anchors.top: parent.top
                clip: true

                CircleButton{
                    rotation: -45
                    Image{
                        anchors{
                            top: parent.top
                            topMargin: 10
                            horizontalCenter: parent.horizontalCenter
                        }
                        width: 32
                        height: 32
                        source: Qt.resolvedUrl("images/settings.svg")
                        fillMode: Image.PreserveAspectFit
                    }
                }
            }
            Item{
                id:rightButton
                width: 100
                height: 100
                anchors.right: parent.right
                anchors.top: parent.top
                clip: true
                CircleButton{
                    rotation: -45
                    anchors.horizontalCenter: parent.left
                    Image{
                        anchors{
                            right: parent.right
                            rightMargin: 10
                            verticalCenter: parent.verticalCenter
                        }
                        width: 32
                        height: width
                        source: Qt.resolvedUrl("images/fast_forward.svg")
                        fillMode: Image.PreserveAspectFit
                    }
                }
            }
            Item{
                id: leftButton
                width: 100
                height: 100
                anchors.left: parent.left
                anchors.bottom: parent.bottom
                clip: true
                CircleButton{
                    rotation: -45
                    anchors.verticalCenter: parent.top
                    anchors.horizontalCenter: parent.right
                    Image{
                        anchors{
                            left: parent.left
                            leftMargin: 10
                            verticalCenter: parent.verticalCenter
                        }
                        width: 32
                        height: width
                        source: Qt.resolvedUrl("images/fast_rewind.svg")
                        fillMode: Image.PreserveAspectFit
                    }
                }
            }
            Item{
                id:bottomButton
                width: 100
                height: 100
                anchors.right: parent.right
                anchors.bottom: parent.bottom
                clip: true
                CircleButton{
                    rotation: -45
                    anchors.verticalCenter: parent.top
                    anchors.horizontalCenter: parent.left
                    Image{
                        anchors{
                            bottom: parent.bottom
                            bottomMargin: 10
                            horizontalCenter: parent.horizontalCenter
                        }
                        width: 32
                        height: width
                        source: Qt.resolvedUrl("images/play_pause.svg")
                        fillMode: Image.PreserveAspectFit
                    }
                }
            }
            Rectangle{
                anchors{
                    top: parent.top
                    bottom:parent.bottom
                    horizontalCenter: parent.horizontalCenter
                    margins: 2
                }
                width: 2
                color: window.themeColor
                opacity: 0.5
                Rectangle{
                    x:-1
                    height: parent.height
                    width: 2
                    color: window.themeColor.darker()
                }
            }
            Rectangle{
                anchors{
                    left: parent.left
                    right: parent.right
                    verticalCenter: parent.verticalCenter
                    margins: 2
                }
                height: 2
                color: window.themeColor
                opacity: 0.5
                Rectangle{
                    y:-1
                    height: 2
                    width: parent.width
                    color: window.themeColor.darker()
                }
            }

        }
        CircleButton{
            id: micButton
            width: 100
            height: 100
            anchors{
                verticalCenter: parent.verticalCenter
                horizontalCenter: parent.horizontalCenter
            }
            Image{
                anchors{
                    verticalCenter: parent.verticalCenter
                    horizontalCenter: parent.horizontalCenter
                }
                width: 32
                height: width
                source: Qt.resolvedUrl("images/mic_white.svg")
                fillMode: Image.PreserveAspectFit
            }
        }
    }

    LongVerticalButton{
        id: volumeButton
        topImageSource: "images/volume_up.svg"
        bottomImageSource: "images/volume_down.svg"
        anchors{
            right: parent.right
            rightMargin: 44
            bottom: parent.bottom
            bottomMargin: 44
        }
        onUpClicked: tvControl.incrementVolume()
        onDownClicked: tvControl.decrementVolume()
    }
    LongVerticalButton{
        id: channelButton
        topImageSource: "images/plus.svg"
        bottomImageSource: "images/minus.svg"
        anchors{
            left: parent.left
            leftMargin: 44
            bottom: parent.bottom
            bottomMargin: 44
        }
        onUpClicked: tvControl.incrementChannel()
        onDownClicked: tvControl.decrementChannel()
    }

}
