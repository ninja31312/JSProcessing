
// JSProcessing will redraw every 1 sec.

var DirectionEnum = {"UP":4, "DOWN":8, "LEFT":2, "RIGHT":1};
var currentDirection = DirectionEnum.RIGHT;

function location(x, y) {
    x = Math.ceil(x);
    y = Math.ceil(y);
    return {
        "x" : x,
        "y" : y
    };
};

Array.prototype.contains = function(obj) {
    var i = this.length;
    while (i--) {
        if (this[i]["x"] == obj["x"] && this[i]["y"] == obj["y"]) {
            return true;
        }
    }
    return false;
}

Array.prototype.indexOf = function(obj) {
    var i = this.length;
    while (i--) {
        if (this[i]["x"] == obj["x"] && this[i]["y"] == obj["y"]) {
            return i;
        }
    }
    return -1;
}

Array.prototype.getLast = function() {
    if ( this.length > 0 )
        return this[ this.length - 1 ];
    else
        return undefined;
};

var snakeLocations = [];
var fruitLocations = [];

//function _shouldGameOver(var snakeLocations, var location)
//{
//    var totalCount = 0;
//    for(var i = 0 ; i < snakeLocations.length ; i ++){
//        if(snakeLocations.contains(location)){
//            totalCount +=1;
//        }
//    }
//    return totalCount > 1;
//}

function setUp()
{
    for(var i = 0 ; i < 5 ; i++){
        snakeLocations[i] = location(i,10);
    }
}

function draw()
{
	var distancePerStep = 20;
    var totalXSteps = 15;
    var totalYSteps = 25;
    var initXStep = 1;
    var initYStep = 1;
    
	for(var i = initXStep ; i < totalXSteps ; i++){
		for(var j = initYStep; j < totalYSteps; j++){
            color(0,0,255);
            rectStroke(i*distancePerStep,j*distancePerStep,distancePerStep,distancePerStep);
            //            log(location);
            if(snakeLocations.contains(location(i,j))){
				//black
				color(0,0,0);
				rectFill(i*distancePerStep,j*distancePerStep,distancePerStep,distancePerStep);

                if(fruitLocations.contains(location(i,j))){
                    var indexOfFruit = fruitLocations.indexOf(location(i,j));
                    fruitLocations.splice(indexOfFruit,1);
                    snakeLocations.push(location(i,j));
                }
			}else{
                if(fruitLocations.length < 3){
                    if(Math.floor(Math.random() * 100) == 5){
                        fruitLocations.push(location(i,j));
                    }
                }
                else{
                    //white
                    color(255,255,255);
                    rectFill(i*distancePerStep,j*distancePerStep,distancePerStep,distancePerStep);
                }
			}
		}
	}
    for(var k = 0 ; k < fruitLocations.length ; k ++){
        //fruits
        color(255,0,0);
        ellipseFill(fruitLocations[k]["x"] * distancePerStep + (distancePerStep / 2),fruitLocations[k]["y"] * distancePerStep + (distancePerStep / 2), distancePerStep, distancePerStep);
    }
    snakeLocations.shift();
    headLocation = snakeLocations.getLast()
    var x, y;
    switch(currentDirection){
        case  DirectionEnum.UP:
            x = headLocation["x"];
             headLocation["y"] <= initYStep ? y = totalYSteps - 1 : y = headLocation["y"] - 1;
            break;
        case  DirectionEnum.DOWN:
            x = headLocation["x"];
             headLocation["y"] >= totalYSteps ? y = initYStep : y = headLocation["y"] + 1;
            break;
        case  DirectionEnum.LEFT:
            headLocation["x"] <= initXStep ? x = totalXSteps - 1 : x = headLocation["x"] - 1;
            y = headLocation["y"];
            break;
        case  DirectionEnum.RIGHT:
            headLocation["x"] >= totalXSteps ? x = initXStep : x = headLocation["x"] + 1;
            y = headLocation["y"];
            break;
        default:
            x = initXStep;
            y = initYStep;
            break;
    }
    snakeLocations.push(location(x, y));
};