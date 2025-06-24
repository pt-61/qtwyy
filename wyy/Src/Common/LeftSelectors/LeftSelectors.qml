import QtQuick

Rectangle {

    color: "red"


    Text {
        anchors.centerIn: parent
        text: "LeftSelectors"
        font {

            pixelSize: 20


            family: "黑体"
            bold: true
        }
    }


    property double selectorsItem_Width: width - 30
    property double selectorsItem_Height: 40
    property double leftColumn_Spacing: 5
    property int whichSpace: 0
    Item {
        width: selectorsItem_Width
        anchors {
            top: parent.top
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
