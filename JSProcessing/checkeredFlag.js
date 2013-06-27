
// JSProcessing will redraw every 1 sec.
function draw()
{
	var totalParts = 10;
	var xStep = width/totalParts;
	var yStep = height/totalParts;
	for(var i = 0 ; i < totalParts ; i++){
		for(var j = 0; j <totalParts; j++){
			if((i+j)%2 == 0){
				//black
				color(0,0,0);
				rectFill(i*xStep,j*yStep,xStep,yStep);
			}else{
				//white
				color(255,255,255);
				rectFill(i*xStep,j*yStep,xStep,yStep);
			}
		}
	}
};