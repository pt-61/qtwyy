import QtQuick

Rectangle {
    color: "#f7f9fc"

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
