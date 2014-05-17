obj{
	effects{
		verb{
			applyEffect(){
			}
		}

		var{
			creator as mob;
			range as num;
		}


		damage_projectile{

			var{
				damage as num;
			}

			bound_width = 10;
			bound_height = 10;

			New(){

				var/creation_time = world.time;


				spawn while(src){
					sleep(0.01);

					if(world.time > creation_time + range) del(src)

					var/mod_x = cos(-src.angle) * 2;
					var/mod_y = sin(-src.angle) * 2;

					src.Move(locate(src.x,src.y,src.z), 0, src.step_x + step_size * mod_x, src.step_y + step_size * mod_y);
				}
			}

			applyEffect(mob/M){
				if(M != creator){
					if(VERBOSE) view() << "Dealing damage to [M] for [creator]!";
					M.vitality -= damage;
					del(src);
				}
			}

		}
	}
}