import QtQuick
import QtQuick.Controls

Rectangle {
    color: "yellow"

    Text {
        anchors.centerIn: parent
        text: "Cherry"
        font {
            pixelSize: 24
            family: "黑体"
            bold: true
        }
    }

    //列布局宽度
    property double cherryColumn_Width: common.horCount === 2 ? parent.width - 80 : parent.width - 330
    //抬头高度
    property double cherrySelector_Height: 40
    //堆栈高度
    property double cherryStack_Height: height - cherrySelector_Height
    Column {
        anchors.fill: parent
        //精选选项
        CherrySelector {
            width: cherryColumn_Width
            height: cherrySelector_Height
            anchors.horizontalCenter: parent.horizontalCenter
        }
        //堆栈
        StackView {
            id: cherryStack
            width: parent.width
            height: cherryStack_Height
            clip: true
            initialItem: "qrc:/Src/Stack/Cherry/CherryStack/cherryOption/CherryOption.qml"
        }
    }
}
