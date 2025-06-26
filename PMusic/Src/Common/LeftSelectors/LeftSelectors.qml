import QtQuick

Rectangle {
    color: leftColor
    //选项宽度
    property double selectorsItem_Width: width - 30
    //选项高度
    property double selectorsItem_Height: 40
    //选项间隔
    property double leftColumn_Spacing: 5
    //鼠标触发时的区域位置
    property int whichSpace: 0
    //标签颜色
    property color labelColor: basicLabelColor
    Item {
        width: selectorsItem_Width
        anchors {
            top: parent.top
            topMargin: leftColumn_Spacing
            horizontalCenter: parent.horizontalCenter
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
                    //高度定义位于 PublicOption.qml
                }
                //分割线
                SplitLine {}
                //个人选项
                PersonalOption {
                    width: parent.width
                    //高度定义位于 PersonalOption.qml
                }
            }
        }


    }


}
