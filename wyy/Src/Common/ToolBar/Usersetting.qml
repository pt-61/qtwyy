import QtQuick
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
                    HoverHandler{
                        onHoveredChanged: {
                            if(hovered){
                                user.opacity=0.5
                            }
                            else{
                                user.opacity=1
                            }
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
                TapHandler{
                    onTapped: {
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
        HoverHandler{
            onHoveredChanged: {
                if(hovered){
                    record.opacity=0.5
                }
                else{
                    record.opacity=1
                }
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
        HoverHandler{
            onHoveredChanged: {
                if(hovered){
                    make.opacity=0.5
                }
                else{
                    make.opacity=1
                }
            }
        }
        TapHandler{
            onTapped: {
                mainStack.push("qrc:/Src/Common/Stack/Settings/Settings.qml")
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
