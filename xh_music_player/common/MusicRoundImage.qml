import QtQuick 2.12
import QtQuick.Controls 2.5
import Qt5Compat.GraphicalEffects

Item {
    property string imgSrc: "qrc:/images/player"
    property int borderRadius: 5

    Image{
        id:image
        anchors.centerIn: parent
        source: imgSrc
        smooth: true
        width: parent.width
        height: parent.height
        fillMode: Image.PreserveAspectCrop
        antialiasing: true
        visible: false
    }

    Rectangle{
        id:mask
        anchors.fill: parent
        color: "black"
        radius: borderRadius
        visible: false
        smooth: true
        antialiasing: true
    }

    OpacityMask{
        anchors.fill: image
        source: image
        maskSource: mask
        visible: true
        antialiasing: true
    }

}
