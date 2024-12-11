import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Layouts
import MyUtils 1.0
import QtMultimedia
import Qt.labs.settings

ApplicationWindow {
    id: window
    property int mWINDOW_WIDTH: 900
    property int mWINDOW_HEIGHT: 600

    property string mFONT_FAMILY: "微软雅黑"
    width: mWINDOW_WIDTH
    height: mWINDOW_HEIGHT
    visible: true
    title: qsTr("XMusic Player")

    flags: Qt.Window|Qt.FramelessWindowHint

    background: Background{
        id:appBackground
    }

    AppSystemTrayIcon{

    }

    HttpUtils{
        id:http
    }

    Settings{
        id:settings
        fileName: "conf/settings.ini"
    }

    Settings{
        id:historySettings
        fileName: "conf/history.ini"
        property var lists:[]
    }

    Settings{
        id:favoriteSettings
        fileName: "conf/favorite.ini"
        property var lists:[]
    }

    ColumnLayout{
        anchors.fill: parent
        spacing: 0
        LayoutHeaderView{
            id:layoutHeaderView
            z:3
        }
        PageHomeView{
            id:pageHomeView
        }
        PageDetailView{
            id:pageDetailView
            visible: false
        }
        LayoutBottomView{
            id:layoutBottomView
        }
    }

    MusicNotification{
        id:notification
    }

    MusicLoading{
        id:loading
    }

    MediaPlayer{
        id:mediaPlayer
        audioOutput: AudioOutput{}

        property var times:[]

        onPositionChanged: {
            layoutBottomView.setSlider(0,duration,position)

            if(times.length>0){
                var count = times.filter(time=>time<position).length
                pageDetailView.current = (count===0)?0:count-1
                // for(var i = 0; i < times.length ; i++ ){
                //     if(position>=times[i]){
                //         pageDetailView.current = i
                //     }else{
                //         break
                //     }
                // }
            }
        }

        onPlaybackStateChanged: {
            layoutBottomView.playingState = playbackState===MediaPlayer.PlayingState?1:0

            if(playbackState == MediaPlayer.StoppedState && layoutBottomView.playbackStateChangeCallbackEnabled){
                layoutBottomView.playNext()
            }

        }
    }

}
