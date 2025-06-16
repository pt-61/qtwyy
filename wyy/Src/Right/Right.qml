import QtQuick 2.15
import QtQuick.Controls

 Rectangle{
    Toptitle{
        id:righttoptitle
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: parent.top
        height: 60

    }
    StackView{
        id:mainstack
        anchors.top: righttoptitle.bottom
        anchors.right: parent.right
        anchors.left: parent.left
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 100
        clip: true
        initialItem: "qrc:/Src/Right/StackPages/SelectedPages.qml"
    }
 }
