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
		parseMouseLocation();
	}

// listParams() is for testing purposes only. It may be commented out once the system is completed.

	verb{
		listParams(){
			for(var/p in usr.paramlist){usr << "[p] = [usr.paramlist[p]]";}
			usr << "mouseX = [usr.mouseX]\nmouseY = [usr.mouseY]\n quadrant =[usr.quadrant]\ntheta = [usr.theta]";
		}
	}



	proc
	{

// parseMouseLocation() is used to take data from MouseMove and convert the required member of the
// mouse control parameters list into a string before changing it to an x,y coordinate held in two
// numerical variables.

		parseMouseLocation()
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
			usr.mouseX = (tileX*32) + tilepixelX;
			usr.mouseY = (tileY*32) + tilepixelY;

			calcTheta()
		}

//	calcTheta calculates the usr.theta value for the rotation of the mob. This does it with usr.mouseX and usr.mouseY whilst taking in consideration the mob's position on the screen.

		calcTheta()
		{
			var/center2mouseX = usr.mouseX - 224;
			var/center2mouseY = usr.mouseY - 224;
			usr << "center2mouseX = [center2mouseX]\ncenter2mouseY = [center2mouseY]"
			var/oavalue = center2mouseY/center2mouseX;
			usr.theta = arccos(1/sqrt(1+oavalue*oavalue));
			if(usr.theta<0)	{ usr.theta = usr.theta*-1; }


			if(center2mouseX>=0 && center2mouseY >=0) {usr.quadrant = 1; }
			else if(center2mouseX<0 && center2mouseY >= 0) {usr.quadrant = 2; }
			else if(center2mouseX<0 && center2mouseY < 0 ) {usr.quadrant = 3; }
			else if(center2mouseX>=0 && center2mouseY < 0) { usr.quadrant = 4;}
			else
			{
				usr.quadrant = 1;
				usr.theta = 0;
			}
		}
	}
}