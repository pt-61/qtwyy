import QtQuick
import QtQuick.Window
import "./Basic"
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

    property double commonBasic_Height: height - commonBottom_Height
    property double commonBottom_Height: 50
    Column {
        anchors.fill: parent
        //基础布局
        Basic {
            id: commonBasic
            width: parent.width
            height: commonBasic_Height
        }
        //底部布局
        Bottom {
            id: commonBottom
            width: parent.width
            height: commonBottom_Height
        }
    }
}
