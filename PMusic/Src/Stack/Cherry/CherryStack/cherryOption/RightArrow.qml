import QtQuick

Item {
    height: parent.height
    width: 25
    anchors.right: parent.right
    visible: false
    opacity: 0.6
    //图片
    Image {
        anchors.centerIn: parent
        source: "qrc:/Src/image/rightArrow.png"
    }
}
