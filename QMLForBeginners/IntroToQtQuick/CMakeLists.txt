cmake_minimum_required(VERSION 3.16)

project(IntroToQtQuick VERSION 0.1 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(Qt6 REQUIRED COMPONENTS Quick)

qt_standard_project_setup(REQUIRES 6.5)

qt_add_executable(appIntroToQtQuick
    main.cpp
)

qt_add_qml_module(appIntroToQtQuick
    URI IntroToQtQuick
    VERSION 1.0
    QML_FILES
        Main.qml
        RESOURCES fonts/OFL.txt fonts/Prisma.ttf fonts/RussoOne-Regular.ttf
        RESOURCES assets/Button-Pedal-Checked.png assets/Button-Pedal-Checked@2x.png assets/Button-Pedal.png assets/Button-Pedal@2x.png assets/Guitar-Pedal-Background.png assets/Guitar-Pedal-Background@2x.png assets/Knob-Dial.png assets/Knob-Dial@2x.png assets/Knob-Markings.png assets/Knob-Markings@2x.png assets/LED-Checked.png assets/LED-Checked@2x.png assets/LED.png assets/LED@2x.png assets/Screw.png assets/Screw@2x.png assets/Switch-Checked.png assets/Switch-Checked@2x.png assets/Switch.png assets/Switch@2x.png
)

# Qt for iOS sets MACOSX_BUNDLE_GUI_IDENTIFIER automatically since Qt 6.1.
# If you are developing for iOS or macOS you should consider setting an
# explicit, fixed bundle identifier manually though.
set_target_properties(appIntroToQtQuick PROPERTIES
#    MACOSX_BUNDLE_GUI_IDENTIFIER com.example.appIntroToQtQuick
    MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
    MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
    MACOSX_BUNDLE TRUE
    WIN32_EXECUTABLE TRUE
)

target_link_libraries(appIntroToQtQuick
    PRIVATE Qt6::Quick
)

include(GNUInstallDirs)
install(TARGETS appIntroToQtQuick
    BUNDLE DESTINATION .
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)
