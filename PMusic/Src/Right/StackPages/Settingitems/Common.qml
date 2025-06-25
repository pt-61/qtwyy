import QtQuick 2.15
import QtQuick.Controls
Item {
    anchors.left: parent.left
    anchors.right: parent.right
    height: 400
    Label{
        id:counterlabel
        text: "常规"
        font.pixelSize: 22
        font.bold: true
        font.family: "黑体"
        anchors.left: parent.left
        color: "black"
    }
    Label{

    }
    //字体选择框
    ComboBox{
        id:fontselected
        width: 150
        height: 30
        anchors.left: parent.left
        anchors.top: counterlabel.bottom
        anchors.topMargin: 10
        background: Rectangle{
            anchors.fill: parent
            radius: parent.height/2
            border.width: 1
            border.color: "#1a1a20"
            MouseArea{

            }

        }
    popup: Popup{
        y:parent.height+5
        width: parent.width
        height: 150
        background: Rectangle{
            anchors.fill: parent
            radius: 10
            color: "#2d2d37"
            clip: true
            ListView{
                anchors.fill: parent
                model: ["默认","仿宋","华文仿宋","华文新魏","华文新黑","华文行书","华文楷书"]
                delegate: Rectangle{
                    width: fontselected.width-10
                    height: 40
                    color: "transparent"
                    Text {
                        text: modelData
                        color: "#d6d6d8"
                        font.pixelSize: 16
                        anchors.left: parent.left
                        anchors.leftMargin: 10
                        anchors.verticalCenter: parent.verticalCenter
                        MouseArea{
                            anchors.fill: parent
                            hoverEnabled: true
                            onEntered: {
                                parent.color="#393943"
                                cursorShape=Qt.PointingHandCursor
                            }
                            onExited: {
                                parent.color="transparent"
                                cursorShape=Qt.ArrowCursor
                            }
                            onClicked: {

                                fontselected.popup.close()
                            }
                        }
                    }

                }
            }
        }

    }
    }
}
