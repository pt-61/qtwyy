import QtQuick
import QtQuick.Controls

Repeater {
    //成员高度
    property double optionRepItem_Height
    //当前的区域位置
    property int currentSpace

    Item {
        width: parent.width
        height: optionRepItem_Height
        clip: true
        //选项指示器
        Rectangle {
            width: parent.width
            height: parent.height
            color: "red"
            radius: 10
            visible: (selectedIndex === index && whichSpace === currentSpace)
        }
        //选项标签
        Label {
            anchors {
                left: parent.left
                leftMargin: parent.height
                verticalCenter: parent.verticalCenter
            }
            text: name
            font {
                pixelSize: 20
                family: "黑体"
                bold: true
            }
            color: (selectedIndex === index && whichSpace === currentSpace) ? "white" : labelColor
        }
        //选项指示高亮
        Rectangle {
            id: optionHighlightRec
            width: parent.width
            height: parent.height
            color: "gray"
            radius: 10
            opacity: 0.1
            visible: false
        }
        //鼠标事件
        HoverHandler {
            cursorShape: Qt.PointingHandCursor
            onHoveredChanged: {
                if(hovered)
                    optionHighlightRec.visible = true
                else
                    optionHighlightRec.visible = false
            }
        }
        TapHandler {
            onTapped: {
                selectedIndex = index
                whichSpace = currentSpace
                mainStack.push(URL)
            }
        }
    }
}
