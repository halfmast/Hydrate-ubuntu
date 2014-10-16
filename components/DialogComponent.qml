import QtQuick 2.0
import Ubuntu.Components 1.1
import Ubuntu.Components.Popups 0.1
import "../components"

//dialog for add water

Component {
        id: dialogComponent
        Dialog {
            id: dialog
            title: "Add Water"
            text: i18n.tr("How much water did you consume?")

            Button {
                id: one
                states: State{
                    when: number_doc.contents.metric === true
                        PropertyChanges {
                            target:one; text: i18n.tr("300 mL")}
                    }

                text: i18n.tr("8 Oz")
                color: "#8DD9D9"
                onClicked:{
                    PopupUtils.close(dialog);
                    math.addwater(8,300);
                }
            }

            Button {
                id: sec
                states: State{
                    when: number_doc.contents.metric === true
                    PropertyChanges {target:sec; text: i18n.tr("400 mL")}
                }
                text: i18n.tr("12 Oz")
                color: "#7FCCD2"
                onClicked:{
                 PopupUtils.close(dialog);
                 math.addwater(12,400);
                 convert.liter
                }
                    }

            Button {
                id: third
                states: State{
                    when: number_doc.contents.metric === true
                    PropertyChanges {target:third; text: i18n.tr("500 mL")}
                }
                text: i18n.tr("16 Oz")
                color: "#72BFCC"
                onClicked:{
                    PopupUtils.close(dialog);
                    math.addwater(16,500);
                }
                    }

            Button {
                id: four
                states: State{
                    when: number_doc.contents.metric === true
                    PropertyChanges {target:four; text: i18n.tr("600 mL")}
                }
                text: i18n.tr("20 Oz")
                color:"#64B2C5"
                onClicked:{
                    PopupUtils.close(dialog);
                    math.addwater(20,600);
                }
                    }

            Button {
                id: five
                states: State{
                    when: number_doc.contents.metric === true
                    PropertyChanges {target:five; text: i18n.tr("700 mL")}
                }
                text: i18n.tr("24 Oz")
                color:"#57A5BF"
                onClicked:{
                    PopupUtils.close(dialog);
                    math.addwater(24,700);
                }
                   }

       Button {
           text: i18n.tr("Cancel")
            color:"#dd4814"
            onClicked:{ PopupUtils.close(dialog) }
               }
}
}



