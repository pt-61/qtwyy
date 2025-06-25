import QtQuick

Item {
    //宽度定义位于 LeftSelectors.qml
    height: selectorsItem_Height * publicModel.count + leftColumn_Spacing * (publicModel.count - 1)
    //选项列布局
    Column {
        width: parent.width
        spacing: leftColumn_Spacing
        //选项设计
        OptionRep {
            anchors.fill: parent
            model: publicModel
            currentSpace: 0         //区域0
        }

        ListModel {
            id: publicModel
            ListElement {name: "精选"; link: "qrc:/Src/Stack/Cherry/Cherry.qml"}
            ListElement {name: "coming"; link: ""}
            ListElement {name: "coming"; link: ""}
        }
    }
}
