import QtQuick
import QtQuick.Controls

Item {
    //宽度定义位于 LeftSelectors.qml
    height: selectorsItem_Height * (personalModel.count + 1) + leftColumn_Spacing * personalModel.count
    //选项列布局
    Column {
        width: parent.width
        spacing: leftColumn_Spacing
        //标签
        Item {
            width: selectorsItem_Width
            height: selectorsItem_Height
            Label {
                anchors {
                    left: parent.left
                    leftMargin: 10
                    verticalCenter: parent.verticalCenter
                }
                text: "我的"
                font {
                    pixelSize: 18
                    family: "黑体"
                }
                color: labelColor
                opacity: 0.95
            }
        }
        //选项设计
        OptionRep {
            anchors.fill: parent
            model: personalModel
            currentSpace: 1         //区域
        }

        ListModel {
            id: personalModel
            ListElement {name: "我的歌单"; link: ""}
            ListElement {name: "coming"; link: ""}
            ListElement {name: "coming"; link: ""}
            ListElement {name: "coming"; link: ""}
        }
    }
}
