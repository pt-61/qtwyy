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

    //选项区域
    Rectangle {
        color: "orange"

        Text {
            anchors.centerIn: parent
            text: "cherrySelectorSpace"
            font {
                pixelSize: 24
                family: "黑体"
                bold: true
            }
        }

        width: cherryItem_Width
        height: parent.height * 0.625
        anchors.centerIn: parent
        //选项布局
        Row {
            anchors.fill: parent
            spacing: 20
            //选项设计
            Repeater {
                id: cherrySelectorRap
                anchors.fill: parent
                model: ["精选", "歌单广场", "排行榜", "歌手"]
                property int selectedIndex: 0
                Rectangle {
                    color: "white"

                    width: cherryLabel.width + 10
                    height: parent.height
                    //选项标签
                    Label {
                        id: cherryLabel
                        height: parent.height * 0.8
                        anchors {
                            top: parent.top
                            horizontalCenter: parent.horizontalCenter
                        }

                        text: modelData
                        font {
                            pixelSize: 20
                            family: "黑体"
                            bold: true
                        }
                        color: cherrySelectorRap.selectedIndex === index ? "black" : "#a1a1a3"
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
                        onTapped: cherrySelectorRap.selectedIndex = index
                    }
                    HoverHandler {
                        cursorShape: Qt.PointingHandCursor
                    }
                }
            }
        }
    }


}
