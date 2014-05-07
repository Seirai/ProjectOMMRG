
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
	}

/*	End Definition		*/
/*	Login Proc			*/

	Login()
	{
		..();
		input("Select movement system:", "Enter in 1 for the new system, enter 0 for the old.", usr.controlscheme);
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
			spawn client.North();
		}
		moveLeft()
		{
			set hidden = 1;
			spawn client.West();
		}
		moveDown()
		{
			set hidden = 1;
			spawn client.South();
		}
		moveRight()
		{
			set hidden = 1;
			spawn client.East();
		}

		//roleplay
		//take in some html text and spew it out into the output box
		//input: M as message
		//output: none
		//to-do: save messages into log system
		roleplay(M as message){
			M = "<font color=red>" + M + "\n([usr.key])";
			view() << M;
		}

//	Other verbs here.
	}
	//All the automated housekeeping stuff here.
	New(){
		..()
		spawn while(usr){
			sleep(0.01);
			//rotateToTarget(); //this is a joke, btw.
			if(mouse_turf != null) usr.dir = get_dir(usr, mouse_turf);
		}
	}
}