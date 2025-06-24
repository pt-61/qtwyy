import QtQuick

Rectangle {
    color: "white"

    width: selectorsItem_Width
    height: selectorsItem_Height
    Rectangle {
        width: parent.width - 20
        height: 1
        anchors.centerIn: parent
        color: "gray"
        opacity: 0.5
    }
}
