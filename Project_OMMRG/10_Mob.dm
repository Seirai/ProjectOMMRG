
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
			var/obj/projectile/B = new /obj/projectile;
			B.icon = 'fireball.dmi';

			var/matrix/M = matrix();
			M.Turn(usr.angle);
			B.angle = usr.angle;
			B.transform = M;

			var/icon/I = icon(usr.icon);

			var/w = I.Width();
			var/h = I.Height();

			B.Move(usr.loc,0,usr.step_x + (w/2),usr.step_y + (h/2));
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

	player{
		icon = 'gfx/dgrayman.dmi';

		overlays = newlist();

		var{
			rping = 0;
		}

		New(){
			..()
			var/icon/I = icon(usr.icon);
			usr.bound_width = I.Width();
			usr.bound_height = I.Height();

			spawn while(usr){
				sleep(0.01);
				//rotateToTarget(); //this is a joke, btw.
				//if(mouse_turf != null) usr.dir = get_dir(usr, mouse_turf);
				usr.SetDirection();
			}
		}

		verb{

			// This segment is affiliated with movement! --01_Movement.dm--
			/*
			w return "moveUp"
			a return "moveLeft"
			s return "moveDown"
			d return "moveRight"
			*/

			//Each of these basically call the same proc as the arrow keys.
			moveUp()
			{
				set hidden = 1;
				client.North();
			}
			moveLeft()
			{
				set hidden = 1;
				client.West();
			}
			moveDown()
			{
				set hidden = 1;
				client.South();
			}
			moveRight()
			{
				set hidden = 1;
				client.East();
			}

			//roleplay
			//take in some html text and spew it out into the output box
			//input: M as message
			//output: none
			//to-do: save messages into log system
			roleplay(){
				src.rping = 1;
				src.overlays.Add(icon('rp_indicator.dmi'));
				var/M = input(src,"Type your roleplay here (HTML enabled).") as message;
				if(M != ""){
					M = "<font color=red face=garamond><b>" + M + "\n([usr.name])</font></b>";
					logs[src.key] += (M);
					view() << M;
				}
				src.rping = 0;
				src.overlays.Remove(icon('rp_indicator.dmi'));
			}

			show_logs(){
				var/review = input(src, "Pick log to read") in logs;
				usr << logs[review];
			}
		}
	}
}