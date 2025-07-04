import QtQuick
import QtQuick.Controls
import QtQuick.Window
//import "./Src/Left"
//import "./Src/Right"
//import "./Src/Playmusic"
import "./Src/Common"

Window {
    id:window
    width: 1050//1314
    height: 750//933
    visible: true
    //界面边框处理
    flags: Qt.FramelessWindowHint|Qt.Window|Qt.WindowSystemMenuHint|Qt.WindowMaximizeButtonHint|Qt.WindowMinimizeButtonHint
    title: qsTr("Demo Music Player")

    Common {
        anchors.fill: parent
    }
    /*ListView{
        id:listview
        anchors.top: parent.top
        anchors.left: parent.left
        height: 100
        width: 100
        model: songmodel
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
                songmodel.playmusic(filepath,lyrics,albumArt,index,listview.count)
            }
        }
        }
    }
   */
    Connections{
        target: songmodel
        function onFindindex(pindex){
            listview.currentIndex=pindex
            console.log("findindex called with:", pindex)
            var filepath = songmodel.getSongFilePath(pindex)
            var lyrics = songmodel.getSongLyrics(pindex)
            var albumArt = songmodel.getSongAlbumArt(pindex)
            songmodel.playmusic(filepath, lyrics, albumArt, pindex, listview.count)
            songmodel.isplay()
        }
    }
}
