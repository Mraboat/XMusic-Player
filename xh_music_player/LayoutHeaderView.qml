import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Layouts
import "./common"
import QtQuick.Window 2.12

//顶部工具栏
ToolBar{
    property point point: Qt.point(x,y)
    property bool isSmallWindow: false

    width: parent.width
    Layout.fillWidth: true
    height: 32
    background: Rectangle{
        color: "#10e03456"
    }

    RowLayout{
        anchors.fill: parent
        MusicToolButton{
            iconSource: "qrc:/images/music"
            toolTip: "Music"
            onClicked: {
                Qt.openUrlExternally("https://www.kugou.com/share/5WZLjbdCNV2.html?id=5WZLjbdCNV2#w5hkmad")
            }
        }
        MusicToolButton{
            iconSource: "qrc:/images/about"
            toolTip: "关于"
            onClicked: {
                aboutPop.open()
            }
        }
        MusicToolButton{
            id:smallWindow
            iconSource: "qrc:/images/small-window"
            toolTip: "小窗播放"
            visible: !isSmallWindow
            onClicked: {
                setWindowSize(330,600)
                // visible = false
                // normalWindow.visible = true
                setFullScreenVisible()
                pageHomeView.visible = false
                pageDetailView.visible = true
                isSmallWindow = true
                appBackground.showDefaultBackground = pageHomeView.visible

            }
        }
        MusicToolButton{
            id:normalWindow
            iconSource: "qrc:/images/exit-small-window"
            toolTip: "退出小窗播放"
            visible: isSmallWindow
            onClicked: {
                setWindowSize()
                setFullScreenVisible()
                // visible = false
                // smallWindow.visible = true
                isSmallWindow = false
                appBackground.showDefaultBackground = pageHomeView.visible
            }
        }
        Item{
            Layout.fillWidth: true
            height: 32
            Text{
                anchors.centerIn: parent
                text: qsTr("XPlayer")
                font.family: window.mFONT_FAMILY
                font.pointSize: 15
                color: "#ffffff"
            }
            MouseArea{
                anchors.fill: parent
                acceptedButtons: Qt.LeftButton
                onPressed: setPoint(mouseX,mouseY)
                onMouseXChanged: moveX(mouseX)
                onMouseYChanged: moveY(mouseY)
            }
        }
        MusicToolButton{
            iconSource: "qrc:/images/minimize-screen"
            toolTip: "最小化"
            onClicked: {
                window.hide()
            }
        }
        MusicToolButton{
            id:resize
            iconSource: "qrc:/images/small-screen"
            toolTip: "退出全屏"
            visible: false
            onClicked: {
                setSmallScreenVisible()
                setWindowSize()
                visible = false
                maxWindow.visible = true
            }
        }
        MusicToolButton{
            id:maxWindow
            iconSource: "qrc:/images/full-screen"
            toolTip: "全屏"
            onClicked: {
                setSmallScreenVisible()
                window.visibility = Window.Maximized
                visible = false
                resize.visible = true
            }
        }
        MusicToolButton{
            iconSource: "qrc:/images/power"
            toolTip: "退出"
            onClicked: {
                Qt.quit()
            }
        }
    }

    Popup{
        //padding: 0

        id:aboutPop
        x: (parent.width - width)/2
        y: (parent.height - height)/2
        parent: Overlay.overlay
        width: 250
        height: 230
        background: Rectangle{
            color: "#e9f4ff"
            radius: 5
            border.color: "#2273a7ab"
        }
        contentItem: ColumnLayout{
            width: 100
            height: 100
            Image {
                Layout.preferredHeight: 60
                source: "qrc:/images/music"
                fillMode: Image.PreserveAspectFit
                Layout.fillWidth: true
            }
            Text {
                text: qsTr("XPlayer")
                Layout.fillWidth: true
                horizontalAlignment: Text.AlignHCenter
                font.pixelSize: 18
                color: "#8573a7ab"
                font.family: window.mFONT_FAMILY
                font.bold: true
            }
            Text {
                text: qsTr("https://www.kugou.com/")
                Layout.fillWidth: true
                horizontalAlignment: Text.AlignHCenter
                font.pixelSize: 16
                color: "#8573a7ab"
                font.family: window.mFONT_FAMILY
                font.bold: true
            }
        }
    }

    function setWindowSize(width=window.mWINDOW_WIDTH,height=window.mWINDOW_HEIGHT){
        window.x = (Screen.desktopAvailableWidth-width)/2
        window.y = (Screen.desktopAvailableHeight-height)/2
        window.width = width
        window.height = height
    }
    function setFullScreenVisible(){
        resize.visible = false
        maxWindow.visible = true
    }
    function setSmallScreenVisible(){
        normalWindow.visible = false
        smallWindow.visible = true
    }

    function setPoint(mouseX=0,mouseY=0){
        point = Qt.point(mouseX,mouseY)
    }
    function moveX(mouseX=0){
        var x = window.x + mouseX - point.x
        if(x<-(window.width-70)) x=-(window.width-70)
        if(x>Screen.desktopAvailableWidth-70) x=Screen.Screen.desktopAvailableWidth-70
        window.x = x
    }
    function moveY(mouseY=0){
        var y = window.y + mouseY - point.y
        if(y<0) y=0
        if(y>Screen.desktopAvailableHeight-70) y=Screen.Screen.desktopAvailableHeight-70
        window.y = y
    }
}

