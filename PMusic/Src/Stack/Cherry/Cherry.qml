import QtQuick
import QtQuick.Controls

Item {
    //限制宽度
    property double limitedWidth: common.horCount === 2 ? width - 80 : width - 330
    //抬头高度
    property double cherrySelector_Height: 40
    //堆栈高度
    property double cherryStack_Height: height - cherrySelector_Height

    Column {
        anchors.fill: parent
        //精选选项
        CherrySelector {
            id: cherrySelector
            width: limitedWidth
            height: cherrySelector_Height
            anchors.horizontalCenter: parent.horizontalCenter
            selectedIndex: 0
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
