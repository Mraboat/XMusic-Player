//我喜欢的
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
            text: qsTr("我喜欢的")
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
            onClicked: getFavorite()
        }
        MusicTextButton{
            btnText: "清空记录"
            btnHeight: 50
            btnWidth: 120
            onClicked: clearFavorite()
        }
    }

    Component.onCompleted: {
        getFavorite()
    }

    function getFavorite(){
        favoriteListView.musicList = favoriteSettings.lists
    }

    function clearFavorite(){
        favoriteSettings.lists = []
        getFavorite()
    }

    function deleteFavorite(index){
        var list = favoriteSettings.lists
        if(list.length<index+1)return
        list.splice(index,1)
        favoriteSettings.lists = list
        getFavorite()
    }

    MusicListView{
        id:favoriteListView
        favoritable: false
        onDeleteItem: deleteFavorite(index)
    }
}
