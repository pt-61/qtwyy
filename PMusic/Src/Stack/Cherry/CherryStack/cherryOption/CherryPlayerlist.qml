import QtQuick
import QtQuick.Controls
import Qt5Compat.GraphicalEffects

Item {
    id: cherryPlayerlist
    width: parent.width
    height: cherryPlaylistLabel.height + playerListImg_Height + cherryPlayerlistColumn.spacing

    //官方歌单区域宽度
    property double playerList_Width
    //控制区域宽度
    property double playerListSapce_Width: playerList_Width + playerListLArrow.width + playerListRArrow.width
    //宣传图间隔
    property double playerListImg_Spacing: 20
    //宣传图宽度
    property double playerListImg_Width: (playerList_Width - playerListImg_Spacing * (common.horCount * 2 - 1)) / (common.horCount * 2)
    //宣传图高度
    property double playerListImg_Height: playerListImg_Width + 50

    //向左移动动画
    NumberAnimation {
        id: cPlayerListLAnimation
        target: cPlayerList
        properties: "currentIndex"
        from: cPlayerList.currentIndex
        to: cPlayerList.currentIndex + 1
        duration: 100
    }
    //向右移动动画
    NumberAnimation {
        id: cPlayerListRAnimation
        target: cPlayerList
        properties: "currentIndex"
        from: cPlayerList.currentIndex
        to: cPlayerList.currentIndex - 1
        duration: 100
    }

    Column {
        id: cherryPlayerlistColumn
        anchors.fill: parent
        spacing: 10
        //官方歌单标题
        Item {
            width: playerList_Width
            height: cherryPlaylistLabel.height
            anchors.horizontalCenter: parent.horizontalCenter
            //官方歌单标签
            Label {
                id: cherryPlaylistLabel
                anchors.left: parent.left
                text: "官方歌单 >"
                color: "black"
                font {
                    pixelSize: 20
                    family: "黑体"
                    bold: true
                }
                //鼠标事件
                HoverHandler {
                    cursorShape: Qt.PointingHandCursor
                }
                TapHandler {
                    onTapped: {
                        cherryStack.push("qrc:/Src/Stack/Cherry/CherryStack/ListSquare.qml")
                        cherrySelector.selectedIndex = 1
                    }
                }
            }
        }

        //控制区域
        Item {
            width: playerListSapce_Width
            height: playerListImg_Height
            anchors.horizontalCenter: parent.horizontalCenter
            //鼠标事件
            HoverHandler {
                onHoveredChanged: {
                    if(hovered && cPlayerListModel.count > 5) {
                        playerListLArrow.visible = common.horCount !== 3
                        playerListRArrow.visible = common.horCount !== 3
                    }
                    else {
                        playerListLArrow.visible = false
                        playerListRArrow.visible = false
                    }
                }
            }
            //左箭头
            LeftArrow {
                id: playerListLArrow
                opacity: cPlayerList.currentIndex !== 0 ? 0.6 : 0.2
                //鼠标事件
                HoverHandler {
                    cursorShape: cPlayerList.currentIndex !== 0 ? Qt.PointingHandCursor : Qt.ArrowCursor
                    onHoveredChanged: {
                        if(hovered)
                            playerListLArrow.opacity = cPlayerList.currentIndex !== 0 ? 1 : 0.2
                        else
                            playerListLArrow.opacity = cPlayerList.currentIndex !== 0 ? 0.6 : 0.2
                    }
                }
                TapHandler {
                    onTapped: {
                        if(cPlayerList.currentIndex !== 0) {
                            playerListRArrow.opacity = 0.6
                            cPlayerListRAnimation.start()
                        }
                        if(cPlayerList.currentIndex === 1)
                            playerListLArrow.opacity = 0.2
                    }
                }
            }
            //右箭头
            RightArrow {
                id: playerListRArrow
                opacity: cPlayerList.currentIndex !== 2 ? 0.6 : 0.2
                //鼠标事件
                HoverHandler {
                    cursorShape: cPlayerList.currentIndex !== 2 ? Qt.PointingHandCursor : Qt.ArrowCursor
                    onHoveredChanged: {
                        if(hovered)
                            playerListRArrow.opacity = cPlayerList.currentIndex !== 2 ? 1 : 0.2
                        else
                            playerListRArrow.opacity = cPlayerList.currentIndex !== 2 ? 0.6 : 0.2
                    }
                }
                TapHandler {
                    onTapped: {
                        if(cPlayerList.currentIndex !== 2) {
                            playerListLArrow.opacity = 0.6
                            cPlayerListLAnimation.start()
                        }
                        if(cPlayerList.currentIndex === 1)
                            playerListRArrow.opacity = 0.2
                    }
                }
            }
            //官方歌单区域
            Item {
                width: playerList_Width
                height: parent.height
                anchors.horizontalCenter: parent.horizontalCenter
                clip: true
                //图片区域
                PathView {
                    id: cPlayerList
                    width: (pathItemCount + 1) * playerListImg_Width + pathItemCount * playerListImg_Spacing + 1
                    height: playerListImg_Height
                    anchors {
                        left: parent.left
                        leftMargin: - (playerListImg_Width + playerListImg_Spacing)
                    }
                    model: cPlayerListModel
                    path: cPlayerListPath
                    pathItemCount: cPlayerListModel.count
                    interactive: false
                    //委托
                    delegate: Item {
                        width: cherryPlayerlist.playerListImg_Width
                        height: cherryPlayerlist.playerListImg_Height
                        clip: true
                        //鼠标事件
                        HoverHandler {
                            cursorShape: Qt.PointingHandCursor
                            onHoveredChanged: {
                                if(hovered) {
                                    cPlaylistItemUAnimation.start()
                                }
                                else {
                                    cPlaylistItemDAnimation.start()
                                }
                            }
                        }
                        TapHandler {
                            onTapped: {
                                mainStack.push(URL)
                                //leftSelectors.selectedIndex = 0
                                leftSelectors.whichSpace = 9
                            }
                        }

                        //详情上移动画
                        ParallelAnimation {
                            id: cPlaylistItemUAnimation
                            NumberAnimation {
                                target: cPlaylistRec
                                properties: "y"
                                from: cPlaylistRec.width
                                to: 0
                                duration: 100
                            }
                            NumberAnimation {
                                target: cPlaylistText
                                properties: "y"
                                from: playerListImg_Width
                                to: playerListImg_Height * 0.4
                                duration: 100
                            }
                        }
                        //详情下移动画
                        ParallelAnimation {
                            id: cPlaylistItemDAnimation
                            NumberAnimation {
                                target: cPlaylistRec
                                properties: "y"
                                from: 0
                                to: cPlaylistRec.width
                                duration: 100
                            }
                            NumberAnimation {
                                target: cPlaylistText
                                properties: "y"
                                from: playerListImg_Height * 0.4
                                to: playerListImg_Width
                                duration: 100
                            }
                        }

                        //宣传图组件
                        Item {
                            id: cPlayerListItem
                            anchors.fill: parent
                            visible: false
                            Column {
                                anchors.fill: parent
                                //图片
                                Item {
                                    id: cPlayerListImg
                                    width: parent.width
                                    height: width
                                    Image {
                                        anchors.fill: parent
                                        source: img
                                    }
                                }
                                //组件Rec
                                Rectangle {
                                    width: parent.width
                                    height: parent.height - cPlayerListImg.height
                                    color: "gray"
                                }
                            }
                            //高亮组件Rec
                            Rectangle {
                                id: cPlaylistRec
                                width: parent.width
                                height: parent.height
                                y: width
                                radius: 10
                                gradient: Gradient {
                                    GradientStop {position: 0; color: "transparent"}
                                    GradientStop {position: 1; color: "gray"}
                                }
                            }
                            //文字组件
                            Item {
                                id: cPlaylistText
                                width: parent.width
                                height: parent.height * 0.6
                                y: parent.width
                                //标题
                                Item {
                                    id: cPlaylistTextLabel
                                    width: parent.width - 20
                                    height: 40
                                    anchors {
                                        top: parent.top
                                        topMargin: 5
                                        horizontalCenter: parent.horizontalCenter
                                    }
                                    clip: true
                                    Label {
                                        width: parent.width
                                        anchors.top: parent.top
                                        text: listName
                                        color: "white"
                                        font {
                                            pixelSize: 18
                                            family: "黑体"
                                            bold: true
                                        }
                                        wrapMode: TextEdit.Wrap
                                    }
                                }
                                //列表内容预览
                                Item {
                                    width: cPlaylistTextLabel.width
                                    height: 80
                                    anchors {
                                        bottom: parent.bottom
                                        bottomMargin: 5
                                        horizontalCenter: parent.horizontalCenter
                                    }
                                    Column {
                                        anchors.fill: parent
                                        spacing: 10
                                        Row {
                                            Item {
                                                id: cPlaylistTextNum_1
                                                width: 20
                                                height: 20
                                                Text {
                                                    anchors.centerIn: parent
                                                    text: "1"
                                                    color: "white"
                                                    font {
                                                        pixelSize: 16
                                                        family: "黑体"
                                                    }
                                                }
                                            }
                                            Item {
                                                width: cPlaylistTextLabel.width - cPlaylistTextNum_1.width
                                                height: cPlaylistTextNum_1.height
                                                Text {
                                                    anchors.centerIn: parent
                                                    text: songName1
                                                    font {
                                                        pixelSize: 16
                                                        family: "黑体"
                                                    }
                                                }
                                            }
                                        }
                                        Row {
                                            Item {
                                                id: cPlaylistTextNum_2
                                                width: 20
                                                height: 20
                                                Text {
                                                    anchors.centerIn: parent
                                                    text: "2"
                                                    color: "white"
                                                    font {
                                                        pixelSize: 16
                                                        family: "黑体"
                                                    }
                                                }
                                            }
                                            Item {
                                                width: cPlaylistTextLabel.width - cPlaylistTextNum_2.width
                                                height: cPlaylistTextNum_2.height
                                                Text {
                                                    anchors.centerIn: parent
                                                    text: songName2
                                                    font {
                                                        pixelSize: 16
                                                        family: "黑体"
                                                    }
                                                }
                                            }
                                        }
                                        Row {
                                            Item {
                                                id: cPlaylistTextNum_3
                                                width: 20
                                                height: 20
                                                Text {
                                                    anchors.centerIn: parent
                                                    text: "3"
                                                    color: "white"
                                                    font {
                                                        pixelSize: 16
                                                        family: "黑体"
                                                    }
                                                }
                                            }
                                            Item {
                                                width: cPlaylistTextLabel.width - cPlaylistTextNum_3.width
                                                height: cPlaylistTextNum_3.height
                                                Text {
                                                    anchors.centerIn: parent
                                                    text: songName3
                                                    font {
                                                        pixelSize: 16
                                                        family: "黑体"
                                                    }
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                        }
                        //圆角遮罩Rectangle
                        Rectangle {
                            id: cPlayerListMaskRec
                            width: parent.width
                            height: parent.height
                            anchors.centerIn: parent
                            color: "transparent"
                            Rectangle {
                                width: parent.width
                                height: parent.height
                                anchors.centerIn: parent
                                color: "black"
                                radius: 10
                            }
                            visible: false
                        }
                        //遮罩后的图片
                        OpacityMask {
                            anchors.fill: parent
                            source: cPlayerListItem
                            maskSource: cPlayerListMaskRec
                        }
                    }
                }

                ListModel {
                    id: cPlayerListModel
                    ListElement {
                        img: "qrc:/Src/image/blackImg.png"
                        URL: ""
                        listName: "占位"
                        songName1: "占位"
                        songName2: "占位"
                        songName3: "占位"
                    }
                    ListElement {
                        img: "qrc:/Src/image/blackImg.png"
                        URL: "qrc:/Src/Stack/LocalList/LocalList.qml"
                        listName: "我的歌单"
                        songName1: ""
                        songName2: ""
                        songName3: ""
                    }
                    ListElement {
                        img: "qrc:/Src/image/blackImg.png"
                        URL: "qrc:/Src/Stack/Coming.qml"
                        listName: "coming"
                        songName1: ""
                        songName2: ""
                        songName3: ""
                    }
                    ListElement {
                        img: "qrc:/Src/image/blackImg.png"
                        URL: ""
                        listName: ""
                        songName1: ""
                        songName2: ""
                        songName3: ""
                    }
                }

                Path {
                    id: cPlayerListPath
                    startX: playerListImg_Width/ 2
                    startY: playerListImg_Height / 2
                    PathLine {
                        x: cPlayerList.width - playerListImg_Width / 2
                        y: playerListImg_Height / 2
                    }
                }
            }
        }
    }
}
