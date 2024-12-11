import QtQuick 2.12
import QtQuick.Controls 2.5
import "./common"

Item {
    property alias list: gridRepeater.model

    Grid{
        id:gridLayout
        anchors.fill: parent
        columns: 3
        Repeater{
            id:gridRepeater
            Frame{
                leftPadding: 1
                rightPadding: 1
                topPadding: 1
                bottomPadding: 1
                bottomInset: 10
                width: parent.width*0.33
                height: parent.width*0.1
                clip: true
                background: Rectangle{
                    id:background
                    color: "#00000000"
                }

                MusicBorderImage{
                    id:img
                    width: parent.width*0.25
                    height: parent.width*0.25
                    imgSrc: modelData.album.picUrl
                }
                Text{
                    id:name
                    //height: 30
                    width: parent.width*0.72
                    anchors{
                        left: img.right
                        // bottomMargin: 10
                        leftMargin: 5
                        verticalCenter: parent.verticalCenter
                        verticalCenterOffset: -10
                    }
                    text: modelData.album.name
                    font{
                        family: window.mFONT_FAMILY
                        pointSize: 11
                    }
                    elide: Qt.ElideRight
                    color: "#eeffffff"
                }
                Text{
                    height: 30
                    width: parent.width*0.72
                    anchors{
                        topMargin: 0
                        left: img.right
                        top: name.bottom
                        leftMargin: 5
                    }
                    text: modelData.artists[0].name
                    font{
                        family: window.mFONT_FAMILY
                        //pointSize: 12
                    }
                    elide: Qt.ElideRight
                    color: "#eeffffff"
                }
                MouseArea{
                    anchors.fill: parent
                    hoverEnabled: true
                    cursorShape: Qt.PointingHandCursor
                    onEntered: {
                        background.color = "#50ffffff"
                    }
                    onExited: {
                        background.color = "#00000000"
                    }
                    onClicked: {
                        layoutBottomView.current = -1
                        layoutBottomView.playList = [{
                                                         id:list[index].id,
                                                         name:list[index].name,
                                                         artist:list[index].artists[0].name,
                                                         album:list[index].album.name,
                                                         cover:list[index].album.picUrl,
                                                         type:"0"
                                                     }]
                        layoutBottomView.current = 0
                    }
                }
            }
        }
    }

}