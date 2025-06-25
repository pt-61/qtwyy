import QtQuick
import QtQuick.Controls
import QtQuick.Window
//import "./Src/Left"
//import "./Src/Right"
//import "./Src/Playmusic"
import "./Src/Common"

Window {
    id:window
    width: 1024//1314
    height: 670//933
    visible: true
    //界面边框处理
    flags: Qt.FramelessWindowHint|Qt.Window|Qt.WindowSystemMenuHint|Qt.WindowMaximizeButtonHint|Qt.WindowMinimizeButtonHint
    title: qsTr("Demo Music Player")

    Common {
        anchors.fill: parent
    }
}
