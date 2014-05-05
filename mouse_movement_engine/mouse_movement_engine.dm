/*
	These are simple defaults for your project.

	This will just be used as a sample to show the movement controls that are possible for our game.

 */

world
	fps = 30		// 25 frames per second
	icon_size = 32	// 32x32 icon size by default

	view = 6		// show up to 6 tiles outward from center (13x13 view)


// Make objects move 8 pixels per tick when walking

mob
	step_size = 8
	icon = 'gfx/char_test.dmi'
	icon_state = "walk"

obj
	step_size = 8
turf
	dirt_tile
		icon = 'gfx/dirt_tile.dmi'
	grass_tile
		icon = 'gfx/grass_tile.dmi'
	grass_dirt_left_tile
		icon = 'gfx/left_grassdirt.dmi'

var
	mouseX
	mouseY