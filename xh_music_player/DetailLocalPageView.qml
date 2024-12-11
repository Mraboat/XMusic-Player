//本地音乐
import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Layouts
import "./common"
import Qt.labs.platform
import Qt.labs.settings
import QtQml

ColumnLayout{

    Settings{
        id:localSettings
        fileName: "conf/local.ini"
        property var lists:[]
    }

    Rectangle{
        Layout.fillWidth: true
        width: parent.width
        height: 40
        color: "#00000000"
        Text{
            x:10
            verticalAlignment: Text.AlignBottom
            text: qsTr("本地音乐")
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
            btnText: "添加本地音乐"
            btnHeight: 50
            btnWidth: 200
            onClicked: fileDialog.open()
        }
        MusicTextButton{
            btnText: "刷新记录"
            btnHeight: 50
            btnWidth: 120
            onClicked: getLocal()
        }
        MusicTextButton{
            btnText: "清空记录"
            btnHeight: 50
            btnWidth: 120
            onClicked: saveLocal()
        }
    }

    Component.onCompleted: {
        getLocal()
    }

    function getLocal(){
        //var list = localSettings.value("local",[])
        var list = localSettings.lists
        //console.log(typeof(list),list)
        localListView.musicList = list
        return list
    }

    function saveLocal(list=[]){
        //localSettings.setValue("local",list)
        localSettings.lists = list
        getLocal()
    }

    function deleteLocal(index){
        var list = localSettings.lists
        if(list.length<index+1)return
        list.splice(index,1)
        saveLocal(list)
    }

    MusicListView{
        id:localListView
        onDeleteItem: deleteLocal(index)
    }

    FileDialog{
        id:fileDialog
        fileMode: FileDialog.OpenFiles
        nameFilters: ["MP3 Music Files(*.mp3)","FLAC Music Files(*.flac)"]
        folder: StandardPaths.standardLocations(StandardPaths.MusicLocation)[0]
        acceptLabel: "确定"
        rejectLabel: "取消"
        onAccepted: {
            var list = getLocal()

            for(var index in files){
                var path =  files[index]+""

                var arr = path.split("/")
                var fileNameArr = arr[arr.length-1].split(".")
                //去掉后缀
                fileNameArr.pop()
                var fileName = fileNameArr.join(".")
                //歌手-名称.mp3
                var nameArr = fileName.split("-")
                var name = "妮妮"
                var artist = "妮妮"
                if(nameArr.length>1){
                    artist = nameArr[0]
                    nameArr.shift()
                }
                name = nameArr.join("-")

                if(list.filter(item=>item.id===path).length<1){
                    list.push({
                                  id:path+"",
                                  name,artist,
                                  url:path+"",
                                  album:"本地音乐",
                                  type:"1"//1表示本地音乐，0表示网络
                              })
                }
                saveLocal(list)
            }
        }
    }
}
