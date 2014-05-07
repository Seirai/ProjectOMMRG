
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

		moveUp()
		{
			set hidden = 1;
		}
		moveLeft()
		{
			set hidden = 1;
		}
		moveDown()
		{
			set hidden = 1;
		}
		moveRight()
		{
			set hidden = 1;
		}*/

//	Other verbs here.
	}
}