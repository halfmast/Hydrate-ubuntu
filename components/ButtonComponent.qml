import QtQuick 2.0
import Ubuntu.Components 1.1
import Ubuntu.Components.Popups 0.1
import "../backend/script.js" as Logic

Item{
    height:parent.height - units.gu(2)
    width:parent.width

    UbuntuShape {
    id: label
    objectName: "label"
    radius: "medium"
    opacity: .8
    color: "#efefef"
    width: units.gu(19)
    height: units.gu(19)

    anchors{
        top:parent.top; topMargin: units.gu(2);
        horizontalCenter: parent.horizontalCenter
    }

    Column {
            id:topsquare
            anchors{
                centerIn: parent;
            }
            spacing: units.gu(1.5)

        Label {
            id:percentInfo
            font.pixelSize: label.height*0.4
            font.weight: Font.Light;
            text: Logic.percentage(userProgress.contents.current,userProgress.contents.needed) + "%"
            anchors{
                horizontalCenter: parent.horizontalCenter
            }
        }

        Item{
        id:recHold
        width:parent.width
        height:progressInfo.height + waterLabel.height

            Column{
                spacing: units.gu(1)
                width:parent.width
                height:progressInfo.height + waterLabel.height
                Label {
                  id:progressInfo
                  fontSize:"medium"
                  anchors{
                      horizontalCenter: parent.horizontalCenter
                  }
                  text:Logic.text(userProgress.contents.current,userProgress.contents.needed, userSettings.contents.metrics)
                }

                Label {
                  id:waterLabel
                  fontSize:"small"
                  font.weight: Font.Bold;
                  anchors{
                      horizontalCenter: parent.horizontalCenter
                  }
                  text:"today";
                }
            }
        }
    }//end of column

    }//end of ubuntu shape

    UbuntuShape {
        id: addwater
        width: units.gu(15)
        height: units.gu(15)
        color: "#efefef"
        opacity: .8
        radius: "medium"
        anchors{
            bottom:parent.bottom; bottomMargin: units.gu(2);
            horizontalCenter: parent.horizontalCenter
        }

            Image {
                smooth: true
                width: units.gu(10)
                height: units.gu(10)
                anchors{
                top: mousearea1.top; topMargin:units.gu(1)
                horizontalCenter: mousearea1.horizontalCenter}
                source: Qt.resolvedUrl("../graphics/slimdrop.svg")
                  }

           Label {
                id:glassLabel
                fontSize:"small"
                font.weight: Font.Bold;
                text:i18n.tr("Add Water")
                anchors{
                horizontalCenter: parent.horizontalCenter
                bottom: parent.bottom; bottomMargin: units.gu(1)}
           }

            MouseArea {
                id: mousearea1
                anchors.fill:parent
                onClicked: PopupUtils.open((buttons))
            }
    }//end of ubuntushape
}//end of item
