import QtQuick 2.15
import QtQuick.Controls
        //账户
        Item {
            anchors.left: parent.left
            anchors.right: parent.right
            height: 100
            Label{
                id:counterlabel
                text: "账户"
                font.pixelSize: 22
                font.family: "黑体"
                anchors.left: parent.left
                color: "black"
            }
            Label{
                id:counterlabel2
                text: "登陆网易云，手机电脑多端同步，320k下载"
                anchors.verticalCenter: counterlabel.verticalCenter
                anchors.left: counterlabel.right
                anchors.leftMargin: 150
                color: "#e8e8e8"
            }
           Rectangle{
               width: 100
               height: 30
               radius: 15
               anchors.left: counterlabel2.left
               anchors.top: counterlabel2.bottom
               anchors.topMargin: 20
               color: "#e84d5f"
               Label{
                   text: "立即登录"
                   font.pixelSize: 18
                   anchors.centerIn: parent
                   color: "white"

               }
               MouseArea{
                   anchors.fill: parent
                   hoverEnabled: true
                   onEntered: {
                       parent.opacity=0.8
                       cursorShape=Qt.PointingHandCursor
                   }
                   onExited: {
                       parent.opacity=1
                       cursorShape=Qt.ArrowCursor
                   }
               }

           }
        }

