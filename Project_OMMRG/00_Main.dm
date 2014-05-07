/*	 Project OMMRG							*
 *	Comment style bitches :)				*
 *											*/

#define DEBUG 1

world
{
	fps = 30		// 25 frames per second
	icon_size = 32	// 32x32 icon size by default

	view = 6		// show up to 6 tiles outward from center (13x13 view)
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
}