import QtQuick
import Qt5Compat.GraphicalEffects

Rectangle {
    color: "red"

    id: cherryCarousel
    width: parent.width
    height: carouselImg_Height + carouselIndicator.height + 10
    anchors {
        left: parent.left
        right: parent.right
    }

    //单位宽度
    property double unit_Width: 75
    //图片宽度
    property double carouselImg_Width: unit_Width * (common.horCount + 3)
    //图片高度
    property double carouselImg_Height: carouselImg_Width / 2.5
    //图片间隔
    property double carouselImg_Spacing: 20
    //轮播图区域宽度
    property double carousel_Width: carouselImg_Width * common.horCount + carouselImg_Spacing * (common.horCount - 1)
    //控制区域宽度
    property double carouselSapce_Width: carousel_Width + carouselLArrow.width + carouselRArrow.width

    //动画管理
    Timer {
        id: cherryTimer
        repeat: true
        running: true
        interval: 3000
        onTriggered: {
            carouselLAnimation.start()
        }
    }
    //向左移动
    ParallelAnimation {
        id: carouselLAnimation
        NumberAnimation {
            target: carousel
            properties: "currentIndex"
            from: carousel.currentIndex
            to: carousel.currentIndex + common.horCount
            duration: 100
        }
        NumberAnimation {
            target: carouselIndicator
            properties: "currentIndex"
            from: carouselIndicator.currentIndex
            to: carouselIndicator.currentIndex + 1
            duration: 100
        }
        NumberAnimation {
            duration: 500
        }
    }
    //向右移动
    ParallelAnimation {
        id: carouselRAnimation
        NumberAnimation {
            target: carousel
            properties: "currentIndex"
            from: carousel.currentIndex
            to: carousel.currentIndex - common.horCount
            duration: 100
        }
        NumberAnimation {
            target: carouselIndicator
            properties: "currentIndex"
            from: carouselIndicator.currentIndex
            to: carouselIndicator.currentIndex - 1
            duration: 100
        }
        NumberAnimation {
            duration: 500
        }
    }


    //控制区域
    Item {
        width: carouselSapce_Width
        height: carouselImg_Height
        anchors.horizontalCenter: parent.horizontalCenter
        //鼠标事件
        HoverHandler {
            onHoveredChanged: {
                if(hovered) {
                    carouselLArrow.visible = true
                    carouselRArrow.visible = true
                }
                else {
                    carouselLArrow.visible = false
                    carouselRArrow.visible = false
                }
            }
        }
        //左箭头
        LeftArrow {
            id: carouselLArrow
            //鼠标事件
            HoverHandler {
                cursorShape: Qt.PointingHandCursor
                onHoveredChanged: {
                    if(hovered)
                        carouselLArrow.opacity = 1
                    else
                        carouselLArrow.opacity = 0.6
                }
            }
            TapHandler {
                onTapped: {
                    carouselRAnimation.start()
                    cherryTimer.stop()
                    cherryTimer.start()
                }
            }
        }
        //右箭头
        RightArrow {
            id: carouselRArrow
            //鼠标事件
            HoverHandler {
                cursorShape: Qt.PointingHandCursor
                onHoveredChanged: {
                    if(hovered)
                        carouselRArrow.opacity = 1
                    else
                        carouselRArrow.opacity = 0.6
                }
            }
            TapHandler {
                onTapped: {
                    carouselLAnimation.start()
                    cherryTimer.stop()
                    cherryTimer.start()
                }
            }
        }
        //轮播图区域
        Item {
            width: carousel_Width
            height: parent.height
            anchors.horizontalCenter: parent.horizontalCenter
            clip: true
            //轮播图主体
            PathView {
                id: carousel
                width: (pathItemCount + 1) * carouselImg_Width + pathItemCount * carouselImg_Spacing + 1
                height: parent.height
                anchors {
                    left: parent.left
                    leftMargin: -(carouselImg_Width + carouselImg_Spacing)
                }
                model: carouselModel
                path: carouselPath
                pathItemCount: common.horCount + 1
                interactive: false
                //委托
                delegate: Item {
                    width: cherryCarousel.carouselImg_Width
                    height: carousel.height
                    clip: true
                    //鼠标事件
                    HoverHandler {
                        cursorShape: Qt.PointingHandCursor
                        onHoveredChanged: {
                            if(hovered)
                                carouselHighlightRec.visible = true
                            else
                                carouselHighlightRec.visible = false
                        }
                    }
                    TapHandler {
                        //todo...
                    }
                    //图片
                    Image {
                        id: carouselImg
                        anchors.fill: parent
                        source: src
                        visible: false
                    }
                    //圆角遮罩Rectangle
                    Rectangle {
                        id: carouselMaskRec
                        width: parent.width
                        height: parent.height
                        anchors.centerIn: parent
                        color: "transparent"
                        Rectangle {
                            width: parent.width
                            height: parent.height
                            anchors.centerIn: parent
                            color: "black"
                            radius: 10
                        }
                        visible: false
                    }
                    //遮罩后的图片
                    OpacityMask {
                        anchors.fill: parent
                        source: carouselImg
                        maskSource: carouselMaskRec
                    }
                    //选项高亮强调
                    Rectangle {
                        id: carouselHighlightRec
                        width: parent.width
                        height: parent.height
                        anchors.centerIn: parent
                        color: "gray"
                        radius: 10
                        opacity: 0.1
                        Behavior on opacity {
                            PropertyAnimation {
                                duration: 200
                            }
                        }
                        visible: false
                    }
                }
            }
        }

        ListModel {     //...
            id: carouselModel
            ListElement {src: "qrc:/Src/image/blackImg.png"}
            ListElement {src: "qrc:/Src/image/rightArrow.png"}
            ListElement {src: "qrc:/Src/image/blackImg.png"}
            ListElement {src: "qrc:/Src/image/rightArrow.png"}
            ListElement {src: "qrc:/Src/image/blackImg.png"}
            ListElement {src: "qrc:/Src/image/rightArrow.png"}
        }

        Path {
            id: carouselPath
            startX: cherryCarousel.carouselImg_Width / 2
            startY: carousel.height / 2
            PathLine {
                x: carousel.width - cherryCarousel.carouselImg_Width / 2
                y: carousel.height / 2
            }
        }
    }
    //轮播图指示器
    PathView {
        id: carouselIndicator
        width: 98
        height: 10
        anchors {
            bottom: parent.bottom
            horizontalCenter: parent.horizontalCenter
        }
        clip: true
        model: 6
        path: carouselIndicatorPath
        pathItemCount: 6
        interactive: false
        //委托
        delegate: Rectangle {
            width: PathView.size
            height: width
            radius: height / 2
            color: "black"
            opacity: PathView.opacity
        }
    }

    Path {
        id: carouselIndicatorPath
        startX: 0
        startY: carouselIndicator.height / 2
        PathAttribute {name: "size"; value: 0}
        PathAttribute {name: "opacity"; value: 0.4}

        PathLine {
            x: 13
            y: carouselIndicator.height / 2
        }
        PathAttribute {name: "size"; value: 6}

        PathLine {
            x: 30
            y: carouselIndicator.height / 2
        }
        PathAttribute {name: "size"; value: 8}
        PathAttribute {name: "opacity"; value: 0.4}

        PathLine {
            x: 49
            y: carouselIndicator.height / 2
        }
        PathAttribute {name: "size"; value: 10}
        PathAttribute {name: "opacity"; value: 1}

        PathLine {
            x: 68
            y: carouselIndicator.height / 2
        }
        PathAttribute {name: "size"; value: 8}
        PathAttribute {name: "opacity"; value: 0.4}

        PathLine {
            x: 85
            y: carouselIndicator.height / 2
        }
        PathAttribute {name: "size"; value: 6}

        PathLine {
            x: 98
            y: carouselIndicator.height / 2
        }
        PathAttribute {name: "size"; value: 0}
        PathAttribute {name: "opacity"; value: 0.4}
    }
}
