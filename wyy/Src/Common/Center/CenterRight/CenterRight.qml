import QtQuick
import "./Cherry"

Rectangle {
    color: "yellow"

    Text {
        anchors.centerIn: parent
        text: "CenterRight"
        font {
            pixelSize: 24
            family: "黑体"
            bold: true
        }
    }

    //精选布局
    Cherry {
        anchors.fill: parent
    }
}
