import QtQuick 2.15
import QtQuick.Controls
import QtQuick.Controls 2.15
import "../StackPages/Settingitems"
Item {
   Item {
        anchors.fill: parent
        anchors.topMargin:24
        anchors.leftMargin:24
        Label{
              id:settingtitle
              color: "black"
              font.bold: true
              text: "设置"
              anchors.left: parent.left
              anchors.top: parent.top
        }
        Flow{
            id:settingtitleflow
            anchors.left: settingtitle.left
            anchors.top: settingtitle.bottom
            anchors.topMargin: 25
            height: 25
            spacing: 20
            Repeater{
                id:selectedrep
                property int selectedindex: 0
                anchors.fill: parent
                model: ["账号","常规","系统","播放"]
                Item {
                    width: selectlabel.implicitWidth
                    height: 40
                    Label{
                        id:selectlabel
                        text: modelData
                        font.pixelSize: 20
                        font.bold: true
                        anchors.centerIn: parent
                        color: selectedrep.selectedindex===index?"white":"#a1a1a3"
                    }
                    Rectangle{
                        visible:selectedrep.selectedindex===index
                        anchors.left: selectlabel.left
                        anchors.right: selectlabel.right
                        anchors.top:selectlabel.bottom
                        height: 3
                        anchors.topMargin: 3
                        color: "#eb4d44"
                    }
                    MouseArea{
                        anchors.fill: parent
                        hoverEnabled: true
                        onEntered: {
                            if(selectedrep.selectedindex===index){
                                selectlabel.color="white"
                            }
                            else{
                                selectlabel.color="#b9b9ba"
                            }
                            cursorShape=Qt.ArrowCursor
                        }
                        onExited: {
                            if(selectedrep.selectedindex===index){
                                selectlabel.color="#a1a1a3"
                            }
                            else{
                                selectlabel.color="white"
                            }
                            cursorShape=Qt.ArrowCursor
                        }
                        onClicked: {
                            selectedrep.selectedindex=index
                        }
                    }
                }
            }
        }
        Flickable{
            id:flick
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: settingtitleflow.bottom
            anchors.bottom: parent.bottom
            anchors.topMargin: 10
            contentHeight: 4800
            clip:true
            ScrollBar.vertical: ScrollBar{
                anchors.right: parent.right
                anchors.rightMargin: 5
                width: 10

            }
            Column{
                anchors.fill: parent
                anchors.topMargin: 50
                spacing: 10
                //账户
                Counter{}
                //常规
                Common{
                    anchors.top: Counter.bottom
                    anchors.topMargin: 50
                }
            }
        }
        }
}
