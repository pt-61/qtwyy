import QtQuick

Rectangle{
     property bool isbig: false
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
            source: "qrc:/Src/image/mini.png"
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
            source: "qrc:/Src/image/hide.png"
            Behavior on opacity {
                PropertyAnimation{
                    duration: 200
                }
            }

            HoverHandler{
                onHoveredChanged: {
                    if(hovered){
                        hide.opacity=0.5
                    }else{
                        hide.opacity=1.0
                    }
                }
            }
            TapHandler{
                onTapped: {
                    window.showMinimized()
                }
            }
        }
        //放大
        Image {
            id: onbig
            source: "qrc:/Src/image/onbig.png"
            anchors.verticalCenter: parent.verticalCenter
            Behavior on opacity {
                PropertyAnimation{
                    duration: 200
                }
            }

            HoverHandler{
                onHoveredChanged: {
                    if(hovered){
                        onbig.opacity=0.5
                    }
                    else{
                        onbig.opacity=1
                    }
                }
            }
            TapHandler{
                onTapped: {
                    if(!isbig){
                        window.showMaximized()
                        isbig=true
                    }
                    else{
                        window.showNormal()
                        isbig=false
                    }

                }
            }
        }
        //关闭
        Image {
            y:10
            id: onclose
            source: "qrc:/Src/image/close.png"
            anchors.verticalCenter: parent.verticalCenter
            Behavior on opacity {
                PropertyAnimation{
                    duration: 200
                }
            }

            HoverHandler{
                onHoveredChanged: {
                    if(hovered){
                        onclose.opacity=0.5
                    }
                    else{
                        onclose.opacity=1
                    }
                }
            }

            TapHandler{
                onTapped: {
                    Qt.quit()
                }
            }
        }
    }
}

