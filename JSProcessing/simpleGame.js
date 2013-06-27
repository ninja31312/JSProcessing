
//reference from http://processing.flosscience.com/processing-for-android/macul-2012/simple-game-code

xPos=0;                      //Position of the ball
speed=10;                   //How fast is it moving?
xDir=1;                    //what direction is the ball going?
score=0;                   //Inital score
lives=5;                   //Number of lives you start with
lost=false;            //Have you lost yet?

function setUp()
{
	xPos = width/2;
}

function draw()
{
	ellipseFill(xPos, height/2,40,40);                 //Draw the ball
	xPos=xPos+(speed*xDir);                        //update the ball's position
	if (xPos > width-20 || xPos<20)                //Did the ball hit the side?
	{
		xDir=-xDir;                                  //If it did reverse the direction
	}
	drawString(10,10,30,30,"score = "+score);                  //Print the score on the screen
	drawString(width-80,10,30,30,"lives = "+lives);            //Print remaining lives
	if (lives<=0)                                  //Check to see if you lost
	{
		drawString(125,100,200,200,"Click to Restart");
		noLoop();                                    //Stop looping at the end of the draw function
		lost=true;
	}
}

function mousePressed()                              //Runs whenever the mouse is pressed
{
	if (dist(mouseX, mouseY, xPos, height/2)<=40)      //Did we hit the target?
	{
		score=score+1;                           //Increase the speed
		speed=speed+5;                               //Increase the Score
	}
	else                                           //We missed
	{
		if (speed<1)                                 //If speed is greater than 1 decrease the speed
		{
			speed=speed-1;
		}
		lives=lives-1;                               //Take away one life
	}
	if (lost==true)                                //If we lost the game, reset now and start over
	{
		speed=10;                                     //Reset all variables to initial conditions
		lives=5;
		score=0;
		xPos=width/2;
		xDir=1;
		lost=false;
		loop();                                     //Begin looping draw function again
	}
}
