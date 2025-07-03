import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtMultimedia


Rectangle {
    color: "#fafafa"

    property var parsedLyrics: []
    property int currentNewIndex: 0
    property real currentTime: 0.0
    property bool  isplay: false
    property string albumpath:""
    property bool penable: true
    property int count: 0
    property int listviewIndex: 0


    Connections{
        target: songmodel
        function onPlaymusic(path,lyrics,alubmartpath,currentindex,listviewcount){
           lywindow.enabled=false

        }
    }
    Connections{
        target: songmodel
        function onIsplay(){
                lywindow.enabled=true
        }
    }

    Rectangle{
        anchors.top: parent.top
        anchors.topMargin: 20
        anchors.left: parent.left
        anchors.leftMargin: 10
        color: "red"
        width: 50
        height: 50
        radius: width/2
        Button{
            onClicked: {
                lywindow.enabled=true
                lywindow.state="big"
            }
        }
        Image {
            id:musicpicture
            anchors.fill: parent
        }
        RotationAnimation on  rotation {
            from: 0
            to:360
            duration: 1500
            loops: Animation.Infinite
            running: isplay
        }
    }


    Image {
        id:p
        source: "qrc:/Src/image/close.png"
      // anchors.verticalCenter: parent.verticalCenterr
        anchors.bottom:playerrow.top
        anchors.left: parent.left
        anchors.leftMargin: parent.width/2
        TapHandler{
            onTapped: {
                if(isplay===true){
                player.pause()
                isplay=false
                }
                else{
                player.play()
                isplay=true
                }
            }
        }
    }
    Image {
        source: "qrc:/left.png"
        anchors.verticalCenter: p.verticalCenter
        anchors.right: p.left
        anchors.rightMargin: 30
    }
    Image {
        source: "qrc:/right.png"
        anchors.verticalCenter: p.verticalCenter
        anchors.left: p.right
        anchors.leftMargin: 30
    }
    RowLayout{
        width: 500
        id:playerrow
        anchors.top: p.bottom
        anchors.centerIn: parent
        Layout.bottomMargin: 20
        Text {
            text:formatTion(currentTime)
        }
        Slider{
            id:timeslider
            Layout.fillWidth:true
            from: 0
            to:parsedLyrics[parsedLyrics.length-1].time+10
            //to:player.duration
            value: currentTime
            onMoved: {
                player.position=value*1000
                lywindow.updataCurrentlyricIndex()
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

    Player{id:player
        onPositionChanged: {
            currentTime=player.position/1000;
            lywindow.updataCurrentlyricIndex();
        }
    }
    Lywindow{
    anchors.left: parent.left
    id:lywindow
    anchors.bottom: parent.bottom
    }

}
