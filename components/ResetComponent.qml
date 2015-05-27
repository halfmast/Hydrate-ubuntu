import QtQuick 2.0
import Ubuntu.Components 1.1
import Ubuntu.Components.Popups 0.1
import "../backend/script.js" as Logic


Component {
         id: dialogReset
         Dialog {
             id: resetDialog
             title: "Reset"
             text: "Deletes your progress or restore to default"
             function deletePlayer() {
             var tempContents = {};
             tempContents = playerInfo.contents;
             var index = tempContents.players.indexOf();
             tempContents.players.splice(0, 31);
             playerInfo.contents = tempContents;
             }

             Button {
                 id: resetbutton
                 text: "Reset"
                 color: "#72BFCC"
                 onClicked: {
                     userProgress.contents = {current: 0, weight:userProgress.contents.weight, level: 0, needed: userProgress.contents.needed, mL: 0}
                     userSettings.contents = { metrics:userSettings.contents.metrics, "day": 0, "goals": 1 }
                     waterMetric.update(0)
                     PopupUtils.close(resetDialog)
                     stack.pop(home)
                     //start.startupFunction()
                 }
             }
             Button {
                 id: restorebutton
                 text: "Restore To Default"
                 color:"#57a5bf"
                 onClicked: {
                     userProgress.contents = {current: 0, weight:userProgress.contents.weight, level: 0, needed: userProgress.contents.needed, mL: 0}
                     userSettings.contents = { "metrics":1, "day": 0, "goals": 1 }
                     waterMetric.update(0)
                     deletePlayer();
                     PopupUtils.close(resetDialog)
                     //stack.pop(settings)
                     //start.startupFunction()
                 }
             }
             Button {
                 id: cancel
                 text: "Cancel"
                 onClicked: {PopupUtils.close(resetDialog)}
             }
         }
    }//end of Component 3
