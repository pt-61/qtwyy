#ifndef GETIMAGE_H
#define GETIMAGE_H
#include<taglib/fileref.h>
#include<taglib/id3v2tag.h>
#include<taglib/id3v1tag.h>
#include<taglib/textidentificationframe.h>
#include<QString>
#include<QDebug>
#include<taglib/mpegfile.h>
#include<taglib/tstring.h>
#include<taglib/attachedpictureframe.h>
#include<qfileinfo.h>
#include<qcoreapplication.h>
QString getimage(const QString &filePath);
#endif // GETIMAGE_H
