
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
            log(i);
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
	var step = 20;
    var xParts = Math.ceil(width/step);
    var yParts = Math.ceil(height/step);
    
	for(var i = 0 ; i < xParts ; i++){
		for(var j = 0; j < yParts; j++){
//            location = location(i,j);
//            if(_shouldGameOver(snakeLocations, location(i,j))){
//                noLoop();
//            }
			if(snakeLocations.contains(location(i,j))){
				//black
				color(0,0,0);
				rectFill(i*step,j*step,step,step);

                if(fruitLocations.contains(location(i,j))){
                    var indexOfFruit = fruitLocations.indexOf(location(i,j));
                    fruitLocations.splice(indexOfFruit,1);
                    snakeLocations.push(location(i,j));
                }
//                else{
//                    var totalCount = 0;
//                    for(var index = 0 ; index < snakeLocations.length ; index ++){
//                        if(snakeLocations[index]["x"] == i && snakeLocations[index]["y"] == j){
//                            totalCount +=1;
//                        }
//                    }
//                    if(totalCount == 2){
//                        noLoop();
//                    }
//                }
                
			}else{
                if(fruitLocations.length < 3){
                    if(Math.floor(Math.random() * 100) == 5){
                        fruitLocations.push(location(i,j));
                    }
                }
                else{
                    //white
                    color(255,255,255);
                    rectFill(i*step,j*step,step,step);
                }
			}
		}
	}
    for(var k = 0 ; k < fruitLocations.length ; k ++){
        //red
        color(255,0,0);
        ellipseFill(fruitLocations[k]["x"] * step + 5,fruitLocations[k]["y"] * step + 3,step,step);
    }
    snakeLocations.shift();
    headLocation = snakeLocations.getLast()
    var x, y;
    switch(currentDirection){
        case  DirectionEnum.UP:
            x = headLocation["x"];
             headLocation["y"] <= 0 ? y = yParts : y = headLocation["y"] - 1;
            break;
        case  DirectionEnum.DOWN:
            x = headLocation["x"];
             headLocation["y"] >= yParts ? y = 0 : y = headLocation["y"] + 1;
            break;
        case  DirectionEnum.LEFT:
            log(headLocation["x"]);
            headLocation["x"] <= 0 ? x = xParts : x = headLocation["x"] - 1;
            y = headLocation["y"];
            break;
        case  DirectionEnum.RIGHT:
            headLocation["x"] >= xParts ? x = 0 : x = headLocation["x"] + 1;
            y = headLocation["y"];
            break;
        default:
            x = 0;
            y = 0;
            break;
    }
    snakeLocations.push(location(x, y));
};