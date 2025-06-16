import QtQuick 2.15
Rectangle{

Row{
    id:rightrow
    spacing: 15
    anchors.verticalCenter: parent.verticalCenter
    anchors.right: parent.right
    anchors.rightMargin: 0.02*window.width
    //
    Image {
        anchors.verticalCenter: parent.verticalCenter
        id:minni
        source: '/mini.png'
        Behavior on opacity {
            PropertyAnimation{
                duration: 200
            }
        }
    }
    //变小
    Image {
        id: hide
        anchors.verticalCenter: parent.verticalCenter
        source: '/hide.png'
        Behavior on opacity {
            PropertyAnimation{
                duration: 200
            }
        }

        MouseArea{
            anchors.fill: parent
            hoverEnabled: true
            onEntered: {
               hide.opacity=0.5
            }
            onExited: {
                hide.opacity=1.0
            }
            onClicked: {
                window.showMinimized()
        }
    }
    }
    //放大
    Image {
        id: onbig
        source: '/onbig.png'
        anchors.verticalCenter: parent.verticalCenter
        Behavior on opacity {
            PropertyAnimation{
                duration: 200
            }
        }

        MouseArea{
            anchors.fill: parent
            hoverEnabled: true
            onEntered: {
                onbig.opacity=0.5
            }
            onExited: {
                onbig.opacity=1.0
            }
            onClicked:{
                window.showFullScreen()
            }

        }
    }
    //关闭
    Image {
        y:10
        id: onclose
        source: '/close.png'
        anchors.verticalCenter: parent.verticalCenter
        Behavior on opacity {
            PropertyAnimation{
                duration: 200
            }
        }

        MouseArea{
            anchors.fill: parent
            hoverEnabled: true
            onEntered: {
                onclose.opacity=0.5
            }
            onExited: {
                onclose.opacity=1.0
            }
            onClicked: {
                Qt.quit()
            }
        }
    }
}
}

