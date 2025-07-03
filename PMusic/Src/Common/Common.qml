import QtQuick
import QtQuick.Controls
import "./Logo"
import "./ToolBar"
import "./LeftSelectors"
import "./Bottom"

Rectangle {
    id:common
    color: "#f7f9fc"

    Text {
        anchors.centerIn: parent
        text: "Common"
        font {
            pixelSize: 24
            family: "黑体"
            bold: true
        }
    }


    signal buttoncilck(string msg)
    property string songsource: ""
    //顶部行布局高度
    property double topRow_Height: 50
    //中部行布局高度
    property double centerRow_Height: height - topRow_Height - bottom_Height
    //底部布局高度
    property double bottom_Height: 70
    //左侧宽度
    property double left_Width: 200
    //右侧宽度
    property double right_Width: width - left_Width
    //左侧底色
    property color leftColor: "white"
    //右侧底色
    property color rightColor: "red"
    //底部底色
    property color bottomColor: "blue"
    //标准标签颜色
    property color basicLabelColor: "gray"
    Column {
        anchors.fill: parent
        //顶部行布局
        Row {
            anchors.left: parent.left
            anchors.right: parent.right
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
            }
            DragHandler{
                onActiveChanged: {
                    if(active)window.startSystemMove()
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
            Rectangle {
                color: rightColor
                width: right_Width
                height: parent.height
                StackView {
                    id: mainStack
                    anchors.fill: parent
                    clip: true
                    initialItem: "qrc:/Src/Stack/Cherry/Cherry.qml"
                }
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
