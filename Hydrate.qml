import QtQuick 2.0
import Ubuntu.Components 1.1
import Ubuntu.Components.Popups 0.1
import U1db 1.0 as U1db
import UserMetrics 0.1
import "components"

//last version size 156.7kb
MainView {
    objectName: "mainView"
    applicationName: "com.ubuntu.developer.kevinfeyder.hydrate"
    useDeprecatedToolbar: false
//start of items and var

 Metric {
       id: waterMetric
       name: "water-metrics"
       format: oz.label + oz.text + "of water consumed today"
       emptyFormat: "No" + oz.text + "consumed today"
       domain: "com.ubuntu.developer.KevinFeyder.hydrate"
        }

    Item { id:start;
        function startupFunction()
        {check.day()
         today_doc.contents = {today: 0}
         welcome.label()
         if (goal.contents.check === true && number_doc.contents.metric === true){oz.needed = Math.round(goalNum.contents.amount * 1000)}
            else{oz.needed = Math.round(weight_doc.contents.weight / 2)}
         oz.current = Math.round((water_doc.contents.water / oz.needed) * 100)
         waterlvl.height = (water_doc.contents.water / oz.needed) * glass.height;
         welcome.label();
         cartoon.state = "anime"
         }
         Component.onCompleted: startupFunction()}

    Item {
        id:cartoon
        states: State {
            name: "anime"
            AnchorChanges { target: button; anchors.bottom: parent.bottom }
        }

        transitions: Transition {
            ParallelAnimation {
            AnchorAnimation { easing.type:Easing.OutQuart; duration: 800}
            NumberAnimation  { target:button; property: "opacity"; to: .8; duration: 900 }
            }}
        }




U1db.Database {
  id: db
  path: "drop.u1db"
}

U1db.Document {
  id: text_doc
  database: db
  docId: "text"
  create: true
  defaults: { "words": "blank" }
  Component.onCompleted: { text_doc.contents.words }
                }
U1db.Document {
  id: goal
  database: db
  docId: "checkgoal"
  create: true
  defaults: { "check": true }
  Component.onCompleted: { goal.contents.check }
                }

U1db.Document {
  id: goalNum
  database: db
  docId: "goalweight"
  create: true
  defaults: { "amount": 100 }
  Component.onCompleted: { goalNum.contents.amount }
               }

U1db.Document {
  id: number_doc
  database: db
  docId: "save_messure"
  create: true
  defaults: { "metric": true }
  Component.onCompleted: { number_doc.contents.metric }
                }

U1db.Document {
  id: water_doc
  database: db
  docId: "save_water"
  create: true
  defaults: { "water": 0 }
  Component.onCompleted: { water_doc.contents.water }
               }
U1db.Document {
  id: liter_doc
  database: db
  docId: "save_liter"
  create: true
  defaults: { "liter": 0 }
  Component.onCompleted: {
}}
Item{id:convert;
    //converts ml to liter
    function liter(){
      if ( liter_doc.contents.liter >= 1000 )
          liter_doc.contents = {liter: liter_doc.contents.liter / 1000}
      else
          liter_doc.contents.liter
           }}
Item{
id: welcome
//function changes text on welcome screen and in InfoComponent
function label () {
    if (number_doc.contents.metric === false) {
        oz.text = " Oz "
    } else if ( liter_doc.contents.liter >= 1000 ) {
        oz.text = " L "
        liter.water = liter_doc.contents.liter / 1000
    } else {
        oz.text = " mL "
        liter.water = liter_doc.contents.liter
    }
}
}

U1db.Document {
  id: weight_doc
  database: db
  docId: "save_weight"
  create: true
  defaults: { "weight": 200 }
  Component.onCompleted: { weight_doc.contents.weight }
                }

Item{
id: screen
//provides the numbers on the welcome screen
function info () {
    if (number_doc.contents.metric === false) {
        oz.label = water_doc.contents.water
        } else {
        oz.label = liter.water
          }
}
}

U1db.Document {
  id: today_doc
  database: db
  docId: "save_date"
  create: true
  defaults: { "today": 0 }
  Component.onCompleted: { today_doc.contents.today }
                }
Item {
    Timer {
        interval: 500; running: true; repeat: true
        onTriggered:{
            check.day();}
    }
    Text { id: time }
}


     Item{
     id: check
     //check date and resets app
     function day() {
         var d = new Date();
         var n = d.getDate();
         if (today_doc.contents.today === n) {
             //nothing happens
         } else if ( today_doc.contents.today === 0 ) {
             //get.date()
             today_doc.contents = {today: n};

         } else {
             today_doc.contents = {today: n}
             water_doc.contents = {water: 0}
             liter_doc.contents = {liter: 0}
             oz.current = 0
             waterlvl.height = 0
             liter.water = 0
             }
     }}

Item {
    //metric variables
    id:oz
    property var needed: 100;
    property var current: 0;
    property var weight: 200;
    property string text: " Oz "
    property var label: 0;
      }

Item {
    //imperial varibles
    id: liter
    property var water: 0;
    property var weight: weight_doc.contents.weight * 2.2;
     }
    Item{
    id: math
    function addwater (imperial, metrics) {
        //goal mode off and with liters and kiolgrams
        if (goal.contents.check === false && number_doc.contents.metric === true){
            liter_doc.contents = {liter: liter_doc.contents.liter + metrics}
            water_doc.contents = {water:water_doc.contents.water + (metrics * 0.034)}
            oz.needed = Math.round(weight_doc.contents.weight / 2)
            oz.current = Math.round((water_doc.contents.water / oz.needed) * 100)
            waterlvl.height = (water_doc.contents.water / oz.needed) * glass.height
            waterMetric.increment(metrics)
            screen.info()
            welcome.label()
            }
        //goal mode on with liters and kiolgrams
        else if ( goal.contents.check === true && number_doc.contents.metric === true){
                liter_doc.contents = {liter: liter_doc.contents.liter + metrics}
                water_doc.contents = {water:water_doc.contents.water + metrics}
                oz.needed = Math.round(goalNum.contents.amount * 1000)
                oz.current = Math.round((water_doc.contents.water / oz.needed) * 100)
                waterlvl.height = (water_doc.contents.water / oz.needed) * glass.height
                waterMetric.increment(metrics)
                screen.info()
                welcome.label()
                }
        //goal mode on and with oz and pounds on
        else if (goal.contents.check === true && number_doc.contents.metric === false){
            water_doc.contents = {water:water_doc.contents.water + imperial }
            waterMetric.increment(metrics)
            oz.needed = (goalNum.contents.amount)
            oz.current = Math.round((water_doc.contents.water / oz.needed) * 100)
            waterlvl.height = (water_doc.contents.water / oz.needed) * glass.height
            screen.info()
            welcome.label()}
            //goal off with oz and pounds
            else{
                water_doc.contents = {water:water_doc.contents.water + imperial }
                waterMetric.increment(metrics)
                oz.needed = Math.round(weight_doc.contents.weight / 2)
                oz.current = Math.round((water_doc.contents.water / oz.needed) * 100)
                waterlvl.height = (water_doc.contents.water / oz.needed) * glass.height
                screen.info()
                welcome.label()}
    }
    }
    width: units.gu(45)
    height: units.gu(75)
    PageStack {
        id: pageStack
        Component.onCompleted: push(page0)

    Page {
        title: i18n.tr("Hydrate")
        id: page0
        tools: ToolbarItems {
            // define the action:
            ToolbarButton {
                action: Action {
                    text: "Settings"
                    iconSource: Qt.resolvedUrl("settings.svg")
                    iconName: "settings"
                    onTriggered: pageStack.push(page1);
                }

            }}
        Item {
            id:container
            anchors{fill:page0}
                ButtonComponent {
                    id:button
                    objectName: "ButtonComponent"
                    opacity: 0
                    anchors{bottom:buttonGap.top; bottomMargin: units.gu(1);horizontalCenter: parent.horizontalCenter}
                }
                Item {
                    id:buttonGap
                    anchors.horizontalCenter: parent.horizontalCenter; anchors.top:parent.bottom; anchors.topMargin: units.gu(30)
                }
                //start of dialog items
                DialogComponent {
                    objectName:"waterButtons"
                        id: dialogComponent
                                }
                ResetComponent {
                    objectName:"weightOption"
                        id: dialogReset
                                }
            }//column
        Rectangle {
            id: glass
            color: "transparent"
            anchors.fill: parent
                    }

        Rectangle {
            id: waterlvl
            z:-1
            anchors.bottom:parent.bottom
            width: parent.width
            height:units.gu(0)
            Behavior on height { NumberAnimation { duration: 1500 } }
            gradient: Gradient {
                GradientStop { position: 0.0; color: "#8dd9d9" }
                GradientStop { position: 1.0; color: "#57a5bf" }
                                }
                    }
    }//page

    SettingComponent {
        objectName:"settingspage"
            id: page1
            width:parent.width
                    }

    }//pagestack

}

