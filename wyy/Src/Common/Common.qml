import QtQuick
import QtQuick.Window
import "./Top"
import "./Center"
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

    property double commonTop_Height: 50
    property double commonCenter_Height: height - commonTop_Height - commonBottom_Height
    property double commonBottom_Height: commonTop_Height

    Column {
        anchors.fill: parent
        //顶部布局
        Top {
            id: commonTop
            height: commonTop_Height
            width: parent.width
        }
        //中部布局
        Center {
            id: commonCenter
            height: commonCenter_Height
            width: parent.width
        }
        //底部布局
        Bottom {
            id: commonBottom
            height: commonBottom_Height
            width: parent.width
        }
    }
}
