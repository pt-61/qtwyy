import QtQuick

Rectangle {
    color: rightColor

    Text {
        anchors.centerIn: parent
        text: "ToolBar"
        font {
            pixelSize: 24
            family: "黑体"
            bold: true
        }
    }

    Usersetting {
        anchors.left: parent.left
    }
}
