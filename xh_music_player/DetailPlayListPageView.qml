//播放历史
import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.12
import "./common"


ColumnLayout{
    property string targetId:""
    property string targetType:"10"
    property string name:"-"

    onTargetIdChanged: {
        if(targetType=="10")loadAlbum()
        else if (targetType=="1000")loadPlayList()
    }

    Rectangle{
        Layout.fillWidth: true
        width: parent.width
        height: 60
        color: "#00000000"
        Text{
            x:10
            verticalAlignment: Text.AlignBottom
            text: qsTr(targetType=="10"?"专辑":"歌单")+name
            font.family: window.mFONT_FAMILY
            font.pointSize: 25
            color: "#eeffffff"
        }
    }

    RowLayout{
        height: 140
        width: parent.width
        anchors.topMargin: 0

        MusicBorderImage{
            id:playListCover
            width: 120
            height: 120
            Layout.leftMargin: 10
        }
        Item{
            Layout.fillWidth: true
            height: parent.height
            Text{
                id:playListDesc
                width: parent.width *0.95
                anchors.centerIn: parent
                wrapMode: Text.WrapAnywhere
                font.family: window.mFONT_FAMILY
                font.pixelSize: 14
                maximumLineCount: 4
                elide: Text.ElideRight
                lineHeight: 1.5
                color: "#eeffffff"
            }
        }
    }

    MusicListView{
        id:playListListView
        deletable: false
    }

    function loadAlbum(){
        loading.open()
        var url = "album?id="+(targetId.length<1?"32311":targetId)
        function onReply(reply){
            //console.log(reply)
            loading.close()
            http.onReplySignal.disconnect(onReply)

            try{
                if(reply.length<1){
                    notification.openError("获取专辑列表为空!")
                    return
                }
                var album = JSON.parse(reply).album
                var songs = JSON.parse(reply).songs
                playListCover.imgSrc = album.blurPicUrl
                playListDesc.text = album.description
                name = "-"+album.name
                playListListView.musicList = songs.map(item=>{
                                                           return {
                                                               id:item.id,
                                                               name:item.name,
                                                               artist:item.ar[0].name,
                                                               album:item.al.name,
                                                               cover:item.al.picUrl
                                                           }
                                                       })
            }catch(err){
                notification.openError("获取专辑列表出错!")
            }
        }

        http.onReplySignal.connect(onReply)
        http.connet(url)
    }

    function loadPlayList(){
        loading.open()
        var url = "playlist/detail?id="+(targetId.length<1?"32311":targetId)

        function onSongDetailReply(reply){
            loading.close()
            //console.log(reply)
            http.onReplySignal.disconnect(onSongDetailReply)

            try{
                if(reply.length<1){
                    notification.openError("获取歌单列表详情为空!")
                    return
                }
                var songs = JSON.parse(reply).songs
                playListListView.musicList = songs.map(item=>{
                                                           return {
                                                               id:item.id,
                                                               name:item.name,
                                                               artist:item.ar[0].name,
                                                               album:item.al.name,
                                                               cover:item.al.picUrl
                                                           }
                                                       })
            }catch(err){
                notification.openError("获取歌单列表详情出错!")
            }
        }



        function onReply(reply){
            loading.close()
            //console.log(reply)
            http.onReplySignal.disconnect(onReply)
            try{
                if(reply.length<1){
                    notification.openError("获取歌单列表为空!")
                    return
                }
                var playlist = JSON.parse(reply).playlist
                playListCover.imgSrc = playlist.coverImgUrl
                playListDesc.text = playlist.description
                name = "-"+playlist.name

                var ids = playlist.trackIds.map(item=>item.id).join(",")

                http.onReplySignal.connect(onSongDetailReply)
                http.connet("song/detail?ids="+ids)
                loading.open()
            }catch(err){
                notification.openError("获取歌单列表出错!")
            }
        }
        http.onReplySignal.connect(onReply)
        http.connet(url)
    }





}


