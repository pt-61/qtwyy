import QtQuick

Item {
    //宽度定义位于 LeftSelectors.qml
    height: publicItem_Height * publicModel.count + publicItem_Spacing * (publicModel.count - 1)

    //成员高度
    property double publicItem_Height
    //成员间隔
    property double publicItem_Spacing
    //标签字体颜色
    property color publicItem_LableColor

    //选项列布局
    Column {
        width: parent.width
        spacing: publicItem_Spacing
        //选项设计
        OptionRep {
            anchors.fill: parent
            model: publicModel
            optionRepItem_Height: publicItem_Height
            currentSpace: 0         //区域 0
        }

        ListModel {
            id: publicModel
            ListElement {name: "精选"; URL: "qrc:/Src/Stack/Cherry/Cherry.qml"}
            ListElement {name: "coming"; URL: "qrc:/Src/Stack/Coming.qml"}
        }
    }
}
