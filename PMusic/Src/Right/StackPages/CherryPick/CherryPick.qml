import QtQuick

Item {
    Flickable {
        id: flick
        contentHeight: 2200
        anchors.fill: parent
        clip: true
        property double insideWidth: width * 0.9
        property bool incarouselSpace: false
        property int horCount: 2
        Column {
            anchors {
                topMargin: 20
                fill: parent
            }
            spacing: 30
            clip: true

            //轮播图
            CherryCarousel {}
            //内容推荐
            CherryPlayerlist {}
        }
    }
}
