#include "songmodel.h"
//#include<getlyrics.h>
//#include<getimage.h>
Songmodel::Songmodel(QObject *parent)
    : QAbstractListModel{parent}
{

}


void Songmodel::scanDirectory(const QString &path)
{

    QDir dir(path);
    if(!dir.exists())qDebug()<<"faile";
    QStringList filters;
    filters<<"*.mp3";
    QStringList files=dir .entryList(filters,QDir::Files|QDir::NoSymLinks,QDir::Name);
    foreach (QString file, files) {
        QString filepath=dir .absoluteFilePath(file);
        TagLib::FileRef f(filepath.toStdString().c_str());
        if(f.isNull()){
            continue;
        }
        TagLib::Tag *tag=f.tag();
        Song song;
        song.title=QString::fromStdString(tag->title().toCString(true));
        song.actist=QString::fromStdString(tag->artist().toCString(true));
        song.album=QString::fromStdString(tag->album().toCString(true));
        song.filePath=filepath;
       // song.lyrics=getLyrics(song.filePath);
        //song.albumArtPath=getimage(song.filePath);

        if(!song.lyrics.isEmpty()){
            QRegularExpression rx("\\[(\\d+):(\\d+)\\.(\\d+)\\](.*)");
            QStringList lines=song.lyrics.split("\n");

            foreach (const QString &line,lines) {
                QRegularExpressionMatch match=rx.match(line);
                if(match.hasMatch()){
                    bool ok;
                    int min=match.captured(1).toInt(&ok);
                    if(!ok) continue;
                    int sec=match.captured(2).toInt(&ok);
                    if(!ok) continue;
                    int cs=match.captured(3).toInt(&ok);
                    if(!ok)continue;

                    Lrcline lrclin;
                    lrclin.time=min*60000+sec*1000+cs*10;
                    lrclin.text=match.captured(4).trimmed();

                    song.parsedlyrics.append(lrclin);
                }
            }
        }

        addsong(song);
    }

}

void Songmodel::addsong(const Song &song)
{
    beginInsertRows(QModelIndex(),m_songs.size(),m_songs.size());
    m_songs.append(song);
    endInsertRows();
}



int Songmodel::rowCount(const QModelIndex &parent) const
{
    return m_songs.size();
}

QVariant Songmodel::data(const QModelIndex &index, int role) const
{
    if(!index.isValid()||index.row()>=m_songs.size())
        return QVariant();
    const Song &song=m_songs[index.row()];
    switch (role) {
    case TitleRloe:
        return song.title;
    case ActistRloe:
        return song.actist;
    case AlbumRloe:
        return song.album;
    case FilePathRloe:
        return song.filePath;
    case LycricsRloe:
        return song.lyrics;
    case ParsedlyricsRloe:
        return QVariant::fromValue( song.parsedlyrics);
    case AlbumArtRole:
        return song.albumArtPath;
    default:
        return QVariant();
    }
}

QHash<int, QByteArray> Songmodel::roleNames() const
{
    QHash<int,QByteArray>roles;
    roles[TitleRloe]="title";
    roles[ActistRloe]="actist";
    roles[AlbumRloe]="album";
    roles[FilePathRloe]="filepath";
     roles[LycricsRloe]="lyrics";
    roles[ParsedlyricsRloe]="parsedlyrics";
      roles[AlbumArtRole] = "albumArt";
    return roles;
}
