import QtQuick 2.0
import Ubuntu.Components 1.1
import Ubuntu.Components.Popups 0.1
import "../components/"
import Ubuntu.Components.ListItems 1.0 as ListItem

Page {
    title: "Settings"
    id: page1
    //visible: false
    tools: ToolbarItems {

        // define the action:
        ToolbarButton {
            action:
                Action {
                text: "Save"
                iconSource: Qt.resolvedUrl("../graphics/save.svg")
                iconName: "save"
                onTriggered:
                {
                    if (goal.contents.check === false){
                        if (weight.text === ""){}else {
                            weight_doc.contents = {weight: weight.text}
                                number_doc.contents = {metric: unitOption.selectedIndex}
                        }
                        }else if(goal.contents.check === true){
                            if (weight.text === ""){}else {
                                goalNum.contents = {amount: weight.text}
                                number_doc.contents = {metric: unitOption.selectedIndex}
                                }
                                }
                                    update.place()
                                    text_doc.contents = {words:update.text}
                                    weight.text = ""
                                    water_doc.contents = {water: 0}
                                    liter_doc.contents = {liter: 0}
                                    oz.current = 0
                                    waterlvl.height = 0
                                    start.startupFunction();
                                    pageStack.pop()
                }
            }
        }
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
        spacing:units.gu(0)
        width: parent.width
        anchors.centerIn: parent
        Item{id:update;
            property var text: "";
            property string unit: "";
            //updates placeholder text when changing settings
            function all(){
                if( goal.contents.check === true && number_doc.contents.metric === true){ update.text = "Enter goal in liters"}
                else if( goal.contents.check === true && number_doc.contents.metric === false){update.text = "Enter goal in ounces"}
                    else if ( goal.contents.check === false && number_doc.contents.metric === true){ update.text = "Enter weight in kilograms"}
                        else if (goal.contents.check === false && number_doc.contents.metric === false) { update.text = "Enter weight in pounds"}
                            else {update.text = "I am error \nRedo your users settings to fix"}}
            //save text to replace placeholder text with.
            function place(){
                if( goal.contents.check === true && number_doc.contents.metric === true){ update.text = goalNum.contents.amount + " liters"}
                else if( goal.contents.check === true && number_doc.contents.metric === false){update.text = goalNum.contents.amount + " ounces"}
                    else if ( goal.contents.check === false && number_doc.contents.metric === true){ update.text = (weight_doc.contents.weight + " kilograms")}
                        else if (goal.contents.check === false && number_doc.contents.metric === false) { update.text = (weight_doc.contents.weight + " pounds")}
                            else {update.text = "I am error \nRedo your user settings to fix"}}
        }



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

            selectedIndex:number_doc.contents.metric
           Item{id:unitSelect
               property var selected: unitOption.selectedIndex;
               property var t: if (number_doc.contents.metric === true) {
                                   Math.round(liter.weight)
                                   }
                               else {
                                   weight_doc.contents.weight
                                                          }
               function n(){ if (unitOption.selectedIndex === 1){
                                   number_doc.contents = {metric: true}}
                               else{number_doc.contents = {metric: false}}}
                }
               model: [i18n.tr("Imperial"),i18n.tr("Metrics")]

               onSelectedIndexChanged: {unitSelect.n()
                   update.all()
                                        }


        }
            }
        }
            ListItem.SingleValue{
                id:secondInput
                height:calText.height + goalOption.height + weight.height + units.gu(8)
                width:parent.width
                Column{
                    id:secCol
                anchors.fill:parent
                spacing: units.gu(2)

                Label {
                    id:calText
                    text: "Set water goal by"
                }
             OptionSelector {
                    id:goalOption
                    selectedIndex: goal.contents.check
                    Item{id:goalSelect
                        property var selected: goalOption.selectedIndex;
                        function g() { if (goalOption.selectedIndex === 1) {
                                goal.contents = {check: true}
                                } else{goal.contents = {check: false}
                                        }
                         }}
                       model: [i18n.tr("Use Weight"),i18n.tr("Set Goal")]
                       onSelectedIndexChanged:{goalSelect.g()
                                               update.all()}
             }
    TextField {
        id: weight
        width:unitOption.width
        placeholderText:  update.text
        inputMethodHints: Qt.ImhDialableCharactersOnly
                 }
                }
            }
            ListItem.Standard {
                text: "Reset current progress"
                onClicked: (PopupUtils.open(dialogReset))
                progression: true
            }

    }
    }
}
}



