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
    Popup{
        id:loginpopup
        anchors.centerIn: parent
        width: 466
        height: 638
        clip: true
        onOpened: {
            showanimation.restart()
        }

        closePolicy: Popup.NoAutoClose
        background: Rectangle{
            anchors.fill: parent
            color: "#ffffff"
            radius: 10
            border.width: 1
            border.color: "#e6e8ea"
            Image {
                id:close2
                // scale: 2
                anchors.top: parent.top
                anchors.right: parent.right
                anchors.topMargin: 30
                anchors.rightMargin: 30
                source: "qrc:/Src/image/close.png"
                MouseArea{
                    anchors.fill: parent
                    hoverEnabled: true
                    onEntered:{
                        cursorShape=Qt.PointingHandCursor
                    }
                    onExited: {
                        cursorShape=Qt.ArrowCursor
                    }
                    onClicked: {
                        loginpopup.close()
                    }
                }
            }
        }
        //标题
        Label{
            id:logintext
            text: "扫码登陆"
            color:"#283248"
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.top
            anchors.topMargin: 100
            font.bold: true
            font.family: "黑体"
            font.pixelSize: 32
        }
        Image {
            id: cs
            source: "qrc:/Src/image/cs.png"
            x:30
            y:150
            scale: 0.8
        }
        Image {
            id: spcan
            x:200
            y:150
            scale: 0.8
            source: "qrc:/Src/image/spcan.png"
            MouseArea{
                anchors.fill: parent
                hoverEnabled: true
                onEntered: {
                    showanimation.showflag=true
                    showanimation.restart()
                }
                onExited:{
                    showanimation.showflag=false
                    showanimation.restart()
                }

            }
        }
        Label{
            anchors.top: spcan.bottom
            anchors.horizontalCenter: spcan.horizontalCenter
            text: "使用网易云扫码登陆"
        }
        Text {
            id: other
            text: qsTr("其他方式登陆>")
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 60
            anchors.horizontalCenter: parent.horizontalCenter
            font.pixelSize: 20
            MouseArea{
                anchors.fill: parent
                hoverEnabled: true
                onEntered: {
                    cursorShape=Qt.PointingHandCursor
                }
                onExited: {
                    cursorShape=Qt.ArrowCursor
                }
            }
        }

        ParallelAnimation{
            id:showanimation
            property bool showflag: true
            NumberAnimation{
                target: cs
                property: "x"
                duration: 500
                from: showanimation.showflag ? (loginpopup.width-cs.implicitWidth)/2:10
                to:showanimation.showflag ? 10 :(loginpopup.width-cs.implicitWidth)/2
            }
            NumberAnimation{
                target: cs
                property: "y"
                duration: 500
                from: showanimation.showflag?30:-60
                to:showanimation.showflag?130:(loginpopup.width-spcan.implicitWidth)/2
            }
            NumberAnimation{
                target: cs
                property: "opacity"
                duration: 500
                from: showanimation.showflag?0:1
                to:showanimation.showflag?1:0
            }
            NumberAnimation{
                target: spcan
                property: "y"
                duration: 500
                from: showanimation.showflag?(loginpopup.height-cs.implicitHeight)/2:150
                to:showanimation.showflag?150:(loginpopup.height-cs.implicitHeight)/2
                // easing: type:Easing.Linear
            }
            NumberAnimation{
                target: spcan
                property: "scale"
                duration: 500
                from: showanimation.showflag?1:0.8
                to:showanimation.showflag?0.8:1
            }
            NumberAnimation{
                target: spcan
                property: "x"
                duration: 500
                from: showanimation.showflag?90:200
                to:showanimation.showflag?200:90
            }
        }
    }

    Rectangle{


        id:ly
        width: parent.width
        anchors.top: parent.top
        height: 600
        opacity: 0
        state: "min"
        color:"blue"


        states: [
            State {
                name: "big"
                PropertyChanges {
                    target: ly
                    opacity:1
                    y:window.y
                }
            },
            State {
                name: "min"
                PropertyChanges {
                    target: ly
                    opacity:0
                    y:window.height
                }
            }]

        transitions: Transition {
            from: "*"
            to: "*"
            SequentialAnimation{
                NumberAnimation {
                target: ly
                property: "opactiy"
                duration: 200
                }

                NumberAnimation {
                properties: "y"
                duration: 500
                easing.type: Easing.OutBack
                }
            }
        }

    }

}
