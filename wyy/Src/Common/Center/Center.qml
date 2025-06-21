import QtQuick
import "./CenterLeft"
import "./CenterRight"

Rectangle {
    color: "yellow"

    Text {
        anchors.centerIn: parent
        text: "Center"
        font {
            pixelSize: 24
            family: "黑体"
            bold: true
        }
    }

    property double commonCenterL_Width: 200
    property double commonCenterR_Width: parent.width - commonCenterL_Width
    Row {
        anchors.fill: parent
        //中部左侧布局
        CenterLeft {
            width: commonCenterL_Width
            height: parent.height
        }
        //中部右侧布局
        CenterRight {
            width: commonCenterR_Width
            height: parent.height
        }
    }
}
