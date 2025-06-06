import QtQuick

ListModel {
    id: appModel

    // note we must convert appColors and urls from strings later
    ListElement {
        appName: "Home"
        appColor: "red"
        appIcon: "assets/home.svg"
    }
    ListElement {
        appName: "Media"
        appColor: "green"
        appIcon: "assets/play.svg"
    }
    ListElement {
        appName: "Feeds"
        appColor: "blue"
        appIcon: "assets/rss.svg"
    }
    ListElement {
        appName: "Settings"
        appColor: "cyan"
        appIcon: "assets/settings.svg"
    }
    ListElement {
        appName: "Calendar"
        appColor: "yellow"
        appIcon: "assets/table.svg"
    }
    ListElement {
        appName: "Terminal"
        appColor: "magenta"
        appIcon: "assets/terminal.svg"
    }
}
