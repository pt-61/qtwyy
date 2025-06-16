import QtQuick 2.15
import QtQuick.Window 2.15
Window {
    id:window
    width: 1314
    height: 933
    visible: true
    //界面边框处理
    flags: Qt.FramelessWindowHint|Qt.Window|Qt.WindowSystemMenuHint|Qt.WindowMaximizeButtonHint|Qt.WindowMinimizeButtonHint
    title: qsTr("Hello World")
    MouseArea{
        anchors.fill: parent
        property point currentpoint:"0,0"
        onPressed:function(mouse) {
            currentpoint=Qt.point(mouse.x,mouse.y)
        }
        onPositionChanged:function(mouse){
            let delta=Qt.point(mouse.x-currentpoint.x,mouse.y-currentpoint.y)
            window.x+=delta.x
            window.y+=delta.y
        }
    }
}
