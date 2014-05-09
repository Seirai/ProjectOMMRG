obj{

	var{
		angle as num;
	}

	projectile{

		var{
			range as num;
		}

		New(){
			bound_width = 4;
			bound_height = 4;

			var/creation_time = world.time;

			spawn while(src){
				sleep(0.01);

				if(world.time > creation_time + range) del(src)

				var/mod_x = cos(-src.angle) * 2;
				var/mod_y = sin(-src.angle) * 2;

				src.Move(locate(src.x,src.y,src.z), 0, src.step_x + step_size * mod_x, src.step_y + step_size * mod_y);
			}
		}

	}

}