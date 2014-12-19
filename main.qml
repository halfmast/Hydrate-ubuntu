import QtQuick 2.0
import Ubuntu.Components 1.1
import U1db 1.0 as U1db
import Ubuntu.Components.Popups 1.0
import "backend/script.js" as Logic
import "components"
import Ubuntu.Components.ListItems 0.1 as ListItem
import Ubuntu.Layouts 0.1


MainView {
    objectName: "mainView"
    applicationName: "com.ubuntu.developer.kevinfeyder.drops"
    useDeprecatedToolbar: false
    backgroundColor: "#f9f9f9"
    width: units.gu(80)
    height: units.gu(75)

    U1db.Database {
        id:hydrateSave;
        path: "math.u1db"
    }
    U1db.Document {
      id: userProgress
      //stores waterlvl number, and user progress and end goal
      database: hydrateSave
      docId: "progress"
      create: true
      defaults: { "level": 0, "needed": 100, "current": 0, "weight": 200}
    }
    U1db.Document {
      id: userSettings
      //stores waterlvl number, and user progress and end goal
      database: hydrateSave
      docId: "uSet"
      create: true
      defaults: { "metrics": 1, "day": 0, "goals": 0 }
    }

    //--- history database ---//
    U1db.Database {
        id: playerDB
        path: "playerDB.u1db"
    }
    U1db.Document {
        docId: "playerInfo"
        id: playerInfo
        database: playerDB
        create: true
        defaults: {
            "players": []
        }
    }

    Item {
        id:cartoon
        /*states: State {
            name: "anime"
            AnchorChanges { target: ui; anchors.bottom: parent.bottom}
        }*/
        transitions: Transition {
            ParallelAnimation {
            //AnchorAnimation { easing.type:Easing.OutQuart; duration: 1000}
            NumberAnimation  { target:ui; property: "opacity"; to: .8; duration: 900 }
            NumberAnimation { targets: shape; properties: "opacity"; to:.8; duration: 900 }
            }
        }
        Component.onCompleted: cartoon.state = "anime";
        }

    Item {
        Timer {
            interval: 500; running: true; repeat: true
            onTriggered:{ check.day(); }
        }
    }

    Item {
    id: check
    //check date and resets app
    function storePlayer(playerObject) {
    var tempContents = {};
    tempContents = playerInfo.contents;
    if (tempContents.players.indexOf(playerObject) != -1) throw "Already exists";
    tempContents.players.push(playerObject);
    playerInfo.contents = tempContents;
    }
    function deleteFirstPlayer(player) {
    var tempContents = {};
    tempContents = playerInfo.contents;
    var index = tempContents.players.indexOf(player);
    tempContents.players.splice(0, 1);
    playerInfo.contents = tempContents;
    }
        function day() {
            //property var m: month[n];
             Logic.checkDay();
            if (userSettings.contents.day === Logic.checkDay()) {
                //nothing happens
            } else if ( userSettings.contents.day === 0 ) {
                userSettings.contents = {"metrics": userSettings.contents.metrics, "day": Logic.checkDay(), "goals": userSettings.contents.goals};
            } else {
                //adding to history
                if(playerInfo.contents.players.length <= 4){
                check.storePlayer({"count":Logic.month() + " " + userSettings.contents.day, "progress":Logic.text(userProgress.contents.current,userProgress.contents.needed, userSettings.contents.metrics)})
                }else{
                    check.deleteFirstPlayer()
                    check.storePlayer({"count":Logic.month() + " " + userSettings.contents.day, "progress":Logic.text(userProgress.contents.current,userProgress.contents.needed, userSettings.contents.metrics)})
            }
                //userSettings.contents = {day: n};
                userProgress.contents = {current: 0, weight:userProgress.contents.weight, level: 0, needed: userProgress.contents.needed}
                userSettings.contents = { "metrics": userSettings.contents.metrics, "day": Logic.checkDay(), "goals": userSettings.contents.goals }
            }
        }
    }




    PageStack{
        id:stack
        Component.onCompleted: stack.push(home)//push(home)



        PageWithBottomEdge {
            id:home
            width:parent.width;
            title: i18n.tr("Hydrate")
            head.actions: Action {
                iconName: "settings"
                onTriggered: stack.push(settings);
            }
            bottomEdgeTitle: "History"

            Loader { id: loading }
            bottomEdgePageComponent:loading.sourceComponent = crom;
            bottomEdgeEnabled: if(greenButton.width > 0){false}else{true}

            Layouts {
                objectName: "layouts"
                id: layouts
                anchors.fill: parent
                layouts: [
                    ConditionalLayout {
                        //phone layout
                        name: "phone"
                        when: layouts.width < units.gu(80)
                            Row {
                                anchors.fill: parent
                                ItemLayout {
                                    item: "water"
                                    width: parent.width
                                    anchors {
                                        top: parent.top
                                        bottom: parent.bottom
                                    }
                                }
                                ItemLayout {
                                    item: "history"
                                    width:0
                                    anchors {
                                        top: parent.top
                                        bottom: parent.bottom
                                    }
                                }
                            }
                        },
                        ConditionalLayout {
                            //end of tablet layout
                            name: "tablet"
                            when: layouts.width > units.gu(60)
                            Row {
                                anchors.fill: parent
                                ItemLayout {
                                    item: "water"
                                    width: parent.width / 1.8
                                    anchors {
                                        top: parent.top
                                        bottom: parent.bottom
                                    }
                                }
                                ItemLayout {
                                    item: "history"
                                    width: parent.width / 2.5
                                    anchors {
                                        top: parent.top
                                        bottom: parent.bottom
                                    }
                                }
                            }
                        }
                    ]//end of layouts
                    Item {
                        id: redButton
                        width: parent.width
                        Layouts.item: "water"
                        anchors {
                            left: parent.left
                            top: parent.top
                            bottom: parent.bottom
                        }
                        ButtonComponent{
                                        id:ui
                                        opacity: 0;
                                        //anchors.top: parent.top;
                                    }
                                    DialogComponent{
                                        id:buttons
                                    }
                    }
                    Item{id:greenButton
                        Layouts.item: "history"
                        anchors {
                            top: parent.top
                            left: redButton.right
                            right: parent.right
                        }

                        Rectangle{
                            id:shape
                            opacity: 0;
                            radius:units.gu(2)
                            color: "#ffffff";
                            height:greenButton.height-units.gu(8);
                            width:greenButton.width
                            anchors{ verticalCenter: parent.verticalCenter}
                            border.width:units.gu(.1)
                            border.color: "#e0e6ed"
                            History{
                                id:lore
                                visible: if(greenButton.width > 0){true}else{false}
                                height:greenButton.height-units.gu(4);
                                width:greenButton.width
                            }
                }
            }//end of greenButton
        }

            Rectangle {
                id:waterLvl
                z:-1 //keeps water backdrop behind ui elements
                gradient: Gradient {
                    GradientStop { position: 0.0; color: "#8DD9D9" }
                    GradientStop { position: 1.0; color: "#57a5bf" }
                }
                Behavior on height { NumberAnimation { easing.type: Easing.OutBack; duration: 1000} }
                height:userProgress.contents.level*home.height;
                width:parent.width
                anchors.bottom:parent.bottom;
            }
        }//end of page

        SettingComponent{
            id:settings
        }
        Component{
            id:crom
        Page {
            id:hiscore
            title: i18n.tr("History")
            visible: false;
            History{
                width:parent.width
            }
        }
        }



    }
}


