import QtQuick 2.0
import Ubuntu.Components 1.1
import Ubuntu.Components.Popups 0.1
import "../backend/script.js" as Logic


Component {
         id: historyReset
         Dialog {
             id: historyDialog
             title: "Clear History"
             text: "Deletes history log "

             function deletePlayer() {
             var tempContents = {};
             tempContents = playerInfo.contents;
             var index = tempContents.players.indexOf();
             tempContents.players.splice(0, 31);
             playerInfo.contents = tempContents;
             }

             Button {
                 id: resetbutton
                 text: "Clear"
                 color: "#57a5bf"
                 onClicked: {
                     userProgress.contents = {current: 0, weight:userProgress.contents.weight, level: 0, needed: userProgress.contents.needed, mL: 0}
                     userSettings.contents = { metrics:userSettings.contents.metrics, "day": 0, "goals": 1 };
                     deletePlayer();
                     PopupUtils.close(historyDialog)
                     stack.pop(home)
                     //start.startupFunction()
                 }
             }
             Button {
                 id: cancel
                 text: "Cancel"
                 onClicked: {PopupUtils.close(historyDialog)}
             }
         }
    }//end of Component 3
