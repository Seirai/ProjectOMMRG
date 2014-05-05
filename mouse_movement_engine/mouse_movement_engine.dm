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
	grass_dirt_top_tile
		icon = 'gfx/top_grassdirt.dmi'
	grass_dirt_topleft_tile
		icon = 'gfx/topleft_grassdirt.dmi'
	grass_dirt_right_tile
		icon = 'gfx/right_grassdirt.dmi'
	grass_dirt_topright_tile
		icon = 'gfx/topright_grassdirt.dmi'
	grass_dirt_bottomright_tile
		icon = 'gfx/bottomright_grassdirt.dmi'
	grass_dirt_bottomleft_tile
		icon = 'gfx/bottomleft_grassdirt.dmi'
	grass_dirt_bottom_tile
		icon = 'gfx/bottom_grassdirt.dmi'

var
	mouseX
	mouseY