#ifndef GETLYRICS_H
#define GETLYRICS_H

#include<taglib/fileref.h>
#include<taglib/id3v2tag.h>
#include<taglib/id3v1tag.h>
#include<taglib/textidentificationframe.h>
#include<QString>
#include<QDebug>
#include<taglib/unsynchronizedlyricsframe.h>
#include<taglib/apetag.h>
#include<taglib/mpegfile.h>
#include<taglib/tstring.h>
QString getLyrics(const QString&filePath);

#endif // GETLYRICS_H
