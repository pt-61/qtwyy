import QtQuick 2.15
import QtQuick.Controls 2.15
import Qt5Compat.GraphicalEffects

Item {
    Flickable {
        id: flick
        contentHeight: 2200
        anchors.fill: parent
        clip: true
        property double insideWidth: width * 0.9
        property bool incarouselSpace: false
        property int horCount: 2
        Column {
            anchors {
                topMargin: 20
                fill: parent
            }
            spacing: 30
            clip: true

            //轮播图
            CherryCarousel {}
            //内容推荐
            Rectangle {
                color: "blue"

                width: parent.width
                height: parent.height - 300
                anchors {
                    left: parent.left
                    right: parent.right
                }

                //官方歌单
                Rectangle {
                    color: "green"

                    height: 320
                    anchors {
                        left: parent.left
                        right: parent.right
                    }

                    //官方歌单 >
                    Label {
                        id: cherryPlaylistLabel
                        anchors {
                            top: parent.top
                            left: cherryPlaylistSpace.left
                        }
                        text: "官方歌单 >"
                        color: "black"
                        font {
                            pixelSize: 24
                            family: "黑体"
                            bold: true
                        }
                        MouseArea {
                            anchors.fill: parent
                            hoverEnabled: true
                            onEntered: {
                                cursorShape = Qt.PointingHandCursor
                            }
                            onExited: {
                                cursorShape = Qt.ArrowCursor
                            }
                            onClicked: {
                                //todo
                            }
                        }
                    }

                    //官方歌单区域
                    Rectangle {
                        color: "red"

                        id: cherryPlaylistSpace
                        width: flick.insideWidth
                        height: parent.height * 0.925 - cherryPlaylistLabel.height
                        anchors {
                            top: cherryPlaylistLabel.bottom
                            horizontalCenter: parent.horizontalCenter
                        }
                        clip: true

                        ListModel {     //...
                            id: cherryPlaylistModel
                            ListElement {src: "/blackImg.png"; titleText: "1"}
                            ListElement {src: "/rightArrow.png"; titleText: "2"}
                            ListElement {src: "/blackImg.png"; titleText: "3"}
                            ListElement {src: "/rightArrow.png"; titleText: "4"}
                            ListElement {src: "/blackImg.png"; titleText: "5"}
                            ListElement {src: "/rightArrow.png"; titleText: "6"}
                        }

                        Path {
                            id: cherryPlaylistPath
                            startX: cherryPlaylistRow.itemWidth / 2
                            startY: cherryPlaylistRow.height / 2
                            PathLine {
                                x: cherryPlaylistRow.width - cherryPlaylistRow.itemWidth / 2
                                y: cherryPlaylistRow.height / 2
                            }
                        }

                        //官方歌单主体
                        PathView {
                            id: cherryPlaylistRow
                            property int cherryPlaylistSpacing: 20
                            property double itemWidth: (parent.width - (flick.horCount * 2 - 1) * cherryPlaylistSpacing) / (flick.horCount * 2)
                            width: (pathItemCount + 1) * itemWidth + pathItemCount * cherryPlaylistSpacing
                            height: parent.height
                            anchors {
                                left: parent.left
                                leftMargin: -(itemWidth + cherryPlaylistSpacing)
                            }
                            model: cherryPlaylistModel
                            path: cherryPlaylistPath
                            pathItemCount: flick.horCount * 2 + 2
                            clip: true
                            //interactive: false
                            //委托
                            delegate: Rectangle {
                                width: cherryPlaylistRow.itemWidth
                                height: cherryPlaylistRow.height
                                clip: true

                                Image {
                                    anchors.fill: parent
                                    source: src
                                }

                                Rectangle {
                                    width: parent.width
                                    height: parent.height - parent.width
                                    anchors.bottom: parent.bottom
                                    color: "gray"
                                    Text {
                                        width: parent.width
                                        height: parent.height
                                        anchors.centerIn: parent
                                        color: "white"
                                        text: titleText
                                        font {
                                            pixelSize: 20
                                            family: "黑体"
                                            bold: true
                                        }
                                    }
                                }

                                MouseArea {
                                    anchors.fill: parent
                                    hoverEnabled: true
                                    onEntered: {
                                        //todo
                                        cursorShape = Qt.PointingHandCursor
                                    }
                                    onExited: {
                                        //todo
                                        cursorShape = Qt.ArrowCursor
                                    }
                                    onClicked: {
                                        //todo
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}
