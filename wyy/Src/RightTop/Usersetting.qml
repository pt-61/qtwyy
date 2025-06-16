import QtQuick 2.15
import QtQuick.Controls
Row{

    Rectangle{
        height: 30
        width: 140
        anchors.verticalCenter: parent.verticalCenter
        Row{
            anchors.verticalCenter: parent.verticalCenter
            spacing: 20
            Rectangle{
                id:usericon
                width: 30
                height: 30
                radius: width/2
                color: "#2d2d37"
                Image {
                    id:user
                    anchors.verticalCenter: parent.verticalCenter
                    source: "/name.png"
                    MouseArea{
                        anchors.fill: parent
                        hoverEnabled: true
                        onEntered: {
                           user.opacity=0.5
                        }
                        onExited: {
                            user.opacity=1
                        }
                    }
                    Behavior on opacity {
                        PropertyAnimation{
                            duration: 100
                        }
                    }
                }
            }
        Text {
            id: loadstart
            font.pixelSize: 20
            text: "未登录"
            color: "#75777f"
            anchors.verticalCenter: parent.verticalCenter
            MouseArea{
                anchors.fill: parent
                hoverEnabled:true
                onEntered: {

                }
                onClicked: {
                    loginpopup.open()
                }
            }
           }
        }
    }
    Item{
        height: usericon.height
        width: loadstart.width*1.2
        anchors.verticalCenter: parent.verticalCenter
        Rectangle{
            id:vipre
            width: parent.width
            height: 12
            color: "#dadada"
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
            radius: 6
        }
        Label{
            text: "未登录"
            anchors.left: parent.left
            anchors.leftMargin: 20
            color: "#f8f9f9"
            font.pixelSize: 8
            anchors.verticalCenter: parent.verticalCenter
        }
        Rectangle{
            id:vio
            width:vipre.height+4
            height: width
            radius: width/2
            color: "#13131a"
            anchors.verticalCenter: parent.verticalCenter
        }
    }

Image {
    id: record
    source: "/record.png"
    MouseArea{
        anchors.fill: parent
        hoverEnabled: true
        onEntered: {
            record.opacity=0.5
        }
        onExited: {
            record.opacity=1
        }
    }
    Behavior on opacity {
        PropertyAnimation{
            duration: 100
        }
    }
}
//设置
Image {
    id: make
    source: "/make.png"
    MouseArea{
        anchors.fill: parent
        hoverEnabled: true
        onEntered: {
            make.opacity=0.5
        }
        onExited: {
            make.opacity=1
        }
        onClicked: {
            mainstack.push("qrc:/Src/Right/StackPages/Settings.qml")
        }
    }
    Behavior on opacity {
        PropertyAnimation{
            duration: 100
        }
    }
}
Rectangle{
    width:1
    height: 24
    color: "#e2e5e9"
    anchors.verticalCenter: parent.verticalCenter
}
}
