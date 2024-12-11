//播放历史
import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.12
import "./common"
import QtQml

ColumnLayout{

    Rectangle{
        Layout.fillWidth: true
        width: parent.width
        height: 40
        color: "#00000000"
        Text{
            x:10
            verticalAlignment: Text.AlignBottom
            text: qsTr("历史播放")
            font.family: window.mFONT_FAMILY
            font.pointSize: 20
            anchors.fill: parent
            color: "#eeffffff"
        }
    }

    RowLayout{
        height: 80

        Item{
            width: 1
        }

        MusicTextButton{
            btnText: "刷新记录"
            btnHeight: 50
            btnWidth: 120
            onClicked: getHistory()
        }
        MusicTextButton{
            btnText: "清空记录"
            btnHeight: 50
            btnWidth: 120
            onClicked: clearHistory()
        }
    }

    Component.onCompleted: {
        getHistory()
    }

    function getHistory(){
        historyListView.musicList = historySettings.lists
    }

    function clearHistory(){
        historySettings.lists = []
        getHistory()
    }

    function deleteHistory(index){
        var list = historySettings.lists
        if(list.length<index+1)return
        list.splice(index,1)
        historySettings.lists = list
        getHistory()
    }

    MusicListView{
        id:historyListView
        onDeleteItem: deleteHistory(index)
    }
}
