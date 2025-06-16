import QtQuick 2.15
import"../RightTop"
Rectangle{
    //搜索
    Search{
        id:searchrow
        anchors.left: parent.left
        anchors.leftMargin: 36
        anchors.verticalCenter: other.verticalCenter
        spacing: 5
    }

    Usersetting{
        id:other
        anchors.right: topright.left
        anchors.rightMargin: 10
        anchors.verticalCenter: topright.verticalCenter
        spacing: 5
    }
    RightTop{
        id:topright
       // anchors.left: parent.left
        anchors.right: parent.right
        height: 66
        color: "#f7f9fc"
        anchors.top: parent.top
        width: 200
    }
}
