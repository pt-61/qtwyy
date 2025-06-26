
#include<getlyrics.h>
#include<string>
QString getLyrics(const QString &filePath){
    TagLib::MPEG::File mpegFile(filePath.toStdString().c_str(),TagLib::ID3v2::FrameFactory::instance());

    if(mpegFile.ID3v2Tag()){
        qDebug()<<"try open id3v2";
        TagLib::ID3v2::Tag*id3v2=mpegFile.ID3v2Tag();

        TagLib::ID3v2::FrameList lyrs=id3v2->frameListMap()["USLT"];
        if(lyrs.isEmpty())qDebug()<<"2";
        if(!lyrs.isEmpty()){
            TagLib::ID3v2::UnsynchronizedLyricsFrame*lyricsFrame=dynamic_cast<TagLib::ID3v2::UnsynchronizedLyricsFrame*>(lyrs.front());
            if(lyricsFrame){
                qDebug()<<filePath;
                qDebug()<<"find uslt";
                return lyricsFrame->text().toCString(true);
            }
        }
    }
    return"";
}
