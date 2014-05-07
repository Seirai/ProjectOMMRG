//	Movement Engine for OMRRG
//	This is utilized to extract the mouse's x,y coordinates with the center of the screen being the origin point of the graph.
//	Theta is also calculated and extracted for usage.
//
// CTRL+F "--01_MovementVars--" to find the variables and other things used by this function.
//
// variables used in other modules
// -- 10_Mob --
// usr.paramlist
// usr.mouseX
// usr.mouseY
// usr.theta
// usr.quadrant
//
// -- Verbs --
// moveUp
// moveLeft
// moveRight
// moveBack

#define VERBOSE 1
#define TILESIZE 32

	///////////////////////
	// MouseMove funcn's //
	///////////////////////
atom
{
// MouseMove(atom/location,control,params) is a predefined proc which is called whenever
// the mouse is moved.
//
// This is adding upon the default proc a chunk to take the paramaeters of the Mouse
// pertaining the current user to place it within a list for further manipulation.

	MouseMove(atom/location, control, params)
	{
		..();
		usr.paramlist = params2list(params);
		parseMouseLocation(location);
	}

// listParams() is for testing purposes only. It may be commented out once the system is completed.

	verb{
		listParams(){
			for(var/p in usr.paramlist){usr << "[p] = [usr.paramlist[p]]";}
			if(VERBOSE) usr << "mouseX = [usr.mouseX]\nmouseY = [usr.mouseY]\n quadrant =[usr.quadrant]\ntheta = [usr.theta]";
		}
	}



	proc
	{

// parseMouseLocation() is used to take data from MouseMove and convert the required member of the
// mouse control parameters list into a string before changing it to an x,y coordinate held in two
// numerical variables.

		parseMouseLocation(atom/location)
		{
			var/paramlength = lentext(usr.paramlist["screen-loc"]);

			var/separator = findtext(usr.paramlist["screen-loc"],",",1,paramlength);
			var/x_half = copytext(usr.paramlist["screen-loc"],1,separator);
			var/y_half = copytext(usr.paramlist["screen-loc"],separator+1,0);

			separator = findtext(x_half,":",1,0);
			var/tilepixelX = text2num(copytext(x_half,separator+1,0));
			var/tileX = text2num(copytext(x_half,1,separator));

			separator = findtext(y_half,":",1,0);
			var/tilepixelY = text2num(copytext(y_half,separator+1,0));
			var/tileY = text2num(copytext(y_half,1,separator));

			usr.mouseX = ((tileX-1)*TILESIZE) + tilepixelX;
			usr.mouseY = ((tileY-1)*TILESIZE) + tilepixelY;

			usr.mouse_turf = location;

			calcTheta()
		}

//	calcTheta calculates the usr.theta value for the rotation of the mob. This does it with usr.mouseX and usr.mouseY whilst taking in consideration the mob's position on the screen.

		calcTheta()
		{
			var/center2mouseX = usr.mouseX - 224;
			var/center2mouseY = usr.mouseY - 224;
			if(VERBOSE) usr << "center2mouseX = [center2mouseX]\ncenter2mouseY = [center2mouseY]"
			if(center2mouseX == 0) center2mouseX = 1; //fix up divide by zero bug when mouse is on the x=0 axis
			var/oavalue = center2mouseY/center2mouseX;
			usr.theta = arccos(1/sqrt(1+oavalue*oavalue));
			if(usr.theta<0)	{ usr.theta = usr.theta*-1; }


			if(center2mouseX>=0 && center2mouseY >=0) {usr.quadrant = 1; usr.angle = 360 - usr.theta; }
			else if(center2mouseX<0 && center2mouseY >= 0) {usr.quadrant = 2; usr.angle = 180 + usr.theta; }
			else if(center2mouseX<0 && center2mouseY < 0 ) {usr.quadrant = 3; usr.angle = 180 - usr.theta; }
			else if(center2mouseX>=0 && center2mouseY < 0) { usr.quadrant = 4; usr.angle = usr.theta; }
			else
			{
				usr.quadrant = 1;
				usr.theta = 0;
			}
			if(VERBOSE) usr << "usr.angle = [usr.angle]";
		}


		// Rotate to Target
		// Call this when you want the usr to rotate towards the pixel location of a target
		// Input: None
		// Output: None
		rotateToTarget(atom/target){
			var/matrix/M = matrix();
			M.Turn(usr.theta);
			src.transform = M;
		}

		// Parse Location
		// Gets the center of the mob's bounding box, in pixels
		// Input: None
		// Output: int list of pixel location, ordered xy[1] = x, xy[2] = y
		parseLocation(){
			var/list/xy[2];
			xy[1] = ((usr.x-1)*world.icon_size) + usr.step_x + usr.bound_width/2;
			xy[2] = ((usr.y-1)*world.icon_size) + usr.step_y + usr.bound_height/2;
			if(VERBOSE) usr << "xy[1] = [xy[1]]\nxy[2] = [xy[2]]"
			return xy;
		}
	}
}