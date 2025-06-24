import QtQuick
import QtQuick.Controls

Rectangle {
    color: "green"

    Text {
        anchors.centerIn: parent
        text: "CherrySelector"
        font {
            pixelSize: 24
            family: "黑体"
            bold: true
        }
    }

    //选项行布局
    Row {
        height: parent.height * 0.625
        anchors {
            left: parent.left
            verticalCenter: parent.verticalCenter
        }
        spacing: 20
        //选项设计
        Repeater {
            id: cherrySelectorRap
            anchors.fill: parent
            model: cherrySelectorModel
            property int selectedIndex: 0
            Rectangle {
                color: "white"

                width: cherryLabel.width + 10
                height: parent.height
                clip: true
                //选项标签
                Label {
                    id: cherryLabel
                    anchors {
                        top: parent.top
                        horizontalCenter: parent.horizontalCenter
                    }
                    text: name
                    font {
                        pixelSize: 20
                        family: "黑体"
                        bold: true
                    }
                    color: cherrySelectorRap.selectedIndex === index ? "black" : "gray"
                }
                //选项指示器
                Rectangle {
                    width: parent.width - 15
                    height: 3
                    anchors {
                        bottom: parent.bottom
                        horizontalCenter: cherryLabel.horizontalCenter
                    }
                    color: "red"
                    visible: cherrySelectorRap.selectedIndex === index
                }
                //鼠标事件
                TapHandler {
                    onTapped: {
                        cherrySelectorRap.selectedIndex = index
                        cherryStack.push(link)
                    }
                }
                HoverHandler {
                    cursorShape: Qt.PointingHandCursor
                }
            }
        }

        ListModel {
            id: cherrySelectorModel
            ListElement {name: "精选"; link: ""}
            ListElement {name: "歌单广场"; link: ""}
            ListElement {name: "排行榜"; link: ""}
            ListElement {name: "歌手"; link: ""}
        }
    }


}
