import QtQuick

Item {
    //宽度定义位于 LeftSelectors.qml
    height: personalItem_Height * (personalModel.count + 1) + personalItem_Spacing * personalModel.count

    //成员高度
    property double personalItem_Height
    //成员间隔
    property double personalItem_Spacing
    //标签字体颜色
    property color personalItem_LableColor

    //选项列布局
    Column {
        width: parent.width
        spacing: personalItem_Spacing
        //选项设计
        OptionRep {
            anchors.fill: parent
            model: personalModel
            optionRepItem_Height: personalItem_Height
            currentSpace: 1         //区域 1
        }

        ListModel {
            id: personalModel
            ListElement {name: "我的歌单"; URL: "qrc:/Src/Stack/LocalList/LocalList.qml"}
            ListElement {name: "coming"; URL: "qrc:/Src/Stack/Coming.qml"}
        }
    }
}
