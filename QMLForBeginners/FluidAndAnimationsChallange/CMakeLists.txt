cmake_minimum_required(VERSION 3.16)

project(FluidAndAnimationsChallange VERSION 0.1 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(Qt6 REQUIRED COMPONENTS Quick)

qt_standard_project_setup(REQUIRES 6.8)

qt_add_executable(appFluidAndAnimationsChallange
    main.cpp
)

qt_add_qml_module(appFluidAndAnimationsChallange
    URI FluidAndAnimationsChallange
    VERSION 1.0
    QML_FILES
        Main.qml
        RESOURCES assets/attribution.txt assets/home.svg assets/play.svg assets/rss.svg assets/settings.svg assets/table.svg assets/terminal.svg assets/wallpaper.jpg
        QML_FILES AppModel.qml
        QML_FILES ApplicationDelegate.qml
        QML_FILES AppPage.qml
)

# Qt for iOS sets MACOSX_BUNDLE_GUI_IDENTIFIER automatically since Qt 6.1.
# If you are developing for iOS or macOS you should consider setting an
# explicit, fixed bundle identifier manually though.
set_target_properties(appFluidAndAnimationsChallange PROPERTIES
#    MACOSX_BUNDLE_GUI_IDENTIFIER com.example.appFluidAndAnimationsChallange
    MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
    MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
    MACOSX_BUNDLE TRUE
    WIN32_EXECUTABLE TRUE
)

target_link_libraries(appFluidAndAnimationsChallange
    PRIVATE Qt6::Quick
)

include(GNUInstallDirs)
install(TARGETS appFluidAndAnimationsChallange
    BUNDLE DESTINATION .
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)
