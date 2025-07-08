import QtQuick
import QtQuick.Controls

Rectangle {
    //选项宽度
    property double selectorsItem_Width: width - 40
    //选项高度
    property double selectorsItem_Height: 40
    //选项间隔
    property double leftColumn_Spacing: 5
    //标签颜色
    property color labelColor

    //选中的索引
    property int selectedIndex: 0
    //鼠标触发时的区域位置
    property int whichSpace: 1

    Item {
        width: selectorsItem_Width
        anchors {
            top: parent.top
            topMargin: leftColumn_Spacing
            left: parent.left
            leftMargin: 25
        }
        Flickable {
            id: selectorsFlick
            anchors.fill: parent
            contentHeight: 2000
            Column {
                id: leftColumn
                anchors.fill: parent
                spacing: leftColumn_Spacing
                //公共选项
                PublicOption {
                    width: parent.width
                    //高度定义位于 Options.qml
                    publicItem_Height: selectorsItem_Height
                    publicItem_Spacing: leftColumn_Spacing
                    publicItem_LableColor: labelColor
                }
                //分割线
                SplitLine {}
                //"我的"标签
                Label {
                    anchors {
                        left: parent.left
                        leftMargin: 10
                    }
                    text: "我的"
                    font {
                        pixelSize: 18
                        family: "黑体"
                    }
                    color: labelColor
                    opacity: 0.95
                }
                //个人选项
                PersonalOption {
                    width: parent.width
                    //高度定义位于 PersonalOption.qml
                    personalItem_Height: selectorsItem_Height
                    personalItem_Spacing: leftColumn_Spacing
                    personalItem_LableColor: labelColor
                }
            }
        }
    }
}
