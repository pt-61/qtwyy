import QtQuick 2.15
import QtQuick.Controls

Row{

    Rectangle{
        id:backward
        width: 24
        height: 35
        color: "transparent"
        border.color: "red"
        border.width: 1
        Image {


        }
    }
    TextField{
        id:searchfield
        height: backward.height
        width:200
        color: "#afb5c3"
        leftPadding: 50
        placeholderText:"love story"
        font.pixelSize: 16
        font.family: "微软雅黑"
        background: Rectangle{//外部矩形
            radius: 8
            anchors.fill: parent
            gradient: Gradient{
                orientation: Gradient.Horizontal
                GradientStop{color: "#eaf0f9";position: 0}
                GradientStop{color: "#f7eef6";position: 1}
            }
            Rectangle{//内部矩形
                anchors.fill: parent
                anchors.margins: 1
                gradient: Gradient{
                    orientation: Gradient.Horizontal
                    GradientStop{color: "#eaf0f9";position: 0}
                    GradientStop{color: "#f7eef6";position: 1}
                }
            }
        }
        Image {
            scale: 0.9
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
            anchors.leftMargin: 16
            source: "/search.png"
        }
        MouseArea{
            anchors.fill: parent
            onClicked: {
            searchPop.open()
            }
        }
    }

    Popup{
        id:searchPop
        width: parent.width+100
        height: 700
        y:searchfield.height+13
        clip:true
        background: Rectangle{
            anchors.fill: parent
            radius: 8
            clip: true
            color: "#ffffff"
            Flickable{
                anchors.fill: parent
                contentHeight: 1200
                ScrollBar.vertical: ScrollBar{
                    anchors.right: parent.right
                    anchors.rightMargin: 5
                    width: 10

                }

                Column{
                    anchors.fill: parent
                    spacing: 40
                    Item{
                        id:searchtotal
                        anchors.left: parent.left
                        anchors.right: parent.right
                        height: history.implicitHeight+singflow.implicitHeight+50
                Item {
                    id: history
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.top: parent.top
                    anchors.topMargin: 30
                    anchors.leftMargin: 30
                    Label{
                        id:searchname
                        text: "搜索历史"
                        color: "#283248"
                        font.pixelSize: 18
                        font.family: "微软雅黑"
                    }
                    Image {
                        id: removeim
                        source: "/sing.png"
                        anchors.right: parent.right
                        anchors.rightMargin: 30
                        anchors.verticalCenter: searchname.verticalCenter
                        MouseArea{
                            anchors.fill: parent
                            onClicked: {
                                historymod.clear()
                            }
                        }
                    }
                }
            Flow{
                id:singflow
                anchors.top:history.bottom
                anchors.left: history.left
                anchors.right: history.right
                anchors.topMargin: 30
                spacing: 10
                Repeater{
                    id:historyrep
                    anchors.top: parent.bottom
                    anchors.fill: parent
                    model:historymod
                    property  bool showall: true
                    delegate: Rectangle{
                        width: dataLabel.implicitWidth+20
                        height: 40
                        border.width: 1
                        radius: 15
                        color: "#f2f3f4"
                        border.color: "#e6e8ea"
                        visible: index<(historyrep.showall?100:7)
                        Label{
                            id:dataLabel
                            text: historyrep.showall?(index===9?">":singname):(index===6?"<":singname)
                            anchors.centerIn: parent
                            height: 25
                            color: "#646b4c"
                            font.pixelSize: 20
                            font.family: "微软雅黑"
                        }
                        MouseArea{
                            anchors.fill: parent
                            hoverEnabled: true
                            onEntered: {
                                dataLabel.color="blue"
                                cursorShape=Qt.PointingHandCursor
                            }
                            onExited: {
                                dataLabel.color="#ddd"
                                cursorShape=Qt.ArrowCursor
                            }
                            onClicked: {
                                if(historyrep.showall && index===9){
                                    historyrep.showall=false
                                }else if(!historyrep.showall&&index===6){
                                    historyrep.showall=true
                                }else{
                                    searchfield.text=singname
                                    searchPop.close()
                                }
                            }
                        }
                    }
                }
                ListModel{
                    id:historymod
                    ListElement{singname:"lovestory"}
                    ListElement{singname:"跳楼机"}
                    ListElement{singname:"fuck you"}
                    ListElement{singname:"story"}
                    ListElement{singname:"楼机"}
                    ListElement{singname:" you"}
                    ListElement{singname:"love"}
                    ListElement{singname:"e"}
                    ListElement{singname:"fuck "}
                    ListElement{singname:"eee"}
                }
            }
                           }
            Item {
                id: hotsearch
                anchors.left: parent.left
                anchors.right: parent.right
                height: searchPop.height-searchtotal.implicitHeight
                Label{
                    id:hotsearchlabel
                    text: "热搜榜"
                    color: "#283248"
                    anchors.left: parent.left
                    anchors.leftMargin: 30
                    font.pixelSize: 20
                    height: 40
                }
                Column{
                    anchors.top: hotsearchlabel.bottom
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.bottom: parent.bottom
                    anchors.topMargin: 10
                Repeater{
                    model: hotmodel
                    delegate: Rectangle{
                        color: "transparent"
                        width: singflow.implicitWidth
                        height: 40
                        Label{
                            id:hotmumber
                            text: (index+1).toString()
                            anchors.left: parent.left
                            anchors.leftMargin: 20
                            anchors.verticalCenter: parent.verticalCenter
                            font.pixelSize: 16
                            color: "red"
                            font.family: "微软雅黑"
                        }
                        Label{
                            id:hotname
                            text: singname
                            anchors.left: hotmumber.right
                            anchors.leftMargin: 30
                            anchors.verticalCenter: parent.verticalCenter
                            font.pixelSize: 16
                            color: "#283248"
                            font.family: "微软雅黑"
                        }
                        MouseArea{
                            anchors.fill: parent
                            hoverEnabled: true
                            onEntered: {
                                parent.color="#393943"
                                cursorShape=Qt.PointingHandCursor
                            }
                            onExited: {
                                parent.color="transparent"
                                cursorShape=Qt.ArrowCursor
                            }
                        }
                    }
                }
                ListModel{
                    id:hotmodel
                    ListElement{singname:"lovestory"}
                    ListElement{singname:"跳楼机"}
                    ListElement{singname:"fuck you"}
                    ListElement{singname:"story"}
                    ListElement{singname:"楼机"}
                    ListElement{singname:" you"}
                    ListElement{singname:"love"}
                    ListElement{singname:"e"}
                    ListElement{singname:"fuck "}
                    ListElement{singname:"eee"}
                    ListElement{singname:"e"}
                    ListElement{singname:"fuck "}
                    ListElement{singname:"eee"}
                }
            }
            }
                }

            }
        }
    }

    Rectangle{
        id:songsing
        height: backward.height
        width:height
        color:"#f7eef6"
        border.color: "#f2e4ed"
        border.width: 1
        Image {
            id:sing
            anchors.centerIn: parent
            source: "/sing.png"
        MouseArea{
            anchors.fill: sing
            hoverEnabled: true
            onEntered: {
                songsing.opacity=0.5
            }
            onExited: {
                songsing.opacity=1
            }
        }
        Behavior on opacity {
            PropertyAnimation{
                duration: 100
            }
        }
       }
    }
}
