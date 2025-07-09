import QtQuick

Item {
    Rectangle{
        id:musictop
        width: parent.width
        height: parent.height/3
        anchors.top: parent.top
        anchors.left: parent.left
        Image {
            height: width
            width: parent.width/4
            anchors.top: musictop.top
            source: "file:///"+songmodel1.getSongAlbumArt(0)
        }
        Rectangle{
            anchors.bottom: parent.bottom
            width: parent.width
            height: parent.height/4
            Text {
                id: mname
                text: qsTr("标题")
                anchors.left: parent.left
                anchors.leftMargin: 90
                width: 50
            }
            Text {
                anchors.left:mname.right
                anchors.leftMargin:70
                text: qsTr("专辑")
            }
        }
    }
    property int currentindex: -1
    ListView{
        anchors.top: musictop.bottom
        id:listview
        anchors.left: parent.left
        height: parent.height/3
        width: parent.width
        model: songmodel1
        currentIndex:-1
        delegate: Rectangle{
            id:mrc
            color: "#f7f9fc"
            width: parent.width
            height: 60
            Text {
                id:mindex
                anchors.left: parent.left
                text: "0"+index
            }
            Image {
                anchors.left: mindex.right
                height: parent.height
                width: 50
                id: mimage
                source: "file:///"+albumArt

            }
            Text{
                id:mtitle
                width: 30
                anchors.left: mimage.right
                anchors.leftMargin: 10
                text: title
                color: currentindex===index?"red":"balck"
            }
            Text {
                id: mname1
                text:actist
                width: 30
                anchors.left: mtitle.left
                anchors.top: mtitle.bottom
            }
            Text {
                id:malbum
                anchors.left: mtitle.right
                anchors.leftMargin : 100
                text: album
            }
            TapHandler{
                onTapped: {
                    currentindex=index
                    songmodel1.playmusic(filepath,lyrics,albumArt,index,listview.count,title,actist)
                }
            }
            HoverHandler{
                onHoveredChanged: {
                    if(hovered){
                        mrc.color="#ffffff"
                    }else{
                       mrc.color="#f7f9fc"
                    }
                }
            }
        }
    }

    Connections{
        target: songmodel1
        function onFindindex(pindex){
            listview.currentIndex=pindex
            console.log("findindex called with:", pindex)
            var filepath = songmodel1.getSongFilePath(pindex)
            var lyrics = songmodel1.getSongLyrics(pindex)
            var albumArt = songmodel1.getSongAlbumArt(pindex)
            var title=songmodel1.getSongTitle(pindex)
            var actist=songmodel1.getSongActist(pindex)
            songmodel1.playmusic(filepath, lyrics, albumArt, pindex, listview.count,title,actist)
           // songmodel1.isplay()
        }
    }
}
