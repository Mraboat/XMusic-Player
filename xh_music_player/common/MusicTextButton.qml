import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Layouts

Button{
    property alias btnText: name.text

    property alias btnWidth: self.width
    property alias btnHeight: self.height
    property alias isCheckable: self.checkable
    property alias isChecked: self.checked

    id:self

    Text{
        id:name
        text: "Button"
        color: self.down||(self.checkable&&self.checked)?"#ee000000":"#eeffffff"
        font.family: window.mFONT_FAMILY
        font.pointSize: 12
        anchors.centerIn: parent
    }

    width: 50
    height: 50  

    background: Rectangle{
        implicitHeight: self.height
        implicitWidth: self.width
        color: self.down||(self.checkable&&self.checked)?"#e2f0f8":"#20e9f4ff"
        radius: 3
    }

    checkable: false
    checked: false
}
