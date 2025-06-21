import QtQuick
import "./Title"

Rectangle {
    color: "red"

    Text {
        anchors.centerIn: parent
        text: "TopRight"
        font {
            pixelSize: 24
            family: "黑体"
            bold: true
        }
    }

    Search {
        anchors {
            left: parent.left
            verticalCenter: parent.verticalCenter
        }
    }

    RightTop {
        anchors {
            right: parent.right
            verticalCenter: parent.verticalCenter
        }
    }
}
