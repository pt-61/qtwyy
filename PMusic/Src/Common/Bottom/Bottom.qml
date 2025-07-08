import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtMultimedia
import Qt5Compat.GraphicalEffects

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
    property string title: ""
    property string actist: ""
    property var modelname:[]

    Item{
        anchors.top: parent.top
        anchors.topMargin: 10
        anchors.left: parent.left
        anchors.leftMargin: 10
        width: 50
        height: 50
        Image {
            id:musicpicture
            sourceSize: Qt.size(parent.width,parent.height)
            visible: false
        }
        RotationAnimation on  rotation {
            from: 0
            to:360
            duration: 1500
            loops: Animation.Infinite
            running: isplay
        }
        Rectangle{
            id:mask
            width: 50
            height: 50
            radius: width/2
            visible: true
        }
        OpacityMask{
            anchors.fill: musicpicture
            source: musicpicture
            maskSource: mask
        }
        TapHandler{
            onTapped: {
                lywindow.state="big"
            }
        }
    }


    Image {
        id:p
        source: "qrc:/stop2.png"
        anchors.top: parent.top
        anchors.topMargin: 5
        anchors.left: parent.left
        anchors.leftMargin: parent.width/2
        TapHandler{
            onTapped: {
                if(isplay===true){
                player.pause()
                isplay=false
                p.source="qrc:/lyimage/pause.png"
                }
                else{
                player.play()
                isplay=true
                p.source="qrc:/stop2.png"
                }
            }
        }
        HoverHandler{
           onHoveredChanged: {
                if(hovered){
                    p.opacity=0.8
                }else{
                    p.opacity=1
                }
            }
        }
    }
    Image {
        id:boleft
        source: "qrc:/left.png"
        anchors.verticalCenter: p.verticalCenter
        anchors.right: p.left
        anchors.rightMargin: 30
        TapHandler{
            onTapped: {
                console.log("a:",listviewIndex)
                var a=(listviewIndex-1+count)%count
                songmodel.findindex(a)
            }
        }
        HoverHandler{
            onHoveredChanged: {
                if(hovered){
                    boleft.opacity=0.8
                }else{
                    boleft.opacity=1
                }
            }
        }

    }
    Image {
        id:boright
        source: "qrc:/right.png"
        anchors.verticalCenter: p.verticalCenter
        anchors.left: p.right
        anchors.leftMargin: 30
        TapHandler{
            onTapped: {
                console.log("b:",listviewIndex)
                var b=(listviewIndex+1+count)%count
                songmodel1.findindex(b)
            }
        }
        HoverHandler{
            onHoveredChanged: {
                if(hovered){
                    boright.opacity=0.8
                }else{
                    boright.opacity=1
                }
            }
        }
    }
    Rectangle{
        anchors.left: volumerc.left
        anchors.leftMargin: 15
        anchors.bottom: volumerc.top
        id:volumesilder
        height: 50
        width: 20
        color: "#343439"
        visible: false
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
        id: volumerc
        anchors.verticalCenter: parent.verticalCenter
        anchors.right: parent.right
        anchors.rightMargin: 200
        source: "qrc:/song.png"
            TapHandler{
                onTapped: {
                if(volumesilder.visible===false){
                    volumesilder.visible=true
                    }
                else{
                    volumesilder.visible=false
                }
                }
            }
        }
    Image {
        id: listpaly
        source: "qrc:/lyimage/lylistview.png"
        anchors.right: parent.right
        anchors.rightMargin: 100
        TapHandler{
            onTapped: {
                listpopup.x=listpaly.x
                listpopup.y=listpaly.y-listpopup.height
                listpopup.open()
            }
        }
    }

    Popup{
        id:listpopup
        height: 200
        width: 100+listpaly.width
        background:Rectangle {
            color: "red"
            ListView{
                model: modelname
                anchors.fill: parent
                delegate: Rectangle{
                    height: 50
                    width: 150
                    color: index===listviewIndex?"red":"blue"
                    Text {
                        anchors.left: parent.left
                        text: title
                    }
                }
            }
        }
    }

    RowLayout{
        width:parent.width
        id:playerrow 
        anchors.left: parent.left
        anchors.top: parent.top
        Text {
            text:formatTion(currentTime)
        }
        Slider{
            id:timeslider
            anchors.top: parent.top
            Layout.fillWidth:true
            from: 0
            to:parsedLyrics[parsedLyrics.length-1].time+10
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
                implicitHeight: 5
                implicitWidth: 5
                radius: 8
                color: timeslider.pressed?"#ffffff":"#fc3d49"
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


    Player{
        id:player

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
