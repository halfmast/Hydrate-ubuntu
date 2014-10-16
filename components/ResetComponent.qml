import QtQuick 2.0
import Ubuntu.Components 1.1
import Ubuntu.Components.Popups 0.1
import "../components"


Component {
         id: dialogReset
         Dialog {
             id: resetDialog
             title: "Reset Progress"
             text: "Deletes your current progress for the day"

             Button {
                 id: resetbutton
                 text: 'Yes'
                 color: "#57a5bf"
                 onClicked: {
                     water_doc.contents = {water: 0}
                     liter_doc.contents = {liter: 0}
                     oz.current = 0
                     waterlvl.height = 0
                     liter.water = 0
                     pageStack.pop()
                     PopupUtils.close(resetDialog)
                     //start.startupFunction()
                 }
             }
             Button {
                 id: cancel
                 color:"#dd4814"
                 text: 'No'
                 onClicked: {PopupUtils.close(resetDialog)}
             }
         }
    }//end of Component 3
