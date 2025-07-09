#include "songmodel.h"
#include<getlyrics.h>
#include<getimage.h>
#include <QUrl>
#include <QFileInfo>
Songmodel::Songmodel(QObject *parent)
    : QAbstractListModel{parent}
{

}


void Songmodel::scanDirectory(const QString &path)
{
    QString localPath = QUrl(path).toLocalFile();
    QFileInfo info(localPath);
    if (info.isFile()) {
        // 只处理这一首歌
        qDebug() << "localpath";
        TagLib::FileRef f(localPath.toStdString().c_str());
        if(f.isNull()){
            return;
        }
        qDebug() << "localpath"<<localPath;
        TagLib::Tag *tag=f.tag();
        Song song;
        song.title=QString::fromStdString(tag->title().toCString(true));
        song.actist=QString::fromStdString(tag->artist().toCString(true));
        song.album=QString::fromStdString(tag->album().toCString(true));
        song.filePath = localPath;
        song.lyrics = getLyrics(song.filePath);
        song.albumArtPath = getimage(song.filePath);
        addsong(song);
        return;
    }
    QDir dir(path);
    if(!dir.exists()) qDebug() << "faile";
    QStringList filters;
    filters<<"*.mp3";
    QStringList files=dir.entryList(filters,QDir::Files|QDir::NoSymLinks,QDir::Name);

    foreach (QString file, files) {
        QString filepath=dir .absoluteFilePath(file);
        QString realFilePath = filepath;
        if (filepath.startsWith(":/")) {
            QFile resourceFile(filepath);
            if (resourceFile.open(QIODevice::ReadOnly)) {
                QString tempPath = QDir::temp().filePath(QFileInfo(filepath).fileName());
                QFile tempFile(tempPath);
                if (tempFile.open(QIODevice::WriteOnly)) {
                    tempFile.write(resourceFile.readAll());
                    tempFile.close();
                    realFilePath = tempPath;
                }
                resourceFile.close();
            }
        }
        TagLib::FileRef f(realFilePath.toStdString().c_str());
        if(f.isNull()){
            continue;
        }
        TagLib::Tag *tag=f.tag();
        Song song;
        song.title=QString::fromStdString(tag->title().toCString(true));
        song.actist=QString::fromStdString(tag->artist().toCString(true));
        song.album=QString::fromStdString(tag->album().toCString(true));
        song.filePath = realFilePath;
        song.lyrics = getLyrics(song.filePath);
        song.albumArtPath = getimage(song.filePath);
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
    case TitleRole:
        return song.title;
    case ActistRole:
        return song.actist;
    case AlbumRole:
        return song.album;
    case FilePathRole:
        return song.filePath;
    case LycricsRole:
        return song.lyrics;
    case ParsedlyricsRole:
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
    roles[TitleRole]="title";
    roles[ActistRole]="actist";
    roles[AlbumRole]="album";
    roles[FilePathRole]="filepath";
    roles[LycricsRole]="lyrics";
    roles[ParsedlyricsRole]="parsedlyrics";
    roles[AlbumArtRole] = "albumArt";
    return roles;
}

QString Songmodel::getSongFilePath(int index) const
{
    if (index >= 0 && index < m_songs.size()) {
        return m_songs[index].filePath;
    }
    return QString();
}

QString Songmodel::getSongLyrics(int index) const
{
    if (index >= 0 && index < m_songs.size()) {
        return m_songs[index].lyrics;
    }
    return QString();
}

QString Songmodel::getSongAlbumArt(int index) const
{
    if (index >= 0 && index < m_songs.size()) {
        return m_songs[index].albumArtPath;
    }
    return QString();
}

QString Songmodel::getSongTitle(int index) const
{
    if(index>=0&&index<m_songs.size()){
        return m_songs[index].title;
    }
    return QString();
}

QString Songmodel::getSongActist(int index) const
{
    if(index>=0&&index<m_songs.size()){
        return m_songs[index].actist;
    }
    return QString();
}



