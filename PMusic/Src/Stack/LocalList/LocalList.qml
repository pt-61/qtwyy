import QtQuick
import QtQuick.Controls
import QtQuick.Dialogs
import QtCore
import Qt.labs.platform

Rectangle {
    FileDialog {
        id: _fileOpen
        title: "选择音乐文件夹"
        fileMode: FileDialog.OpenFiles
        folder: StandardPaths.writableLocation(StandardPaths.DocumentsLocation)
        nameFilters: [ "Audio files (*.mp3 *.wav *.ogg)" ]
        onAccepted: {
            let folderPath = _fileOpen.file
            songmodel.scanDirectory(folderPath);
        }
    }
    Rectangle{
        id:localtop
        height: parent.height/3
        width: parent.width
        anchors.top: parent.top
        anchors.left: parent.left
        Text {
            anchors.top: parent.top
            anchors.topMargin: 50
            id:localplay
            text: qsTr("local play")
            font.pixelSize: 20
        }
        Button{
            anchors.top: localplay.bottom
            text: "play all"
            onClicked: {
                _fileOpen.open()
            }
        }
    }
    color: leftColor
    property string modelname: "songmodel"
    ListView{
        id:listview
        clip: true
        anchors.top: localtop.bottom
        anchors.left: parent.left
        height: parent.height/3
        width: parent.width
        model: songmodel
        currentIndex:-1
        delegate: Rectangle{
            id:localre
            color: "#f7f9fc"
            width: parent.width
            height: 60
            Text {
                id:indexname
                text: "0"+index
            }
            Text{
                anchors.left: indexname.right
                id:titlename
                text: title
            }
            Text {
                anchors.top: titlename.bottom
                anchors.left: titlename.left
                id: actistname
                text: actist
            }
            Text {
                anchors.left: parent.left
                anchors.leftMargin: parent.width/2
                id: albumname
                text: album
            }

            HoverHandler{
                onHoveredChanged: {
                    if(hovered){
                        localre.color="red"
                    }else{
                        localre.color="#f7f9fc"
                    }
                }
            }
            TapHandler{
                onTapped: {
                songmodel.playmusic(filepath,lyrics,albumArt,index,listview.count,title,actist)
                console.log(modelname)
                }
            }
        }
    }

    Connections{
        target: songmodel
        function onFindindex(pindex){
            listview.currentIndex=pindex
            console.log("findindex called with:", pindex)
            var filepath = songmodel.getSongFilePath(pindex)
            var lyrics = songmodel.getSongLyrics(pindex)
            var albumArt = songmodel.getSongAlbumArt(pindex)
            var title=songmodel.getSongTitle(pindex)
            var actist=songmodel.getSongActist(pindex)
            songmodel.playmusic(filepath, lyrics, albumArt, pindex, listview.count,title,actist)
            songmodel.isplay()
        }
    }

}
