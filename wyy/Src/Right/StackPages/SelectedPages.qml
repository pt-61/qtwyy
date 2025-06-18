import QtQuick 2.15
import QtQuick.Controls 2.15

Item {
    id: selectedPages
    Item {
        anchors {
            fill: parent
            leftMargin: 36
            rightMargin: 24
        }
        Flow {
            id: titleFlow
            height: 25
            anchors {
                left: parent.left
                top: parent.top
            }
            spacing: 20
            Repeater {
                id: selectorRep
                anchors.fill: parent
                model: ["精选", "歌单广场", "排行榜", "歌手"]
                property int selectedIndex: 0
                Behavior on opacity {
                    PropertyAnimation{
                        duration: 200
                    }
                }
                Item {
                    width: selectorLabel.implicitWidth + 10
                    height: 40
                    Label {
                        id: selectorLabel
                        anchors.centerIn: parent
                        text: modelData
                        font {
                            pixelSize: 20
                            family: "黑体"
                            bold: true
                        }
                        color: selectorRep.selectedIndex === index ? "black" : "#a1a1a3"
                    }
                    //选中指示器
                    Rectangle {
                        height: 3
                        anchors {
                            top: selectorLabel.bottom
                            topMargin: 3
                            left: selectorLabel.left
                            leftMargin: selectorLabel.implicitWidth / selectorLabel.font.pixelSize * 2
                            right: selectorLabel.right
                            rightMargin: selectorLabel.implicitWidth / selectorLabel.font.pixelSize * 2
                        }
                        color: "#eb4d44"
                        visible: selectorRep.selectedIndex === index
                    }
                    //鼠标操作
                    MouseArea {
                        anchors.fill: parent
                        hoverEnabled: true
                        onEntered: {
                            if(selectorRep.selectedIndex !== index) {
                                selectorLabel.opacity = 0.85
                            }
                            cursorShape = Qt.PointingHandCursor
                        }
                        onExited: {
                            if(selectorRep.selectedIndex !== index) {
                                selectorLabel.opacity = 1
                            }
                        }
                        onClicked: {
                            selectorRep.selectedIndex = index
                        }
                    }
                }
            }
        }

        StackView {
            id: chrryPickStackView
            anchors {
                top: titleFlow.bottom
                topMargin: 20
                bottom: parent.bottom
                left: parent.left
                leftMargin: -36
                right: parent.right
            }
            clip: true
            initialItem: "qrc:/Src/Right/StackPages/CherryPick/CherryPick.qml"
        }
    }
}
