import QtQuick 2.0
import Ubuntu.Components 1.1
import Ubuntu.Components.Popups 0.1
import "../backend/script.js" as Logic

Item{
    height:parent.height
    width:parent.width

    Rectangle {
        id: label
        z:1
        radius: units.gu(2)
        color: "#ffffff"
        width: units.gu(17)
        height: units.gu(17)
        anchors{
            top:parent.top; topMargin: units.gu(4)
            horizontalCenter: parent.horizontalCenter
        }
        border.width:units.gu(.2)
        border.color: "#e0e6ed"

        Column {
            id:topsquare;
            spacing: units.gu(1);
                anchors.centerIn: parent;
            Label {
                //percentage text
                font.pixelSize: label.height*0.36
                text: Logic.percentage(userProgress.contents.current,userProgress.contents.needed) + "%"
                anchors.horizontalCenter: parent.horizontalCenter
            }
            Label {
                //progress infomation text
                fontSize:"small"
                anchors.horizontalCenter: parent.horizontalCenter
                text:Logic.text(userProgress.contents.current,userProgress.contents.needed, userSettings.contents.metrics)
            }

        }//end of column

    }//end of ubuntu shape

    Rectangle {
        id:label2
        z:1
        width: units.gu(15)
        height: units.gu(15)
        color: "#ffffff"
        radius: units.gu(2)
            anchors{
                bottom:parent.bottom; bottomMargin: units.gu(4);
                horizontalCenter: parent.horizontalCenter
            }
            border.width:units.gu(.2)
            border.color: "#e0e6ed"
            Column{
                spacing: units.gu(1)
                    anchors{
                        centerIn: parent
                        margins: units.gu(1)
                    }
                Image {
                    //water drop image
                    smooth: true
                    width: units.gu(10)
                    height: width
                    anchors.horizontalCenter: parent.horizontalCenter
                    source: Qt.resolvedUrl("../graphics/slimdrop.svg")
                }
               Label {
                    // add water text
                    fontSize:"small"
                    text:i18n.tr("Add Water")
                    anchors.horizontalCenter: parent.horizontalCenter
              }
          }// end of column
            MouseArea {
                id: mousearea
                anchors.fill:parent
                onClicked: PopupUtils.open((buttons))
            }
    }//end of ubuntushape


}//end of item
