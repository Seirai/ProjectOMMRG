//	Movement Engine for OMRRG
// CTRL+F "--01_MovementVars--" to find the variables used by this function.
//
// variables used in other modules:
// usr.paramlist
// usr.mouseX
// usr.mouseY
// usr.theta
//

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
			usr << "mouseX = [usr.mouseX]\nmouseY = [usr.mouseY]";
		}
	}

// parseMouseLocation() is used to take data from MouseMove and convert the required member of the
// mouse control parameters list into a string before changing it to an x,y coordinate held in two
// numerical variables.

	proc
	{
		parseMouseLocation()
		{
			var/paramlength = lentext(usr.paramlist["screen-loc"]);
			var/separator = findtext(usr.paramlist["screen-loc"],",",1,paramlength);
			var/x_half = copytext(usr.paramlist["screen-loc"],1,separator);
			var/y_half = copytext(usr.paramlist["screen-loc"],separator,0);
			usr << "coord: [usr.paramlist["screen-loc"]]"
			separator = findtext(x_half,":",1,0);
			var/tilepixelX = text2num(copytext(x_half,separator+1,0));
			var/tileX = text2num(copytext(x_half,separator-1,0));
			separator = findtext(y_half,":",1,0);
			var/tilepixelY = text2num(copytext(y_half,separator+1,0));
			var/tileY = text2num(copytext(y_half,separator-1,0));
			usr.mouseX = (tileX*32) + tilepixelX;
			usr.mouseY = (tileY*32) + tilepixelY;
			usr << "mouse X: [usr.mouseX]\nmouse Y: [usr.mouseY]";
		}
	}
}