cmake_minimum_required(VERSION 3.27)

project(PMusic VERSION 0.1 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(Qt6 REQUIRED COMPONENTS Quick)

qt_standard_project_setup(REQUIRES 6.9)

qt_add_executable(appPMusic)

qt_add_qml_module(appPMusic
    URI PMusic
    VERSION 1.0
    SOURCES     main.cpp
    QML_FILES   Main.qml
    RESOURCES qml.qrc
    QML_FILES
    QML_FILES
    QML_FILES Src/Common/Common.qml
    QML_FILES
    QML_FILES Src/Common/Logo/Logo.qml
    QML_FILES Src/Common/ToolBar/ToolBar.qml
    QML_FILES Src/Common/LeftSelectors/LeftSelectors.qml
    QML_FILES Src/Common/Bottom/Bottom.qml
    QML_FILES Src/Common/LeftSelectors/SplitLine.qml
    QML_FILES Src/Common/LeftSelectors/OptionRep.qml
    QML_FILES Src/Common/LeftSelectors/PublicOption.qml
    QML_FILES Src/Common/LeftSelectors/PersonalOption.qml
    QML_FILES
    QML_FILES
    QML_FILES
    QML_FILES
    QML_FILES
    QML_FILES Src/Common/ToolBar/RightTop.qml
    QML_FILES Src/Common/ToolBar/Search.qml
    QML_FILES Src/Common/ToolBar/Usersetting.qml
    QML_FILES
    RESOURCES rec.qrc
    QML_FILES Src/Common/Bottom/Player.qml
    SOURCES songmodel.cpp songmodel.h
    SOURCES getimage.cpp getimage.h getlyrics.cpp getlyrics.h
    QML_FILES
    QML_FILES
    QML_FILES Src/Common/Bottom/Lywindow.qml
    QML_FILES

)

target_compile_features(appPMusic PRIVATE cxx_std_23)

target_link_libraries(appPMusic
    PRIVATE
        Qt6::Quick
        tag
)

set_target_properties(appPMusic PROPERTIES
    AUTORCC TRUE
#    MACOSX_BUNDLE_GUI_IDENTIFIER com.example.appPMusic
    MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
    MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
    MACOSX_BUNDLE TRUE
    WIN32_EXECUTABLE TRUE
)

include(GNUInstallDirs)
install(TARGETS appPMusic
    BUNDLE DESTINATION .
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)


















































# set(CMAKE_CXX_STANDARD_REQUIRED ON) # Globally preventing the fallback behaviour of C++ standard
#qt_add_executable(PMusic)  //Creates and finalizes an application target of a platform-specific type.
#This command performs the following tasks:
#    1. Create a CMake target of the appropriate type for the target platform.
#    2. Link the target to the Qt::Core library.
#    3. Handle finalization of the CMake target.

# set(CMAKE_CXX_STANDARD_REQUIRED ON) # Globally preventing the fallback behaviour of C++ standard

# qt_standard_project_setup()  #set(CMAKE_AUTOUIC ON)  set(CMAKE_AUTOMOC ON)






# cmake_minimum_required(VERSION 3.16)
#
# project(PMusic VERSION 0.1 LANGUAGES CXX)
#
# @if !true
# set(CMAKE_AUTOMOC ON)
# @endif
# set(CMAKE_CXX_STANDARD_REQUIRED ON)
#
# find_package(Qt6 REQUIRED COMPONENTS Quick)
#
# @if true
# @if true
# qt_standard_project_setup(REQUIRES 6.9)
# @else
# qt_standard_project_setup()
# @endif
# @endif
#
# qt_add_executable(appPMusic
#     main.cpp
# )
#
# qt_add_qml_module(appPMusic
#     URI PMusic
#     VERSION 1.0
#     QML_FILES
#         Main.qml
# )
#
# # Qt for iOS sets MACOSX_BUNDLE_GUI_IDENTIFIER automatically since Qt 6.1.
# # If you are developing for iOS or macOS you should consider setting an
# # explicit, fixed bundle identifier manually though.
# set_target_properties(appPMusic PROPERTIES
# #    MACOSX_BUNDLE_GUI_IDENTIFIER com.example.appPMusic
#     MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
#     MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
#     MACOSX_BUNDLE TRUE
#     WIN32_EXECUTABLE TRUE
# )
#
# target_link_libraries(appPMusic
#     PRIVATE Qt6::Quick
# )
#
# include(GNUInstallDirs)
# install(TARGETS appPMusic
#     BUNDLE DESTINATION .
#     LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
#     RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
# )
