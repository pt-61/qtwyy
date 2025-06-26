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
Q_DECLARE_METATYPE(Lrcline)


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
Q_DECLARE_METATYPE(QList<Lrcline>)

class Songmodel : public QAbstractListModel
{
    Q_OBJECT
public:
    enum SongRole{
        TitleRloe=Qt::UserRole+1,
        ActistRloe,
        AlbumRloe,
        FilePathRloe,
        LycricsRloe,
        ParsedlyricsRloe,
        AlbumArtRole
    };

    explicit Songmodel(QObject *parent = nullptr);
    void scanDirectory(const QString &path);
    void addsong(const Song &song);

    //Q_INVOKABLE void addsongFromData(const Song &song);

    int rowCount(const QModelIndex &parent) const override;
    QVariant data(const QModelIndex &index, int role) const override;

protected:
    QHash<int,QByteArray>roleNames()const override;

private:
    QList<Song>m_songs;
signals:
    void some();
};

#endif // SONGMODEL_H
