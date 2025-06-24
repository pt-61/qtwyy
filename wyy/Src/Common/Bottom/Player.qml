import QtQuick
import QtQuick.Controls
import QtMultimedia
import QtQuick.Layouts

MediaPlayer{
    property var parsedLyrics: []
    property int currentnIndex: 0
    property real currentTime: 0.0
    property bool  isplay: true

    id:player
    autoPlay: true
    audioOutput: AudioOutput{}
    onPositionChanged: {
        currentTime=player.position/1000;
        updataCurrentlyricIndex();
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

}
