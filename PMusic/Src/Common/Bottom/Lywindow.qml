import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtMultimedia
import Qt5Compat.GraphicalEffects

Rectangle{
    id:lywindow
    width: window.width
    height:window.height
    state: "min"
    color:"#1d1a23"
    property bool isbig: false
    TapHandler {
        acceptedDevices: PointerDevice.AllDevices
        gesturePolicy: TapHandler.DragThreshold
        enabled: lywindow.state === "big"?true:false

    }

    Connections{
        target: songmodel1
        function onPlaymusic(path,lyrics,alubmartpath,currentindex,listviewcount,Title,Actist){
            parsedLyrics=parseUSLT(lyrics)
            listviewIndex=currentindex
            lyimage.source="file:///"+alubmartpath
            musicpicture.source="file:///"+alubmartpath
            count=listviewcount
            player.source="file:///"+path
            player.play()
            isplay=true
            title=Title
            actist=Actist
            modelname= songmodel1
        }
    }
    Connections{
        target: songmodel
        function onPlaymusic(path,lyrics,alubmartpath,currentindex,listviewcount,Title,Actist){
            parsedLyrics=parseUSLT(lyrics)
            listviewIndex=currentindex
            lyimage.source="file:///"+alubmartpath
            musicpicture.source="file:///"+alubmartpath
            count=listviewcount
            player.source="file:///"+path
            player.play()
            isplay=true
            title=Title
            actist=Actist
            modelname= songmodel
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
                enabled:true
            }
        },
        State {
            name: "min"
            PropertyChanges {
                target: lywindow
                opacity:0
                width:0
                height:0
                enabled:false
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
            }
        }
        Image {
            anchors.fill: parent
            source: "qrc:/lyimage/lydown.png"
        }
    }


    Image {
        id:pt
        source:"qrc:/lyimage/lypause.png"
        anchors.verticalCenter: parent.verticalCenterr
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 50
        anchors.left: parent.left
        anchors.leftMargin: parent.width/2
        TapHandler{
            onTapped: {
                if(isplay===true){
                    player.pause()
                    isplay=false
                    pt.source= "qrc:/stop1.png"

                }
                else{
                    player.play()
                    isplay=true
                    pt.source="qrc:/lyimage/lypause.png"
                }
            }
        }
        HoverHandler{
            onHoveredChanged: {
                if(hovered){
                    pt.opacity=0.8
                }else{
                    pt.opacity=1
                }
            }
        }
    }
    Image {
        id:lyleft
        source: "qrc:/lyimage/lyleft.png"
        anchors.verticalCenter: pt.verticalCenter
        anchors.right: pt.left
        anchors.rightMargin: 30
        TapHandler{
            onTapped: {
                console.log("a:",listviewIndex)
                var a=(listviewIndex-1+count)%count
                modelname.findindex(a)
            }
        }
        HoverHandler{
            onHoveredChanged: {
                if(hovered){
                    lyleft.opacity=0.8
                }else{
                    lyleft.opacity=1
                }
            }
        }
    }
    Image {
        id:lyright
        source: "qrc:/lyimage/lyright.png"
        anchors.verticalCenter: pt.verticalCenter
        anchors.left: pt.right
        anchors.leftMargin: 30
        TapHandler{
            onTapped: {
                console.log("b:",listviewIndex)
                var b=(listviewIndex+1+count)%count
                modelname.findindex(b)
            }
        }
        HoverHandler{
            onHoveredChanged: {
                if(hovered){
                    lyright.opacity=0.8
                }else{
                    lyright.opacity=1
                }
            }
        }
    }

    Item {
        anchors.top: parent.top
        anchors.topMargin: parent.height/8
        width:(parent.height-80)/3
        height: (parent.height-80)/3
        anchors.left: parent.left
        anchors.leftMargin: parent.width/10
        Image {
            id: lyimage
            sourceSize: Qt.size(parent.width,parent.height)
            visible: false
        }
        Rectangle{
            id:mask
            anchors.fill: parent
            width: (parent.height-80)/3
            height:(parent.height-80)/3
            radius: width/2
            visible: true
        }
        OpacityMask{
            anchors.fill: lyimage
            maskSource: mask
            source: lyimage
        }
        RotationAnimation on  rotation {
            from: 0
            to:360
            duration: 1500
            loops: Animation.Infinite
            running: isplay
        }
    }

    Rectangle{
        id:lyvolumesilder
        anchors.right: parent.right
        anchors.rightMargin: 220
        anchors.bottom: lyvolumerc.top
        height: 100
        width: 20
        visible: false
        z:1
        color: parent.color
        Slider{
            anchors.fill: parent
            orientation: Qt.Vertical
            from: 0
            to:1
            value: 0.5
            onValueChanged: player.audioOutput.volume=value
        }
    }
    Image {
        id: lyvolumerc
        anchors.right: parent.right
        anchors.rightMargin: 200
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 50
        source: "qrc:/lyimage/lysong.png"
            TapHandler{
                onTapped: {
                    if(lyvolumesilder.visible===false){
                        lyvolumesilder.visible=true
                        }
                    else{
                        lyvolumesilder.visible=false
                    }
                }
            }
        }

    RowLayout{
        anchors.top: pt.bottom
        anchors.left: parent.left
        Layout.bottomMargin: 15
        width: parent.width
        Text {
            id:s
            text:formatTion(currentTime)
            color: "#94a3b8"
        }
        Slider{
            id:timeslider1
            Layout.fillWidth:true
            from: 0
            to:parsedLyrics[parsedLyrics.length-1].time+10
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
                implicitHeight: 10
                implicitWidth: 10
                radius: 8
                color: timeslider1.pressed?"#ffffff":"#f8fafc"
                border.color: "red"
            }

        }
        Text {
            text: formatTion( parsedLyrics[parsedLyrics.length-1].time)
            color: "#94a3b8"
        }
    }
    Rectangle{
        id:tooltop
        anchors.right: parent.right
        width: 100
        Image {
            id:llyclose
            anchors.right: parent.right
            source: "qrc:/lyimage/lyclose.png"
            TapHandler{
                onTapped: {
                    Qt.quit()
                }
            }
        }

        Image {
            id: lybig
            anchors.right: llyclose.left
            anchors.rightMargin: 10
            source: "qrc:/lyimage/lybig.png"
            TapHandler{
                onTapped: {
                    if(!isbig){
                        window.showMaximized()
                        isbig=true
                    }else{
                        window.showNormal()
                        isbig=false
                    }
                }
            }
        }
        Image {
            anchors.right: lybig.left
            anchors.rightMargin: 10
            source: "qrc:/lyimage/lymin.png"
            TapHandler{
                onTapped: {
                    window.showMinimized()
                }
            }
        }
    }

    Rectangle{
        id:lytop
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.topMargin: parent.height/10
        height: (parent.height-80)/3
        width: parent.width/2
        color: parent.color
        Text {
            id:lyTitle
            text: qsTr(title)
            font.pixelSize: 30
            font.family: "微软雅黑"
            color: "#ffffff"
        }
        Text {
            anchors.top: lyTitle.bottom
            text: qsTr(actist)
            font.pixelSize: 15
            font.family:"微软雅黑"
            color: "#94a3b8"
        }
    }

    ListView{
        id:lyricslistview
        anchors.right: parent.right
        width: parent.width/2
        height: (parent.height-80)*2/3
        anchors.top:parent.top
        anchors.topMargin: 200
        model:parsedLyrics
        clip: true
        highlightMoveDuration: 300
            delegate: Rectangle{
            id:rec1
            width: lyricslistview. width
            height: 100
            color: index===currentNewIndex? "#7f7f7f" : "#1d1a23"
            Text {
                text: modelData.text
                anchors.centerIn: parent
                color:index=== currentNewIndex?"#ffffff":"#94a3b8"
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

