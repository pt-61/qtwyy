import QtQuick

Flickable {
    id: cherryOptionFlick
    contentHeight: 2200
    clip: true

    //限制宽度
    property double limitedWidth: common.horCount === 2 ? width - 80 : width - 330

    Column {
        anchors {
            topMargin: spacing
            fill: parent
        }
        spacing: 20
        clip: true

        //轮播图
        CherryCarousel {
            carousel_Width: limitedWidth
        }
        //内容推荐
        CherryPlayerlist {
            playerList_Width: limitedWidth
        }
    }
}
