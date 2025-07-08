import QtQuick
import QtQuick.Controls

Row{
    Rectangle{
        id:backward
        width: 24
        height: 35
        color: "transparent"
        border.color: "white"
        border.width: 1
        Image {
            source: "qrc:/back.png"
        }
        //鼠标事件
        TapHandler {
            onTapped: mainStack.pop()
        }
    }
    TextField{
        id:searchfield
        height: backward.height
        width:200
        color: "#afb5c3"
        leftPadding: 50
        placeholderText:"love story"
        font.pixelSize: 16
        font.family: "微软雅黑"
        background: Rectangle{//外部矩形
            radius: 8
            anchors.fill: parent
        }
        Image {
            scale: 0.9
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
            anchors.leftMargin: 16
            source: "qrc:/Src/image/search.png"
        }
        TapHandler{
            onTapped: {
                 searchPop.open()
            }
        }
    }

    Popup{
        id:searchPop
        width: parent.width+100
        height: 700
        y:searchfield.height+13
        clip:true
        background: Rectangle{
            anchors.fill: parent
            radius: 8
            clip: true
            color: "#ffffff"
            Flickable{
                anchors.fill: parent
                contentHeight: 1200
                ScrollBar.vertical: ScrollBar{
                    anchors.right: parent.right
                    anchors.rightMargin: 5
                    width: 10
                }
                Column{
                    anchors.fill: parent
                    spacing: 40
                    Item{
                        id:searchtotal
                        anchors.left: parent.left
                        anchors.right: parent.right
                        //height: history.implicitHeight+singflow.implicitHeight+50
                        height: 150
                        Item {
                            id: history
                            anchors.left: parent.left
                            anchors.right: parent.right
                            anchors.top: parent.top
                            anchors.topMargin: 30
                            anchors.leftMargin: 30
                            Label{
                                id:searchname
                                text: "搜索历史"
                                color: "#283248"
                                font.pixelSize: 18
                                font.family: "微软雅黑"
                            }
                            Image {
                                id: removeim
                                source: "qrc:/delete.png"
                                anchors.right: parent.right
                                anchors.rightMargin: 30
                                anchors.verticalCenter: searchname.verticalCenter
                                TapHandler{
                                    onTapped: {
                                        historymod.clear()
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }

    Rectangle{
        id:songsing
        height: backward.height
        width:height
        color:"#f7eef6"
        border.color: "#f2e4ed"
        border.width: 1
        Image {
            id:sing
            anchors.centerIn: parent
            source: "qrc:/Src/image/sing.png"
            HoverHandler{
                onHoveredChanged: {
                    if(hovered){
                        songsing.opacity=0.5
                    }else{
                        songsing.opacity=1
                    }
                }
            }
            Behavior on opacity {
                PropertyAnimation{
                    duration: 100
                }
            }
        }
    }
}
