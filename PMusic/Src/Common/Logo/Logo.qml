import QtQuick

Rectangle {
    color: leftColor
    ListView{
        id:listview
        anchors.top: parent.top
        anchors.left: parent.left
        height: 100
        width: 100
        model: songmodel1
        currentIndex:-1
        delegate: Rectangle{
            color: "red"
            width: 30
            height: 30
            Text{
                text: title
            }
            TapHandler{
                onTapped: {
                    songmodel1.playmusic(filepath,lyrics,albumArt,index,listview.count,title,actist)
                    ListView.model
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
