import QtQuick 2.12
import QtQuick.Controls 2.5
import Qt5Compat.GraphicalEffects

Rectangle {
    property string imgSrc: "qrc:/images/player"
    property int borderRadius: 5
    property bool isRotating: false
    property real rotationAngel: 0.0

    radius: borderRadius

    gradient: Gradient{
        GradientStop{
            position: 0.0
            color: "#101010"
        }
        GradientStop{
            position: 0.5
            color: "#a0a0a0"
        }
        GradientStop{
            position: 1.0
            color: "#505050"
        }
    }

    // MusicRoundImage{
    //     id:image
    //     imgSrc: imgSrc
    //     width: parent.width*0.9
    //     height: parent.height*0.9
    //     borderRadius:borderRadius
    // }

    Image{
        id:image
        anchors.centerIn: parent
        source: imgSrc
        smooth: true
        width: parent.width*0.9
        height: parent.height*0.9
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
        id:maskImage
        anchors.fill: image
        source: image
        maskSource: mask
        visible: true
        antialiasing: true
    }

    NumberAnimation{
        running: isRotating
        loops: Animation.Infinite
        target: maskImage
        property: "rotation"
        from: rotationAngel
        to:rotationAngel+360
        duration: 20000
        onStopped: {
            rotationAngel = maskImage.rotation
        }
    }

}
