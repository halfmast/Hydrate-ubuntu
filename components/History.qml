import QtQuick 2.0
import Ubuntu.Components 1.1
import U1db 1.0 as U1db
import Ubuntu.Components.ListItems 0.1 as ListItem
import "../backend/script.js" as Logic


    Item{
        width:parent.height
        height:parent.height
        Column {
            id:col
            spacing: units.gu(1)
            clip:true
            anchors {
                margins: units.gu(2)
                fill: parent
            }
            ListItem.Standard{
                visible: greenButton.visible === true? true:false;
                Label{
                    text:"History"
                    anchors.centerIn: parent;
                }
            }
            UbuntuListView {
                    id: accountListView
                    anchors.margins: units.gu(2)
                    width:parent.width
                    height:units.gu(80)
                    currentIndex: -1;
                    clip:true
                    model: playerInfo.contents.players.reverse()
                    delegate:
                    ListItem.SingleValue {
                        width:parent.width
                            text: modelData.count
                            value: modelData.progress
                    }
           }
        }
}


