import QtQuick

Item {
    height: parent.height
    width: 25
    anchors.left: parent.left
    visible: false
    opacity: 0.6
    //图片
    Image {
        anchors.centerIn: parent
        mirror: true
        source: "qrc:/Src/image/rightArrow.png"
    }
}
