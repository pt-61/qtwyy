import QtQuick
import "./CherrySelector"

Rectangle {
    color: "yellow"

    Text {
        anchors.centerIn: parent
        text: "Cherry"
        font {
            pixelSize: 24
            family: "黑体"
            bold: true
        }
    }

    property double cherryItem_Width: parent.width - 50
    property double cherrySelector_Height: 40
    Column {
        anchors.fill: parent
        //精选选项
        CherrySelector {
            width: parent.width
            height: cherrySelector_Height
        }
    }
}
