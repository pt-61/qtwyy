import QtQuick
import QtQuick.Controls
import "./Logo"
import "./ToolBar"
import "./LeftSelectors"

Rectangle {
    color: "yellow"

    Text {
        anchors.centerIn: parent
        text: "Basic"
        font {
            pixelSize: 24
            family: "黑体"
            bold: true
        }
    }

    property double topRow_height: commonBottom_Height
    property double centerRow_height: height - commonBottom_Height
    property double logo_width: 200
    property double toolBar_width: width - logo_width
    property double leftSelectors_width: logo_width
    property double mainStack_width: toolBar_width
    Column {
        anchors.fill: parent
        Row {
            id: topRow
            width: parent.width
            height: topRow_height
            //logo
            Logo {
                width: logo_width
                height: parent.height
            }
            //工具栏
            ToolBar {
                width: toolBar_width
                height: parent.height
            }
        }
        Row {
            width: parent.width
            height: centerRow_height
            //左侧选项
            LeftSelectors {
                width: leftSelectors_width
                height: centerRow_height
            }
            //堆栈
            StackView {
                id: mainStack
                width: mainStack_width
                height: parent.height
                clip: true
                initialItem: "qrc:/Src/Common/Basic/Stack/Cherry/Cherry.qml"
            }
        }
    }
}
