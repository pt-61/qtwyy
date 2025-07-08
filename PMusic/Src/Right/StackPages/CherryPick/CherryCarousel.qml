import QtQuick
import QtQuick.Controls
import Qt5Compat.GraphicalEffects

Rectangle {
    color: "red"

    id: cherrySpace
    width: parent.width
    height: 240
    anchors {
        left: parent.left
        right: parent.right
    }
    //鼠标穿透
    MouseArea {
        anchors.fill: parent
        hoverEnabled: true
        onEntered: {
            flick.incarouselSpace = false
            cherryLArrowImg.visible = false
            cherryRArrowImg.visible = false
        }
    }

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

    //左箭头
    Rectangle {
        color: "yellow"

        height: carouselSpace.height
        width: 25
        anchors {
            right: carouselSpace.left
            verticalCenter: carouselSpace.verticalCenter
        }
        Behavior on opacity {
            PropertyAnimation{
                duration: 200
            }
        }
        //图片
        Image {
            id: cherryLArrowImg
            anchors.centerIn: parent
            opacity: 0.6
            mirror: true
            source: "/rightArrow.png"
            //visible: false
        }

        TapHandler {
            //active: true
            cursorShape: Qt.PointingHandCursor
            onTapped: {
                carouselRAnimation.start()
                cherryTimer.stop()
                cherryTimer.start()
            }
        }

        //鼠标穿透
        /*MouseArea {
            anchors.fill: parent
            hoverEnabled: true
            onEntered: {
                cherryLArrowImg.opacity = 1
                flick.incarouselSpace = true
                cherryLArrowImg.visible = true
                cherryRArrowImg.visible = true
                cursorShape = Qt.PointingHandCursor
            }
            onExited: {
                cherryLArrowImg.opacity = 0.6
                cursorShape = Qt.ArrowCursor
            }
            onClicked: {
                carouselRAnimation.start()
                cherryTimer.stop()
                cherryTimer.start()
            }
        }*/
    }
    //右箭头
    Item {
        height: carouselSpace.height
        width: 25
        anchors {
            left: carouselSpace.right
            verticalCenter: carouselSpace.verticalCenter
        }
        Behavior on opacity {
            PropertyAnimation{
                duration: 200
            }
        }
        //图片
        Image {
            id: cherryRArrowImg
            anchors.centerIn: parent
            opacity: 0.6
            source: "/rightArrow.png"
            visible: false
        }
        //鼠标穿透
        MouseArea {
            anchors.fill: parent
            hoverEnabled: true
            onEntered: {
                cherryRArrowImg.opacity = 1
                flick.incarouselSpace = true
                cherryLArrowImg.visible = true
                cherryRArrowImg.visible = true
                cursorShape = Qt.PointingHandCursor
            }
            onExited: {
                cherryRArrowImg.opacity = 0.6
                cursorShape = Qt.ArrowCursor
            }
            onClicked: {
                carouselLAnimation.start()
                cherryTimer.stop()
                cherryTimer.start()
            }
        }
    }

    //向左移动
    ParallelAnimation {
        id: carouselLAnimation
        NumberAnimation {
            target: carouselRow
            properties: "currentIndex"
            from: carouselRow.currentIndex
            to: carouselRow.currentIndex + flick.horCount
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
            target: carouselRow
            properties: "currentIndex"
            from: carouselRow.currentIndex
            to: carouselRow.currentIndex - flick.horCount
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

    //轮播图区域
    Rectangle {
        color: "green"

        id: carouselSpace
        width: flick.insideWidth
        height: parent.height * 0.85 - carouselIndicator.height
        anchors {
            top: parent.top
            topMargin: parent.height * 0.075
            horizontalCenter: parent.horizontalCenter
        }
        clip: true
        //鼠标穿透
        MouseArea {
            anchors.fill: parent
            hoverEnabled: true
            onEntered: {
                flick.incarouselSpace = true
                cherryLArrowImg.visible = true
                cherryRArrowImg.visible = true
            }
        }

        ListModel {     //...
            id: carouselModel
            ListElement {src: "/blackImg.png"}
            ListElement {src: "/rightArrow.png"}
            ListElement {src: "/blackImg.png"}
            ListElement {src: "/rightArrow.png"}
            ListElement {src: "/blackImg.png"}
            ListElement {src: "/rightArrow.png"}
        }

        Path {
            id: carouselRowPath
            startX: carouselRow.itemWidth / 2
            startY: carouselRow.height / 2
            PathLine {
                x: carouselRow.width - carouselRow.itemWidth / 2
                y: carouselRow.height / 2
            }
        }

        //轮播图主体
        PathView {
            id: carouselRow
            property int spacingWidth: 10
            property double itemWidth: (parent.width - (flick.horCount - 1) * spacingWidth) / flick.horCount
            width: (pathItemCount + 1) * itemWidth + pathItemCount * spacingWidth + 1
            height: parent.height
            anchors {
                left: parent.left
                leftMargin: -(itemWidth + spacingWidth)
            }
            model: carouselModel
            path: carouselRowPath
            pathItemCount: flick.horCount + 2
            clip: true
            interactive: false
            //委托
            delegate: Item {
                width: carouselRow.itemWidth
                height: carouselSpace.height
                clip: true

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

                Text {

                }

                //指示提示强调
                Rectangle {
                    id: carouselItemRec
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

                //鼠标穿透
                MouseArea {
                    anchors.fill: parent
                    hoverEnabled: true
                    onEntered: {
                        flick.incarouselSpace = true
                        carouselItemRec.visible = true
                        cherryLArrowImg.visible = true
                        cherryRArrowImg.visible = true
                        cursorShape = Qt.PointingHandCursor
                    }
                    onExited: {
                        carouselItemRec.visible = false
                        cursorShape = Qt.ArrowCursor
                    }
                    onClicked: {
                        //todo
                    }
                }
            }
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

    //轮播图指示器
    PathView {
        id: carouselIndicator
        width: 98
        height: 10
        anchors {
            top: carouselSpace.bottom
            topMargin: 10
            horizontalCenter: carouselSpace.horizontalCenter
        }

        Rectangle {
            //color: "blue"
            width: parent.width
            height: parent.height
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
}

