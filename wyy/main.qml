import QtQuick 2.15
import QtQuick.Controls
import QtQuick.Window 2.15
import"./Src/Left"
import"./Src/Right"
import"./Src/Playmusic"
import"./Src/Common"
//总窗口
Common{
    id:window
    width: 1314
    height: 933
    visible: true

    //左页面设置
Left{
       id:leftre
       width: 255
       anchors.top: parent.top
       anchors.bottom: bottomre.top
       color: "#f0f3f6"
   }


    //右页面设置
   Right{
       id:rightre
       anchors.top: parent.top
       anchors.left: leftre.right
       anchors.right: parent.right
       anchors.bottom: bottomre.top
       color:"#f7f9fc"

   }

    //底部页面设置
   Playmusic{
           id:bottomre
           height: 100
           anchors.bottom: parent.bottom
           anchors.left: parent.left
           anchors.right: parent.right
           color:"#fafafa"
   }
   //登陆窗口
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
               source: "/close.png"
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
       source: "/cs"
       x:30
       y:150
       scale: 0.8
   }
   Image {
       id: spcan
       x:200
       y:150
       scale: 0.8
       source: "/spcan"
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
}
