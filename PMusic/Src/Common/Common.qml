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
    //左侧宽度
    property double left_Width: 200
    //右侧宽度
    property double right_Width: width - left_Width
    //顶部布局高度
    property double top_Height: 80
    //中部布局高度
    property double center_Height: height - top_Height
    //底部布局高度
    property double bottom_Height: 80


    //左侧底色
    property color leftColor: "white"
    //右侧底色
    property color rightColor: "#f7f9fc"
    //底部底色
    property color bottomColor: "blue"
    //标准标签颜色
    property color basicLabelColor: "gray"

    //
    property int horCount: 2

    Column {
        anchors.fill: parent
        //顶部行布局
        Row {
            width: parent.width
            height: top_Height
            //logo布局
            Logo {
                width: left_Width
                height: parent.height
                color: leftColor
                clip: true
            }
            //工具栏布局
            ToolBar {
                width: right_Width
                height: parent.height
                color: rightColor
                clip: true
            }

        }
        //中部行布局
        Row {
            width: parent.width
            height: center_Height
            //左侧选项布局
            LeftSelectors {
                id: leftSelectors
                width: left_Width
                height: parent.height
                color: leftColor
                labelColor: basicLabelColor
                clip: true
            }
            //堆栈
            Rectangle {                
                width: right_Width
                height: parent.height
                color: rightColor
                StackView {
                    id: mainStack
                    anchors.fill: parent
                    clip: true
                    initialItem: "qrc:/Src/Stack/Cherry/Cherry.qml"
                    property int currentDepth: 1
                    onDepthChanged: {
                        if(depth > currentDepth) {
                            mainStackData.append({"index": leftSelectors.selectedIndex, "space": leftSelectors.whichSpace})
                            currentDepth += 1
                        }
                        if(depth < currentDepth) {
                            mainStackData.remove(depth)
                            currentDepth -= 1
                            leftSelectors.selectedIndex = mainStackData.get(depth - 1).index
                            leftSelectors.whichSpace = mainStackData.get(depth - 1).space
                        }
                    }
                }
                ListModel {
                    id: mainStackData
                    ListElement {index: 0; space: 0}
                }
            }
        }
    }
    //底部布局
    Bottom {
        width: parent.width
        height: bottom_Height
        anchors.bottom: parent.bottom
    }
}
