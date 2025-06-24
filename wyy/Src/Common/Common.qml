import QtQuick
import QtQuick.Controls
import "./Logo"
import "./ToolBar"
import "./LeftSelectors"
import "./Bottom"

Rectangle {
    color: "gray"

    Text {
        anchors.centerIn: parent
        text: "Common"
        font {
            pixelSize: 24
            family: "黑体"
            bold: true
        }
    }

    property double topRow_Height: 50                                           //顶部行布局高度
    property double centerRow_Height: height - topRow_Height - bottom_Height    //中部行布局高度
    property double bottom_Height: 70                                         //底部布局高度
    property double left_Width: 200                                             //左侧宽度
    property double right_Width: width - left_Width                             //右侧宽度
    Column {
        anchors.fill: parent
        //顶部行布局
        Row {
            width: parent.width
            height: topRow_Height
            //logo布局
            Logo {
                width: left_Width
                height: parent.height
                clip: true
            }
            //工具栏布局
            ToolBar {
                width: right_Width
                height: parent.height
                clip: true
                DragHandler{
                    onActiveChanged: {
                        if(active)window.startSystemMove()
                    }
                }
            }
        }
        //中部行布局
        Row {
            width: parent.width
            height: centerRow_Height
            //左侧选项布局
            LeftSelectors {
                width: left_Width
                height: parent.height
                clip: true
            }
            //堆栈
            StackView {
                id: mainStack
                width: right_Width
                height: parent.height
                clip: true
                initialItem: "qrc:/Src/Common/Stack/Cherry/Cherry.qml"
            }
        }
        //底部布局
        Bottom {
            id: bottom
            width: parent.width
            height: bottom_Height
        }
    }
}
