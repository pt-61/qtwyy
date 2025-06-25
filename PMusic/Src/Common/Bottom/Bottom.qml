import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtMultimedia


Rectangle {
    color: "#fafafa"


    property var parsedLyrics: []
    property int currentnIndex: 0
    property real currentTime: 0.0
    property bool  isplay: true

    Rectangle{
        anchors.top: parent.top
        anchors.topMargin: 20
        anchors.left: parent.left
        anchors.leftMargin: 10
        color: "red"
        width: 50
        height: 30
    }


    Image {
        id:p
        source: "qrc:/Src/image/close.png"
        anchors.verticalCenter: parent.verticalCenterr
        anchors.top: parent.top
        anchors.topMargin: 10
        anchors.left: parent.left
        anchors.leftMargin: 500

    }
    Image {
        source: "qrc:/right.png"
        anchors.verticalCenter: p.verticalCenter
        anchors.right: p.left
        anchors.rightMargin: 30
    }
    Image {
        source: "qrc:/left.png"
        anchors.verticalCenter: p.verticalCenter
        anchors.left: p.right
        anchors.leftMargin: 30
    }
    RowLayout{
        anchors.top: p.bottom
        anchors.left: parent.left
        anchors.leftMargin: 420
        Layout.bottomMargin: 20
        Text {
            text:formatTion(currentTime)
        }
        Slider{
            id:timeslider
            width: 300
            from: 0
            to:Math.max(60,parsedLyrics.length>0?parsedLyrics[parsedLyrics.length-1].time+10:60)
            value: currentTime
            onMoved: {
                player.pause()
                player.position=value*1000
                updataCurrentlyricIndex()
                if(isplay)player.play()
            }


            handle: Rectangle{
                id:handre
                x:timeslider.leftPadding+timeslider.visualPosition*(timeslider.availableWidth-width)
                y:timeslider.topPadding+timeslider.availableHeight/2-height/2
                implicitHeight: 20
                implicitWidth: 20
                radius: 8
                color: timeslider.pressed?"#ffffff":"#f8fafc"
                border.color: "red"
                }
            Text{
            text: "ly"+(currentnIndex+1)+"/"+parsedLyrics.length
            }
        }

    }
        MediaPlayer{
            id:player
            autoPlay: true
            audioOutput: AudioOutput{}
            onPositionChanged: {
                currentTime=player.position/1000;
                updataCurrentlyricIndex();
            }
        }
    function updataCurrentlyricIndex(){
               if(parsedLyrics.length===0)return;

               if(currentTime<parsedLyrics[0].time){
                   currentnIndex=0;
                   return;
               }

               if(currentTime>parsedLyrics[parsedLyrics.length-1].time){
                   currentnIndex=parsedLyrics.length-1;
                   return;
               }

               for(var i=0;i<parsedLyrics.length-1;i++){
                   if(currentTime>=parsedLyrics[i].time&&currentTime<parsedLyrics[i+1].time){
                       currentnIndex=i;
                       break;
                   }
               }
               if(lyricslistview.currentIndex!==currentIndex){
                   lyricslistview.currentIndex=currentnIndex

                   lyricslistview.positionViewAtIndex(currentnIndex,ListView.Center)
               }
        }
    function formatTion(seconds){
            var mins=Math.floor(seconds/60);
            var secs=Math.floor(seconds%60);
            var minstr=mins<10?"0"+mins:mins;
            var secstr=secs<10?"0"+secs:secs;
            return minstr+":"+secstr;
    }
}
