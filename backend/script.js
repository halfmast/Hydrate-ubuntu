//---- welcome screen ----//
function label (metrics, current) {
    if (metrics === 0) {
        //imperial mode
        return current + " Oz "
    } else if ( metrics === 1 && current >= 1000 ) {
        // metric mode water drank more than liter
        return (current/1000) + " L "
    } else {
        // metric mode on drank less than liter
        return current + " mL "
    }
}
function emptyLabel (metrics) {
    if (metrics === 0) {
        //imperial mode
        return " Oz "
    } else{
        // metric mode water drank more than liter
        return " L "
    }
}


//----Main Page----//


//generates the percentage on the top square
function percentage(current,needed) {
    return Math.round((current / needed) * 100);
}

//changes today progress text
function text(current, needed, metrics) {
    if(metrics === 1 && needed >= 1000 && current >= 1000){
        //metric on needed and current grater are in liters
        return (current/1000) + " L / " + (needed/1000) + " L";

    } else if(metrics === 1 && needed >=1000){
        //if metrics is on and needed is in liters but current is milliters
        return current + " mL / " + (needed/1000) + " L";
    } else {
        //imperial mode on
        return current + " Oz / " + needed + " Oz";}
}

//adds water to current amount
function addWater(met, imp, metrics, current){
    if(metrics === 1){
        //current = Math.round(current + ( met / 29.5735));
        current = current + met;
        return current
    } else {
        current = current + imp;
        return current
    }

}
//water lvl height
function lvl(current, need, lvl){
    //console.log("pre" + lvl)
    if (lvl <= 100 && current === 0) {
        current = 1;
        lvl = ((current / need ));
        return lvl;
    }else if(lvl <= 100){
            lvl = ((current / need ));
            return lvl;
        } else {return 100}
}
//---- History ----//
//gets the current day number from date
function checkDay(){
    var day = new Date().getDate();
    //console.log("Js day = " + day);
    return day;
}

//gets the shorten month name for date
function month(){
    var d = new Date();
    var n = d.getMonth();
    var month = ['Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec'];
    var m = month[n];
    //console.log("Js month is " + m)
    return m;
}
/*function deleteFirstPlayer(player) {
var tempContents = {};
tempContents = playerInfo.contents;
var index = tempContents.players.indexOf(player);
tempContents.players.splice(0, 1);
playerInfo.contents = tempContents;
}*/



//---- Settings ----//

// changes and set text in text field
function lorem(unit, goal, weight){
    if(unit === 1 && goal === 1){
        //metric on. goal mode being used
        return weight + " liters"
    } else if(unit === 0 && goal === 1){
        //imperial on. goal mode being used
        return weight + " ounces"
    } else if(unit === 1 && goal === 0){
        //metric on. goal mode not used
        return weight + " kilograms"
    } else {
        // imperial on. goal mode not used
        return weight + " pounds"
    }
}

//setting page text
function placeLorem(index, goal){
    if(index === 1 && goal === 0){
        //metrics and goal off
        return "Enter weight in kilograms"
    } else if(index === 1 && goal === 1){
        //metric and goal on
        return "Target goal amount in liters"
    } else if(index === 0 && goal === 1) {
        //imperial and goal off
        return "Target goal amount in ounces"
    }else {
        return "Enter weight in pounds"
    }
}

// Handles setting new weight or goal
function save(text, weight){
    if(text <= 0){
        //weight/goal can't be less than 0. sets it to current weight
        return weight
    } else {
        return text;}
}

function waterNeeded(weight, goal, metrics){
    if(goal === 1 && metrics === 1){
        //goal on metric used. converts weight to liters
        return (weight*1000);
    } else if(goal === 0 && metrics === 1){
        //halfs weight and converts to ounces
        weight =Math.round((weight*35)/2).toFixed(1);
        return weight;
    }else if(goal === 0 && metrics === 0) {
        return Math.round(weight/2);
    }else {
        return weight;
    }
}

