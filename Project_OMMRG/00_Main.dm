/*	 Project OMMRG							*
 *	Comment style bitches :)				*
 *											*/

#define DEBUG 1

world
{
	fps = 30		// 25 frames per second
	icon_size = 32	// 32x32 icon size by default

	view = 6		// show up to 6 tiles outward from center (13x13 view)

	mob = /mob/player;

	/var/list/logs[0];

	map_format = TOPDOWN_MAP;
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
		params=params2list(params);
		if(params["left"]) spawn usr.left_click_power.use();
		else if(params["right"]) spawn usr.right_click_power.use();
	}

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