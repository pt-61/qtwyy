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
            Item {
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
                    color: cherrySelectorRap.selectedIndex === index ? "black" : basicLabelColor
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
                HoverHandler {
                    cursorShape: Qt.PointingHandCursor
                    onHoveredChanged: {
                        if(hovered && cherrySelectorRap.selectedIndex !== index)
                            cherryLabel.opacity = 0.8
                        else
                            cherryLabel.opacity = 1
                    }
                }
                TapHandler {
                    onTapped: {
                        cherrySelectorRap.selectedIndex = index
                        cherryStack.push(URL)
                    }
                }
            }
        }

        ListModel {
            id: cherrySelectorModel
            ListElement {name: "精选"; URL: "qrc:/Src/Stack/Cherry/CherryStack/cherryOption/CherryOption.qml"}
            ListElement {name: "coming"; URL: "qrc:/Src/Stack/Cherry/CherryStack/Coming.qml"}
        }
    }


}
