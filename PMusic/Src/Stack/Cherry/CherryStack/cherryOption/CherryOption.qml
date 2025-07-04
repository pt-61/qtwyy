import QtQuick

Item {
    Flickable {
        contentHeight: 2200
        anchors.fill: parent
        clip: true
        Column {
            anchors {
                topMargin: spacing
                fill: parent
            }
            spacing: 20
            clip: true

            //轮播图
            CherryCarousel {}
            //内容推荐
            //CherryPlayerlist {}
        }
    }
}
