import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtMultimedia
Rectangle{
    id:lywindow
    width: window.width
    height:window.height
    state: "min"
    color:"blue"

    Connections{
        target: songmodel
        function onPlaymusic(path,lyrics,alubmartpath,currentindex,listviewcount){
            parsedLyrics=parseUSLT(lyrics)
            listviewIndex=currentindex
            console.log("a",listviewIndex)
            musicpicture.source="file:///"+alubmartpath
            count=listviewcount
            player.source="file:///"+path
            player.play()
            isplay=true

        }
    }
    Connections{
        target: songmodel
        function onSome(){
            lywindow.state="big"
        }
    }

    states: [
        State {
            name: "big"
            PropertyChanges {
                target: lywindow
                opacity:1
                y:window.y
                x:window.x
            }
        },
        State {
            name: "min"
            PropertyChanges {
                target: lywindow
                opacity:0
                width:0
                height:0
            }
        }]


    Rectangle{
        id:lyclose
        color:"black"
        height: 50
        width: 50
        anchors.top: parent.top
        anchors.topMargin: 20
        anchors.left: parent.left
        anchors.leftMargin: 30
        TapHandler{
            onTapped: {
                lywindow.state="min"
                lywindow.enabled=false
            }
        }
    }


    Image {
        id:pt
        source: "qrc:/Src/image/close.png"
        anchors.verticalCenter: parent.verticalCenterr
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 50
        anchors.left: parent.left
        anchors.leftMargin: 500

    }
    Image {
        source: "qrc:/right.png"
        anchors.verticalCenter: pt.verticalCenter
        anchors.right: pt.left
        anchors.rightMargin: 30
        TapHandler{
            onTapped: {
                console.log("b:",listviewIndex)
                var b=(listviewIndex+1+count)%count
                songmodel.findindex(b)
            }
        }
    }
    Image {
        source: "qrc:/left.png"
        anchors.verticalCenter: pt.verticalCenter
        anchors.left: pt.right
        anchors.leftMargin: 30
        TapHandler{
            onTapped: {
                var a=(listviewIndex-1+count)%count
               // songmodel.findindex(a)
            }
        }
    }

    RowLayout{
        anchors.top: pt.bottom
        anchors.left: parent.left
        anchors.leftMargin: 20
        Layout.bottomMargin: 20
        width: 1000
        Text {
            id:s
            text:formatTion(currentTime)
        }
        Slider{
            id:timeslider1
            Layout.fillWidth:true
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
                x:timeslider1.leftPadding+timeslider1.visualPosition*(timeslider1.availableWidth-width)
                y:timeslider1.topPadding+timeslider1.availableHeight/2-height/2
                implicitHeight: 20
                implicitWidth: 20
                radius: 8
                color: timeslider1.pressed?"#ffffff":"#f8fafc"
                border.color: "red"
            }

        }
        Text {
            text: formatTion( parsedLyrics[parsedLyrics.length-1].time)
        }
    }


    ListView{
        id:lyricslistview
        anchors.right: parent.right
        width: 500
        height: 500
        anchors.top:parent.top
        model:parsedLyrics
        clip: true
        highlightMoveDuration: 300

            delegate: Rectangle{
            id:rec1
            width: lyricslistview. width
            height: 100
            color: index===currentNewIndex? "#e0f2f1" : "green"
                Text {
            text: modelData.text
            anchors.centerIn: parent
            color:index=== currentNewIndex?"#3b82f6":"#94a3b8"
            font.bold: index===currentNewIndex
                }
            }
            Behavior on contentY {
                NumberAnimation{duration:300}
            }
    }
    function updataCurrentlyricIndex(){
           if(parsedLyrics.length===0)return;

           if(currentTime<parsedLyrics[0].time){
               currentNewIndex=0;
               return;
           }

           if(currentTime>parsedLyrics[parsedLyrics.length-1].time){
               currentNewIndex=parsedLyrics.length-1;
               return;
           }

           for(var i=0;i<parsedLyrics.length-1;i++){
               if(currentTime>=parsedLyrics[i].time&&currentTime<parsedLyrics[i+1].time){
                   currentNewIndex=i;
                   break;
               }
           }
           if(lyricslistview.currentIndex!==currentNewIndex){
               lyricslistview.currentIndex=currentNewIndex

               lyricslistview.positionViewAtIndex(currentNewIndex,ListView.Center)
           }
    }
    function formatTion(seconds){
            var mins=Math.floor(seconds/60);
            var secs=Math.floor(seconds%60);
            var minstr=mins<10?"0"+mins:mins;
            var secstr=secs<10?"0"+secs:secs;
            return minstr+":"+secstr;
    }
    function parseUSLT(lyrics) {
           var result = [];

           // 移除USLT头部信息
           var content = lyrics;
           if (lyrics.startsWith("USLT::")) {
               var firstNewline = lyrics.indexOf("\n");
               if (firstNewline !== -1) {
                   content = lyrics.substring(firstNewline + 1);
               }
           }

           // 分割为行
           var lines = content.split('\n');

           for (var i = 0; i < lines.length; i++) {
               var line = lines[i].trim();
               if (line.length === 0) continue;

               // 匹配时间标签 [mm:ss.xx]
               var timeMatch = line.match(/\[(\d+):(\d+\.\d+)\]/);
               if (timeMatch && timeMatch.length >= 3) {
                   var minutes = parseInt(timeMatch[1]);
                   var seconds = parseFloat(timeMatch[2]);
                   var timeInSeconds = minutes * 60 + seconds;

                   // 提取歌词文本
                   var text = line.substring(timeMatch[0].length).trim();

                   if (text) {
                       result.push({
                           time: timeInSeconds,
                           text: text
                       });
                   }
               } else {
                   // 没有时间标签的行作为上一行的延续
                   if (result.length > 0) {
                       result[result.length - 1].text += "\n" + line;
                   } else {
                       // 如果第一行没有时间标签，则添加到列表开始处
                       result.push({
                           time: 0,
                           text: line
                       });
                   }
               }
           }
           result.sort((a,b)=>a.time-b.time);
           return result;
    }
}
