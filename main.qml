import QtQuick 2.0
import Ubuntu.Components 1.1
import U1db 1.0 as U1db
import Ubuntu.Components.Popups 1.0
import "backend/script.js" as Logic
import "components"


MainView {
    objectName: "mainView"
    applicationName: "com.ubuntu.developer.kevinfeyder.drops"
    useDeprecatedToolbar: false
    width: units.gu(45)
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


    PageStack{
        id:stack
        Component.onCompleted: push(home)

        Page {
            id:home
            width:parent.width;
            title: i18n.tr("Hydrate")
            head.actions: Action {
                iconName: "settings"
                onTriggered: stack.push(settings);
            }
            ButtonComponent{
                id:ui
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
            DialogComponent{
                id:buttons
            }
        }//end of page
        SettingComponent{
            id:settings
        }
    }
}


