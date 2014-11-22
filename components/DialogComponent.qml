import QtQuick 2.0
import Ubuntu.Components 1.1
import Ubuntu.Components.Popups 0.1
import "../backend/script.js" as Logic

Component {
        id: dialogComponent
        Dialog {
            id: dialog
            title: "Add Water"
            text: i18n.tr("How much water did you consume?")
            Item{
                id:current
                property int holder: 0
            }

            Button {
                text: userSettings.contents.metrics === 1 ? "300 mL": "8 Oz"
                color: "#8DD9D9"
                onClicked:{
                    current.holder = userProgress.contents.current;
                    userProgress.contents = {current: Logic.addWater(300, 8, userSettings.contents.metrics, current.holder),weight: userProgress.contents.weight,
                        level: userProgress.contents.level, needed: userProgress.contents.needed}
                    userProgress.contents = {current: userProgress.contents.current,level:Logic.lvl(userProgress.contents.current, userProgress.contents.needed, userProgress.contents.level),
                        weight: userProgress.contents.weight, needed: userProgress.contents.needed}
                    PopupUtils.close(dialog);
                }
            }

            Button {
                text: userSettings.contents.metrics === 1 ? "400mL": "12 Oz"
                color: "#7FCCD2"
                onClicked:{
                    current.holder = userProgress.contents.current;
                    userProgress.contents = {current: Logic.addWater(400, 12, userSettings.contents.metrics, current.holder),weight: userProgress.contents.weight,
                        level: userProgress.contents.level, needed: userProgress.contents.needed}
                    userProgress.contents = {current: userProgress.contents.current,level:Logic.lvl(userProgress.contents.current, userProgress.contents.needed, userProgress.contents.level),
                        weight: userProgress.contents.weight, needed: userProgress.contents.needed}
                    PopupUtils.close(dialog);
                }
                    }

            Button {
                text: userSettings.contents.metrics === 1 ? "500 mL": "16 Oz"
                color: "#72BFCC"
                onClicked:{
                    current.holder = userProgress.contents.current;
                    userProgress.contents = {current: Logic.addWater(500, 16, userSettings.contents.metrics, current.holder),weight: userProgress.contents.weight,
                        level: userProgress.contents.level, needed: userProgress.contents.needed}
                    userProgress.contents = {current: userProgress.contents.current,level:Logic.lvl(userProgress.contents.current, userProgress.contents.needed, userProgress.contents.level),
                        weight: userProgress.contents.weight, needed: userProgress.contents.needed}
                    PopupUtils.close(dialog);
                }
                    }

            Button {
                text: userSettings.contents.metrics === 1 ? "600 mL": "20 Oz"
                color:"#64B2C5"
                onClicked:{
                    current.holder = userProgress.contents.current;
                    userProgress.contents = {current: Logic.addWater(600, 20, userSettings.contents.metrics, current.holder),weight: userProgress.contents.weight,
                        level: userProgress.contents.level, needed: userProgress.contents.needed}
                    userProgress.contents = {current: userProgress.contents.current,level:Logic.lvl(userProgress.contents.current, userProgress.contents.needed, userProgress.contents.level),
                        weight: userProgress.contents.weight, needed: userProgress.contents.needed}
                    PopupUtils.close(dialog);
                }
            }

            Button {
                text: userSettings.contents.metrics === 1 ? "700 mL": "24 Oz"
                color:"#57a5bf"
                onClicked:{
                    current.holder = userProgress.contents.current;
                    userProgress.contents = {current: Logic.addWater(700, 24, userSettings.contents.metrics, current.holder),weight: userProgress.contents.weight,
                        level: userProgress.contents.level, needed: userProgress.contents.needed}
                    userProgress.contents = {current: userProgress.contents.current,level:Logic.lvl(userProgress.contents.current, userProgress.contents.needed, userProgress.contents.level),
                        weight: userProgress.contents.weight, needed: userProgress.contents.needed}
                    PopupUtils.close(dialog);
                }
            }

       Button {
           text: i18n.tr("Cancel")
            //color:"#dd4814"
            onClicked:{ PopupUtils.close(dialog) }
               }
}
}



