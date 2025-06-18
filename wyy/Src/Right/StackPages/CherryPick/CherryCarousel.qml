import QtQuick 2.15
import QtQuick.Controls 2.15
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
    //鼠标操作
    MouseArea {
        anchors.fill: parent
        hoverEnabled: true
        onEntered: {
            flick.incarouselSpace = false
            leftArrow.visible = false
            rightArrow.visible = false
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
    Item {
        id: leftArrow
        height: carouselSpace.height
        width: 25
        anchors {
            right: carouselSpace.left
            verticalCenter: carouselSpace.verticalCenter
        }
        visible: false
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
        }
        //鼠标操作
        MouseArea {
            anchors.fill: parent
            hoverEnabled: true
            onEntered: {
                cherryLArrowImg.opacity = 1
                flick.incarouselSpace = true
                visible = true
                rightArrow.visible = true
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
        }
    }
    //右箭头
    Item {
        id: rightArrow
        height: carouselSpace.height
        width: 25
        anchors {
            left: carouselSpace.right
            verticalCenter: carouselSpace.verticalCenter
        }
        visible: false
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
        }
        //鼠标操作
        MouseArea {
            anchors.fill: parent
            hoverEnabled: true
            onEntered: {
                cherryRArrowImg.opacity = 1
                flick.incarouselSpace = true
                leftArrow.visible = true
                visible = true
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
        //鼠标操作
        MouseArea {
            anchors.fill: parent
            hoverEnabled: true
            onEntered: {
                flick.incarouselSpace = true
                leftArrow.visible = true
                rightArrow.visible = true
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
                Item {
                    anchors.centerIn: parent
                    width: parent.width
                    height: parent.height
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
                        anchors.centerIn: parent
                        width: parent.width
                        height: parent.height
                        color: "transparent"
                        Rectangle {
                            anchors.centerIn: parent
                            width: parent.width
                            height: parent.height
                            color: "black"
                            radius: 10
                        }
                        visible: false
                    }
                    //遮罩后的图片
                    OpacityMask {
                        anchors.fill: carouselImg
                        source: carouselImg
                        maskSource: carouselMaskRec
                    }
                    //鼠标操作
                    MouseArea {
                        anchors.fill: parent
                        hoverEnabled: true
                        onEntered: {
                            flick.incarouselSpace = true
                            leftArrow.visible = true
                            rightArrow.visible = true
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
            }
        }
    }

    Path {
        id: carouselIndicatorPath
        startX: 0
        startY: carouselIndicator.height / 2

        PathAttribute {name: "size"; value: 0}

        PathLine {
            x: 18
            y: carouselIndicator.height / 2
        }

        PathAttribute {name: "size"; value: 0}

        PathLine {
            x: 23
            y: carouselIndicator.height / 2
        }

        PathAttribute {name: "size"; value: 6}

        PathLine {
            x: carouselIndicator.width / 2
            y: carouselIndicator.height / 2
        }

        PathAttribute {name: "size"; value: 10}

        PathLine {
            x: carouselIndicator.width - 23
            y: carouselIndicator.height / 2
        }

        PathAttribute {name: "size"; value: 6}

        PathLine {
            x: carouselIndicator.width - 18
            y: carouselIndicator.height / 2
        }

        PathAttribute {name: "size"; value: 0}

        PathLine {
            x: carouselIndicator.width
            y: carouselIndicator.height / 2
        }

        PathAttribute {name: "size"; value: 0}
    }

    //轮播图指示器
    PathView {
        id: carouselIndicator
        width: 118
        height: 10
        anchors {
            top: carouselSpace.bottom
            topMargin: 10
            horizontalCenter: carouselSpace.horizontalCenter
        }
        clip: true
        model: 8
        path: carouselIndicatorPath
        pathItemCount: 8
        interactive: false
        //委托
        delegate: Rectangle {
            width: PathView.size
            height: width
            radius: height / 2
            color: "#a1a1a3"
        }
    }
}

