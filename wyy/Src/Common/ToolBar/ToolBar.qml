import QtQuick

Rectangle {
    color: "white"

    RightTop{
        id:righttop
        anchors.right: parent.right
        anchors.verticalCenter: parent.verticalCenter
    }

    Usersetting {
        anchors.right: righttop.left
        anchors.rightMargin: 200
        anchors.verticalCenter: parent.verticalCenter
    }

    Search{
        anchors.left: parent.left
        anchors.verticalCenter: parent.verticalCenter
    }
}
