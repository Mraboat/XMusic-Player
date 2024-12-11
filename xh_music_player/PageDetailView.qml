import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Layouts
import QtQml
import "./common"

Item {

    property alias lyrics : lyricView.lyrics
    property alias current: lyricView.current

    Layout.fillHeight: true
    Layout.fillWidth: true

    RowLayout{
        anchors.fill: parent
        spacing: 0
        Frame{
            Layout.preferredWidth: parent.width*0.45
            Layout.fillHeight: true
            Layout.fillWidth: true

            background: Rectangle{
                color: "#00000000"
            }

            Text{
                id:name
                text: layoutBottomView.musicName
                anchors{
                    bottom: artist.top
                    bottomMargin: 20
                    horizontalCenter: parent.horizontalCenter
                }
                font{
                    family: window.mFONT_FAMILY
                    pointSize: 16
                }
                color: "#eeffffff"
            }

            Text{
                id:artist
                text: layoutBottomView.musicArtist
                anchors{
                    bottom: cover.top
                    bottomMargin: 20
                    topMargin: 20
                    horizontalCenter: parent.horizontalCenter
                }
                font{
                    family: window.mFONT_FAMILY
                    pointSize: 12
                }
                color: "#aaffffff"
            }

            MusicBorderImage{
                id:cover
                anchors.centerIn: parent
                width: parent.width*0.6
                height: width
                borderRadius: width
                imgSrc: layoutBottomView.musicCover
                isRotating: layoutBottomView.playingState===1
            }

            Text{
                id:lyric
                visible: !layoutHeaderView.isSmallWindow
                text: lyricView.lyrics[lyricView.current]?lyricView.lyrics[lyricView.current]:"暂无歌词"
                anchors{
                    top: cover.bottom
                    topMargin: 50
                    horizontalCenter: parent.horizontalCenter
                }
                font{
                    family: window.mFONT_FAMILY
                    pointSize: 12
                }
                color: "#aaffffff"
            }

            MouseArea{
                id:mouseArea
                anchors.fill: parent
                hoverEnabled: true
                onEntered: displayHeaderAndBottom(false)
                onExited: displayHeaderAndBottom(true)
                onMouseXChanged: {
                    timer.stop()
                    cursorShape = Qt.ArrowCursor
                    timer.start()
                }
                onClicked: {
                    displayHeaderAndBottom(true)
                    timer.stop()
                }
            }
        }

        Frame{
            visible: !layoutHeaderView.isSmallWindow
            Layout.preferredWidth: parent.width*0.55
            Layout.fillHeight: true
            background: Rectangle{
                color: "#00e03456"
            }

            MusicLyricView{
                id:lyricView
                anchors.fill: parent
            }
        }
    }

    Timer{
        id:timer
        interval: 3000
        onTriggered: {
            displayHeaderAndBottom(false)
            mouseArea.cursorShape = Qt.BlankCursor
        }
    }

    function displayHeaderAndBottom(visible = true){
        layoutHeaderView.visible = pageHomeView.visible||visible
        layoutBottomView.visible = pageHomeView.visible||visible
    }
}
