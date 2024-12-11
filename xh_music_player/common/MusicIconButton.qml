import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Layouts

Button{
    property string iconSource: ""
    property string toolTip: ""
    property int iconWidth: 32
    property int iconHeight: 32
    property bool isCheckable: false
    property bool isChecked: false

    id:self
    icon.source: iconSource
    icon.width: iconWidth
    icon.height: iconHeight

    ToolTip.visible: hovered
    ToolTip.text: toolTip
    // MusicToolTip{
    //     visible: parent.hovered
    //     text: parent.toolTip
    // }

    background: Rectangle{
        color: self.down||(isCheckable&&self.checked)?"#497563":"#20e9f4ff"
        radius: 3
    }
    icon.color: self.down||(isCheckable&&self.checked)?"#ff0000":"#e2f0f8"

    checkable: isCheckable
    checked: isChecked
}
