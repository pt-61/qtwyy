import QtQuick

Rectangle {
    color: "yellow"

    Text {
        anchors.centerIn: parent
        text: "PublicOption"
        font {
            pixelSize: 24
            family: "黑体"
            bold: true
        }
    }

    height: selectorsItem_Height * publicModel.count + leftColumn_Spacing * (publicModel.count - 1)
    //选项列布局
    Column {
        width: parent.width
        spacing: leftColumn_Spacing
        //选项设计
        OptionRep {
            //id: publicOptionRep
            anchors.fill: parent
            model: publicModel
            currentSpace: 0         //区域0
        }

        ListModel {
            id: publicModel
            ListElement {name: "精选"; link: ""}
            ListElement {name: "coming"; link: ""}
            ListElement {name: "coming"; link: ""}
        }
    }
}
