import QtQuick 2.12
import "./common"
import Qt5Compat.GraphicalEffects

Item {

    property Item parentWindow: parent

    id:self

    visible: false
    scale: visible

    width: 180
    height: 180
    anchors.centerIn: parent

    DropShadow{
        anchors.fill: rect
        radius: 8
        horizontalOffset: 1
        verticalOffset: 1
        samples: 16
        color: "#60000000"
        source: rect
    }

    Rectangle{
        id: rect
        color: "#40ffd0d0"
        radius: 5
        anchors.fill: parent

        Image{
            id:image
            source: "qrc:/images/loading"
            width: 50
            height: 50
            anchors.centerIn: parent

            NumberAnimation{
                property: "rotation"
                from: 0
                to: 360
                target: image
                running: self.visible
                loops: Animation.Infinite
                duration: 500
            }
        }

        Text{
            id:content
            text: "Loading..."
            color: "#eeffffff"
            font{
                family: window.mFONT_FAMILY
                pointSize: 11
            }
            anchors{
                top: image.bottom
                topMargin: 10
                horizontalCenter: parent.horizontalCenter
            }
        }
    }

    function open(){
        visible = true
    }

    function close(){
        visible = false
    }
}
