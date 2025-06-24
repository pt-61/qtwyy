import QtQuick
import QtQuick.Controls

Repeater {
    id: optionRep
    property int selectedIndex: 0
    property int currentSpace: 0
    property alias spaceNumber: optionRep.currentSpace
    Rectangle {
        color: "white"

        width: parent.width
        height: selectorsItem_Height
        clip: true


        //选项指示器
        Rectangle {
            width: parent.width
            height: parent.height
            color: "red"
            radius: 10
            visible: (selectedIndex === index && whichSpace === spaceNumber)
        }
        //选项标签
        Label {
            anchors {
                left: parent.left
                leftMargin: 40
                verticalCenter: parent.verticalCenter
            }
            text: name
            font {
                pixelSize: 20
                family: "黑体"
                bold: true
            }
            color: (selectedIndex === index && whichSpace === spaceNumber) ? "white" : "gray"
        }
        //鼠标事件
        TapHandler {
            onTapped: {
                selectedIndex = index
                whichSpace = spaceNumber
                mainStack.push(link)
            }
        }
        HoverHandler {
            cursorShape: Qt.PointingHandCursor
        }
    }
}
