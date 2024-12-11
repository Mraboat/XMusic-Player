import QtQuick 2.12
import QtQuick.Controls 2.5
import "./common"

Item {
    property alias list: gridRepeater.model

    Grid{
        id:gridLayout
        anchors.fill: parent
        columns: 5
        Repeater{
            id:gridRepeater
            Frame{
                leftPadding: 4
                rightPadding: 4
                topPadding: 4
                bottomPadding: 4
                bottomInset: 10
                width: parent.width*0.2
                height: parent.width*0.2+30
                clip: true
                background: Rectangle{
                    id:background
                    color: "#00000000"
                }

                MusicBorderImage{
                    id:img
                    width: parent.width
                    height: parent.width
                    imgSrc: modelData.coverImgUrl
                }
                Text{
                    height: 30
                    width: parent.width
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignHCenter
                    anchors{
                        top: img.bottom
                        horizontalCenter: parent.horizontalCenter
                    }
                    text: modelData.name
                    font{
                        family: window.mFONT_FAMILY
                        //pointSize: 12
                    }
                    elide: Qt.ElideMiddle
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
                        var item = gridRepeater.model[index]
                        pageHomeView.showPlayList(item.id,1000)
                    }
                }
            }
        }
    }

}