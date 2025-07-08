import QtQuick
import QtQuick.Controls
import QtQuick.Window
//import "./Src/Left"
//import "./Src/Right"
//import "./Src/Playmusic"
import "./Src/Common"

Window {
    id:window
    width: 1050//1314
    height: 750//933
    visible: true
    //界面边框处理
    flags: Qt.FramelessWindowHint|Qt.Window|Qt.WindowSystemMenuHint|Qt.WindowMaximizeButtonHint|Qt.WindowMinimizeButtonHint
    title: qsTr("Demo Music Player")

    property bool able: true
    Rectangle{
        anchors.top: parent.top
        width: parent.width
        height: 50
        DragHandler{
            onActiveChanged: {
                if(active)window.startSystemMove()
            }
        }
    }

    Common {
        anchors.fill: parent
        enabled: able
    }



}
