import QtQuick 2.12
import Qt5Compat.GraphicalEffects

Rectangle {
    property bool showDefaultBackground: true

    Image{
        id:backgroundImage
        source: showDefaultBackground?"qrc:/images/player":layoutBottomView.musicCover
        anchors.fill: parent
        fillMode: Image.PreserveAspectCrop
    }
    ColorOverlay{
        id:backgroundImageOverlay
        anchors.fill: backgroundImage
        source: backgroundImage
        color: "#35000000"
    }
    FastBlur{
        anchors.fill: backgroundImageOverlay
        source: backgroundImageOverlay
        radius: 80
    }
}
