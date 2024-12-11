import QtQuick 2.12
import QtQuick.Layouts
import QtQml

Rectangle {
    id:lyricView

    property alias lyrics:list.model
    property alias current:list.currentIndex

    Layout.preferredHeight: parent.height*0.8
    Layout.alignment: Qt.AlignHCenter
    clip: true

    color: "#00000000"

    ListView{
        id:list
        anchors.fill: parent
        model: ["暂无歌词","暂无歌词","暂无歌词"]
        delegate: listDelegate

        // highlight: Rectangle{
        //     color: "#2073a7ab"
        // }
        highlightMoveDuration: 0
        highlightResizeDuration: 0
        currentIndex: 0
        preferredHighlightBegin: parent.height/2-50
        preferredHighlightEnd: parent.height/2
        highlightRangeMode: ListView.StrictlyEnforceRange
    }

    Component{
        id:listDelegate
        Item{
            id:delegateItem
            width: parent.width
            height: 50
            Text{
                text:modelData
                anchors.centerIn: parent
                color: index===list.currentIndex?"#ffffffff":"#aaffffff"
                font{
                    family: window.mFONT_FAMILY
                    pointSize: 11
                }
                states: State{
                    when:delegateItem.ListView.isCurrentItem
                    PropertyChanges {
                        target: delegateItem
                        scale: 1.2
                    }
                }
                MouseArea{
                    anchors.fill: parent
                    onClicked: list.currentIndex = index
                }
            }
        }
    }
}
