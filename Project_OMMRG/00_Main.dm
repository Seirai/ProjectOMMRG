/*	 Project OMMRG							*
 *	Comment style bitches :)				*
 *											*/

#define DEBUG 0
#define VERBOSE 1
#define TILESIZE 32

world
{
	fps = 30		// 25 frames per second
	icon_size = 32	// 32x32 icon size by default

	view = 16		// show up to 6 tiles outward from center (13x13 view)

	mob = /mob/player;

	/var/list/logs[0];

	map_format = TOPDOWN_MAP;

}

atom/movable/var/angle as num; //all moving things get an angle

proc{
}

// Make objects move 8 pixels per tick when walking

mob
{
	step_size = 8;
}
obj
{
	step_size = 8;
}

client{

	script = 'Macros.dms';

	macro_mode = 1;  //1 = keys are by default assumed to be macros

	show_popup_menus = 0;

	MouseDown(object,location,control,params){
		//first, collect the parameters from our mouse so we know what is going on
		params=params2list(params);

		if(params["left"]){ //if we are left clicking...
			//use the power bound to the left mouse button
			spawn usr.left_click_power.use();
		}else if(params["right"]){
			//if we are right clicking on a player then retrieve their description
			if(istype(object, /mob/player)){
				//have to cast the usr to a player mob, so we know that it has the right verbs
				var/mob/player/P = src.mob;
				P.show_description(object);
			}
			else{ //otherwise, use the power bound to our right button
				spawn usr.right_click_power.use();
			}
		}
	}

	Click(object,location,control,params){
		if(istype(object, /mob)){
			var/mob/player/P = src.mob;
			P.target = object;
		}
	}

	//We're redefining the core proc for movemnt, so that they will provide a moving direction
	//seperate from the aiming direction, which will be used for movement based powers
	North(){
		usr.moving_direction = NORTH;
		..();
	}

	Northeast(){
		usr.moving_direction = NORTHEAST;
		..();
	}

	East(){
		usr.moving_direction = EAST;
		..();
	}

	Southeast(){
		usr.moving_direction = SOUTHEAST;
		..();
	}

	South(){
		usr.moving_direction = SOUTH;
		..();
	}

	Southwest(){
		usr.moving_direction = SOUTHWEST;
		..();
	}

	West(){
		usr.moving_direction = WEST;
		..();
	}

	Northwest(){
		usr.moving_direction = NORTHWEST;
		..();
	}
}