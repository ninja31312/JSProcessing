
// JSProcessing will redraw every 1 sec.
var draw = function(){
    // draw background image
    drawImage(110,180,100,100,'apple.png');
    
    // draw circle
    color(0,100,123);
	ellipseStroke(160,240,300,300);
    
    // draw numbers
    var radian = (Math.PI/6);
	var x1 = 160;
	var y1 = 240;
	var x2 = 160;
	var y2 = 380;
	for(var i = 0 ; i < 12 ; i ++){
		var dx = x2 - x1;
		var dy = y2 - y1;
		var distance = Math.sqrt(dx*dx + dy*dy);
		var newX = x1 + distance * Math.cos(Math.PI/2 - radian*i);
		var newY = y1 - distance * Math.sin(Math.PI/2 - radian*i);
		drawString(newX - 5, newY -5, 15, 15, (i == 0) ? 12 : i);
	}
    
    // draw time hands
	var date = new Date();
	var seconds = date.getSeconds();
	var mins = date.getMinutes();
	var hours = date.getHours();
	color(102,139,139);
	rotateLine(160,240,160,380,seconds*(Math.PI/30));
	color(0,100,200);
	rotateLine(160,240,160,350,mins*(Math.PI/30));
	color(0,100,400);
	rotateLine(160,240,160,300,hours*(Math.PI/6));
};