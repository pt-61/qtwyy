import QtQuick
import "./BottomLeft"
import "./BottomRight"

Rectangle {
    color: "blue"

    Text {
        anchors.centerIn: parent
        text: "Bottom"
        font {
            pixelSize: 24
            family: "黑体"
            bold: true
        }
    }

    property double commonBottomL_Width: 200
    property double commonBottomR_Width: parent.width - commonBottomL_Width
    Row {
        anchors.fill: parent
        //底部左侧布局
        BottomLeft {
            width: commonBottomL_Width
            height: parent.height
        }
        //底部右侧布局
        BottomRight {
            width: commonBottomR_Width
            height: parent.height
        }
    }
}
