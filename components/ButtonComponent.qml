import QtQuick 2.0
import Ubuntu.Components 1.1
import Ubuntu.Components.Popups 0.1
import "../components/"

//add water button square with water icon
Item{
    height:parent.height - units.gu(2)
    width:parent.width

UbuntuShape {
    id: label
    objectName: "label"
    radius: "medium"
    opacity: .80
    color: "#ededed"
    width: units.gu(19)
    height: units.gu(19)

    anchors{top:parent.top; topMargin: units.gu(2);horizontalCenter: parent.horizontalCenter}

    Column {
            id:topsquare
            anchors{
                fill:parent; margins: units.gu(2)
                horizontalCenter: parent.horizontalCenter; verticalCenter: parent.verticalCenter
                    }
            spacing: 20

  Label {
        id:percentInfo
        font.pixelSize: label.height*0.4
        font.weight: Font.Light; //focus: true;
        //color: Theme.palette.normal.baseText
        text: oz.current + "%"
        anchors{
            horizontalCenter: parent.horizontalCenter
                }
    }

Item{
    id:recHold
    width:parent.width
    height:progressInfo.height + waterLabel.height

    Column{
        spacing: 5
        width:parent.width
        height:progressInfo.height + waterLabel.height
  Label {
      id:progressInfo
      fontSize:"medium"
      //color: Theme.palette.normal.baseText
      anchors{
          horizontalCenter: parent.horizontalCenter
              }
      text: if( goal.contents.check === true && number_doc.contents.metric === true){ (liter.water + oz.text +" / " + goalNum.contents.amount + " L")}
                           else if(goal.contents.check === true && number_doc.contents.metric === false){text: (water_doc.contents.water + oz.text +" / " + goalNum.contents.amount + oz.text)}
                               else if (goal.contents.check === false && number_doc.contents.metric === true){ (liter.water + oz.text +" / " + Math.round((weight_doc.contents.weight/2)/33.8*10)/10 + " L")}
                                   else if (goal.contents.check === false && number_doc.contents.metric === false) {water_doc.contents.water + oz.text + " / " + oz.needed + oz.text}
                                        else {"I am error \nRedo user settings to fix"}
  }

  Label {
      id:waterLabel
      fontSize:"small"
      font.weight: Font.Bold;
      //color: Theme.palette.normal.baseText
      anchors{
          horizontalCenter: parent.horizontalCenter
              }
      text:"today"
  }
    }
}
}//end of column

}//end of ubuntu shape

UbuntuShape {
    id: addwater
    width: units.gu(15)
    height: units.gu(15)
    color: "#ededed"
    opacity: .80
    radius: "medium"
    anchors{bottom:parent.bottom; bottomMargin: units.gu(2);horizontalCenter: parent.horizontalCenter}

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
            onClicked: PopupUtils.open((dialogComponent))
}
}
}//end of item
