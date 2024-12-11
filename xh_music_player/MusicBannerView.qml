import QtQuick 2.12
import QtQuick.Controls 2.5
import "./common"

Frame {
    property int current: 0
    property alias bannerList: bannerView.model

        background: Rectangle{
            color: "#00000000"
        }

    PathView{
        id:bannerView
        width: parent.width
        height: parent.height
        clip: true

        // onCurrentIndexChanged:{
        //     PropertyAnimation{

        //         // duration: 1000
        //     }
        // }
        MouseArea{
            anchors.fill: parent
            hoverEnabled: true
            onEntered: {
                bannerTimer.stop()
            }
            onExited: {
                bannerTimer.start()
            }
        }

        delegate: Item {
            id:delegateItem
            width: bannerView.width*0.7
            height: bannerView.height
            z:PathView.z?PathView.z:1.0
            scale: PathView.scale?PathView.scale:1.0
            MusicRoundImage{
                id:image
                imgSrc: modelData.imageUrl
                width: delegateItem.width
                height: delegateItem.height
            }
            MouseArea{
                anchors.fill: parent
                cursorShape: Qt.PointingHandCursor
                onClicked: {
                    if(bannerView.currentIndex===index){
                        var item = bannerView.model[index]
                        var targetId = item.targetId+""
                        var targetType = item.targetType+""//1:单曲  10:专辑  1000:歌单
                        switch(targetType){
                        case "1":
                            //播放歌曲
                            layoutBottomView.current = -1
                            layoutBottomView.playList=[{id:targetId,name:"",artist:"",cover:"",album:""}]
                            layoutBottomView.current = 0
                            break
                        case "10":
                            //打开专辑
                        case "1000":
                            //打开播放列表
                            pageHomeView.showPlayList(targetId,targetType)
                            break
                        }
                        console.log(targetId,targetType)
                    }else{
                        bannerView.currentIndex = index
                    }
                }
            }
        }

        pathItemCount: 3
        path: bannerPath
        preferredHighlightBegin: 0.5
        preferredHighlightEnd: 0.5
    }

    Path{
        id:bannerPath
        startX: 0
        startY: bannerView.height/2-10
        PathAttribute{name: "z";value: 0}
        PathAttribute{name: "scale";value: 0.6}

        PathLine{
            x:bannerView.width/2
            y:bannerView.height/2-10
        }

        PathAttribute{name: "z";value: 2}
        PathAttribute{name: "scale";value: 0.85}

        PathLine{
            x:bannerView.width
            y:bannerView.height/2-10
        }

        PathAttribute{name: "z";value: 0}
        PathAttribute{name: "scale";value: 0.6}
    }

    PageIndicator{
        id:indicator
        anchors{
            top: bannerView.bottom
            horizontalCenter: parent.horizontalCenter
            topMargin: -10
        }
        count: bannerView.count
        currentIndex: bannerView.currentIndex
        spacing: 10
        delegate: Rectangle{
            width: 20
            height: 5
            radius: 5
            color: index==bannerView.currentIndex?"white":"#55ffffff"
            Behavior on color {
                ColorAnimation{
                    duration: 400
                }
            }
            MouseArea{
                anchors.fill: parent
                hoverEnabled: true
                onEntered: {
                    bannerView.currentIndex = index
                    bannerTimer.stop()
                }
                onExited: {
                    bannerTimer.start()
                }
                cursorShape: Qt.PointingHandCursor
            }
        }
    }
    Timer{
        id:bannerTimer
        interval: 3000
        running: true
        repeat: true
        onTriggered: {
            if(bannerView.count>0)
                bannerView.currentIndex = (bannerView.currentIndex+1)%bannerView.count
        }
    }


















    //第一种实现方式
    // MouseArea{
    //     anchors.fill: parent
    //     //cursorShape: Qt.PointingHandCursor
    //     hoverEnabled: true
    //     onEntered: {
    //         bannerTimer.stop()
    //     }
    //     onExited: {
    //         bannerTimer.start()
    //     }
    // }

    // MusicRoundImage{
    //     id:leftImage
    //     width: parent.width*0.6
    //     height: parent.height*0.8
    //     anchors{
    //         left: parent.left
    //         bottom: parent.bottom
    //         bottomMargin: 20
    //         //leftMargin: 20
    //     }
    //     imgSrc: getLeftImgSrc()
    //     MouseArea{
    //         anchors.fill: parent
    //         cursorShape: Qt.PointingHandCursor
    //         onClicked: {
    //             if(bannerList.length>0)
    //                 current = current==0?bannerList.length-1:current-1
    //         }
    //     }
    //     NumberAnimation{
    //         id:leftImageAnim
    //         target: leftImage
    //         property: "scale"
    //         from: 0.8
    //         to: 1
    //         duration: 500
    //     }
    //     onImgSrcChanged: {
    //         leftImageAnim.start()
    //     }
    // }
    // MusicRoundImage{
    //     id:centerImage
    //     width: parent.width*0.6
    //     height: parent.height
    //     anchors.centerIn: parent
    //     z:2
    //     imgSrc: getCenterImgSrc()
    //     MouseArea{
    //         anchors.fill: parent
    //         cursorShape: Qt.PointingHandCursor
    //     }
    //     NumberAnimation{
    //         id:centerImageAnim
    //         target: centerImage
    //         property: "scale"
    //         from: 0.8
    //         to: 1
    //         duration: 500
    //     }
    //     onImgSrcChanged: {
    //         centerImageAnim.start()
    //     }
    // }
    // MusicRoundImage{
    //     id:rightImage
    //     width: parent.width*0.6
    //     height: parent.height*0.8
    //     anchors{
    //         right: parent.right
    //         bottom: parent.bottom
    //         bottomMargin: 20
    //         //rightMargin: -10
    //     }
    //     imgSrc: getRightImgSrc()
    //     MouseArea{
    //         anchors.fill: parent
    //         cursorShape: Qt.PointingHandCursor
    //         onClicked: {
    //             if(bannerList.length>0)
    //                 current = current==bannerList.length-1?0:current+1
    //         }
    //     }
    //     NumberAnimation{
    //         id:rightImageAnim
    //         target: rightImage
    //         property: "scale"
    //         from: 0.8
    //         to: 1
    //         duration: 500
    //     }
    //     onImgSrcChanged: {
    //         rightImageAnim.start()
    //     }
    // }

    // PageIndicator{
    //     anchors{
    //         top: centerImage.bottom
    //         horizontalCenter: parent.horizontalCenter
    //     }
    //     count: bannerList.length
    //     interactive: true
    //     onCurrentIndexChanged:{
    //         current = currentIndex
    //     }

    //     delegate: Rectangle{
    //         width: 20
    //         height: 5
    //         radius: 5
    //         color: current == index ? "black" : "grey"
    //         MouseArea{
    //             anchors.fill: parent
    //             cursorShape: Qt.PointingHandCursor
    //             hoverEnabled: true
    //             onEntered: {
    //                 bannerTimer.stop()
    //                 current = index
    //             }
    //             onExited: {
    //                 bannerTimer.start()
    //             }
    //         }
    //     }


    // }

    // Timer{
    //     id:bannerTimer
    //     interval: 5000
    //     repeat: true
    //     onTriggered: {
    //         if(bannerList.length>0)
    //             current = current==bannerList.length-1?0:current+1
    //     }
    //     running: true
    // }

    // function getLeftImgSrc(){
    //     return bannerList.length?bannerList[(current-1+bannerList.length)%bannerList.length].imageUrl:""
    // }
    // function getCenterImgSrc(){
    //     return bannerList.length?bannerList[current].imageUrl:""
    // }
    // function getRightImgSrc(){
    //     return bannerList.length?bannerList[(current+1+bannerList.length)%bannerList.length].imageUrl:""
    // }
}