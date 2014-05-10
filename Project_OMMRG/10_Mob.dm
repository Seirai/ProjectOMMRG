
mob
{
/*	Variable Definition	*/

	var
	{

	//	--01_MovementVars--
		paramlist; //This holds parameters from the MouseMove() proc for the mob.
		mouseX; //Mouse x/y coordinate holders.
		mouseY;
		theta; //Mob angle
		quadrant; //The quadrant for the mob angle to face
		controlscheme; //Boolean value for which control scheme the user wants.
		mouse_turf as turf; //the turf that the mouse is on, used to help determin direction
		angle as num;
		list/obj/powers/power_inventory as obj;  //all the powers the user has
		obj/powers/left_click_power as obj; //the power currently bound to the left click
		obj/powers/right_click_power as obj; //the power currently bound to the right click
		moving_direction = NORTH;  //the direction of movement instead of the direction of aiming
	}

/*	End Definition		*/
/*	Login Proc			*/

	Login()
	{
		..();
		//input("Select movement system:", "Enter in 1 for the new system, enter 0 for the old.", usr.controlscheme);
	}

/*	End Login			*/

/*	Icon Definition: */

	icon = 'gfx/char_test.dmi';
	icon_state = "walk";

/*	Definition End	*/

/*	Mob Verbs Definition: */


	verb
	{
		mobStuff()

		//swap_icon
		//take in the name of an icon, swap to it
		//input: T as text
		//output: none
		swap_icon(T as icon){
			usr.icon = T;
			usr.icon_state = "walk";
		}

		//test verb for projectiles, may or may not keep
		shoot(){

		}

//	Other verbs here.
	}
	//All the automated housekeeping stuff here.
	New(){
		..()
	}

	proc{
		SetDirection(){
			//note to self: remove magic numbers
			if(337.5 < usr.angle || usr.angle <= 22.5) usr.dir = EAST;
			else if(22.5 < usr.angle && usr.angle <= 67.5) usr.dir = SOUTHEAST;
			else if(67.5 < usr.angle && usr.angle <= 112.5) usr.dir = SOUTH;
			else if(112.5 < usr.angle && usr.angle <= 157.5) usr.dir = SOUTHWEST;
			else if(157.5 < usr.angle && usr.angle <= 202.5) usr.dir = WEST;
			else if(202.5 < usr.angle && usr.angle <= 247.5) usr.dir = NORTHWEST;
			else if(247.5 < usr.angle && usr.angle <= 292.5) usr.dir = NORTH;
			else if(292.5 < usr.angle && usr.angle <= 337.5) usr.dir = NORTHEAST;
		}
	}


}