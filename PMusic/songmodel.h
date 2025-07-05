#ifndef SONGMODEL_H
#define SONGMODEL_H

#include<QAbstractListModel>
#include <QObject>
#include<QString>
#include<QHash>
#include<QByteArray>
#include<QStringList>
#include<QDir>
#include<QFileInfo>
#include<taglib/taglib.h>
#include<taglib/fileref.h>
#include<taglib/tag.h>
#include<QTextStream>
#include<QRegularExpression>
#include<QList>
#include<QFile>
#include<taglib/id3v2tag.h>
#include <taglib/attachedpictureframe.h>
#include<QDirIterator>

struct Lrcline
{
    int time;
    QString text;
};


class Song{
public:
    QString title;
    QString actist;
    QString album;
    QString filePath;
    QString lyrics;
    QList<Lrcline>parsedlyrics;
    QString albumArtPath;

};


class Songmodel : public QAbstractListModel
{
    Q_OBJECT
public:
    enum SongRole{
        TitleRole=Qt::UserRole+1,
        ActistRole,
        AlbumRole,
        FilePathRole,
        LycricsRole,
        ParsedlyricsRole,
        AlbumArtRole
    };

    explicit Songmodel(QObject *parent = nullptr);
    void scanDirectory(const QString &path);
    void addsong(const Song &song);


    int rowCount(const QModelIndex &parent) const override;
    QVariant data(const QModelIndex &index, int role) const override;
    Q_INVOKABLE QString getSongFilePath(int index) const;
    Q_INVOKABLE QString getSongLyrics(int index) const;
    Q_INVOKABLE QString getSongAlbumArt(int index) const;
    Q_INVOKABLE QString getSongTitle(int index)const;
    Q_INVOKABLE QString getSongActist(int index)const;
protected:
    QHash<int,QByteArray>roleNames()const override;

private:
    QList<Song>m_songs;
signals:
    void findindex(int index);
    void playmusic(QString path,QString lycrics ,QString alubmartpath,int index,int listviewcount,QString title,QString actist);
};

#endif // SONGMODEL_H
