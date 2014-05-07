obj{

	var{
		angle as num;
	}

	projectile{

		New(){
			bound_width = 4;
			bound_height = 4;

			spawn while(src){
				sleep(0.01);

				var/mod_x = cos(-src.angle) * 2;
				var/mod_y = sin(-src.angle) * 2;

				src.Move(locate(src.x,src.y,src.z), 0, src.step_x + step_size * mod_x, src.step_y + step_size * mod_y);
			}
		}

	}

}