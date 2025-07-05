#include"getimage.h"
QString getimage(const QString &filePath){
    TagLib::MPEG::File mpegFile(filePath.toStdString().c_str(),TagLib::ID3v2::FrameFactory::instance());
    TagLib::ID3v2::Tag*id3v2=mpegFile.ID3v2Tag();
    TagLib::ID3v2::FrameList frames = id3v2->frameList();
    for (auto*frame:frames) {
        if (frame->frameID() == "APIC") {
            TagLib::ID3v2::AttachedPictureFrame *apicFrame =
                dynamic_cast<TagLib::ID3v2::AttachedPictureFrame*>(frame);
            if (apicFrame) {
                // 正确获取图片数据
                TagLib::ByteVector pictureData = apicFrame->picture();
                QByteArray imageData = QByteArray::fromRawData(
                    pictureData.data(),
                    pictureData.size()
                    );
                // 创建唯一文件名（基于文件路径的哈希）
                QString fileName = QFileInfo(filePath).baseName();
                QString tempPath = QCoreApplication::applicationDirPath() +
                                   "/album_art_" + fileName + ".jpg";

                QFile imageFile(tempPath);
                if (imageFile.open(QIODevice::WriteOnly)) {
                    imageFile.write(imageData);
                    imageFile.close();
                    qDebug() << "成功提取专辑图片:" << tempPath;
                    return tempPath;
                } else {
                    qDebug() << "无法创建图片文件:" << tempPath;
                    return "";
                }
            }
        }
    }

    qDebug() << "文件没有专辑图片:" << filePath;
    return "";


}
