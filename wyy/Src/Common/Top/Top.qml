import QtQuick
import "./TopLeft"
import "./TopRight"

Rectangle {
    color: "red"

    Text {
        anchors.centerIn: parent
        text: "Top"
        font {
            pixelSize: 24
            family: "黑体"
            bold: true
        }
    }

    property double commonTopL_Width: commonCenter.commonCenterL_Width
    property double commonTopR_Width: commonCenter.commonCenterR_Width
    clip: true
    Row {
        anchors.fill: parent
        //顶部左侧布局
        TopLeft {
            width: commonTopL_Width
            height: parent.height
        }
        //顶部右侧布局
        TopRight {
            width: commonTopR_Width
            height: parent.height
        }
    }
}
