import QtQuick 2.0
import Ubuntu.Components 1.1
import Ubuntu.Components.Popups 0.1
import Ubuntu.Components.ListItems 1.0 as ListItem
import "../backend/script.js" as Logic

Page {
    title: "Settings"
    id: settings
    visible: false
    Item{
        id:place
        property int holder: 0;
             }
    head.actions: Action {
        iconName: "ok"
        onTriggered: {
            place.holder = userProgress.contents.weight
            userSettings.contents = {metrics: unitOption.selectedIndex, goals: goalOption.selectedIndex}
            userProgress.contents = {level:0,current: 0, weight: Logic.save(weightText.text, place.holder),needed: Logic.waterNeeded(weightText.text, userSettings.contents.goals, userSettings.contents.metrics),mL:0}
            weightText.placeholderText = Logic.lorem(unitOption.selectedIndex, goalOption.selectedIndex, userProgress.contents.weight)
            stack.pop(home);
        }
    }
    head.backAction: Action {
            iconName: "close"
            onTriggered: stack.pop(home);
        }

    Item {
        width:parent.width
        height:parent.height - units.gu(2)
        anchors.centerIn: parent
        clip:true
        Flickable{
            width:parent.width
            height:parent.height
            contentHeight: col.height
            contentWidth: parent.width
            Column{
                id:col
                width: parent.width
                anchors.centerIn: parent

                ListItem.SingleValue{
                    id:firstInput
                    height:unitOption.height + units.gu(8)
                    width:parent.width
                    showDivider: false
                    Column{
                    anchors.fill:parent
                    spacing: units.gu(2)

                        Label {
                            id:userText
                            text: "Units of measurement"
                        }
                        OptionSelector {
                            id:unitOption
                            selectedIndex:userSettings.contents.metrics
                            model: [i18n.tr("Imperial"),i18n.tr("Metrics")]
                            onSelectedIndexChanged: {
                                weightText.placeholderText = Logic.placeLorem(unitOption.selectedIndex, goalOption.selectedIndex)
                            }
                        }
                    }
                }
                    ListItem.SingleValue{
                        id:secondInput
                        height:calText.height + goalOption.height + weightText.height + units.gu(8)
                        width:parent.width

                        Column{
                            id:secCol
                            anchors.fill:parent
                            spacing: units.gu(2)

                            Label {
                                id:calText
                                text: "unit index " + unitOption.selectedIndex + "goal " + goalOption.selectedIndex//"Set water goal by"
                            }
                             OptionSelector {
                                    id:goalOption
                                    selectedIndex: userSettings.contents.goals
                                    model: [i18n.tr("Use Weight"),i18n.tr("Set Goal")]
                                    onSelectedIndexChanged:{
                                        weightText.placeholderText = Logic.placeLorem(unitOption.selectedIndex, goalOption.selectedIndex)
                                        //console.log("goal: " + goalOption.selectedIndex)
                                    }
                             }
                            TextField {
                                id: weightText
                                width:unitOption.width
                                placeholderText:  Logic.lorem(unitOption.selectedIndex, goalOption.selectedIndex, userProgress.contents.weight)
                                inputMethodHints: Qt.ImhDialableCharactersOnly
                            }
                        }
                    }
                    ListItem.Standard {
                        text: "Reset current progress"
                        onClicked: (PopupUtils.open(dialogReset))
                        progression: true
                    }
                    ResetComponent{
                        id:dialogReset
                    }
            }//end of column
        }// end of Flickable
    }
}




