obj{
	/*
		Powers is a super generic template for all "abilities" in game.
		Basically the user doesn't care WHAT the power does, all they need to know is
		that they press a button and the power associated with that button will be used.

		This is handled by having all powers have a "use" verb, which is what players and
		other mobs interact with.  They aren't concerned with the details of HOW the power
		works, they just know they press "use" and the power is used.

		In other words, it's up to the power itself to determine how it works, and new powers are
		basically just objects that get used and have differently defined variables.
	*/
	powers{
		//Put values that ALL powers should have here


		//Verbs that ALL powers will have access to
		verb{
			//A super generic use verb, which individual powers will have custom variations of
			use(){
				set src in usr;
			}
		}

		//Procs for ALL powers
		proc{

			//fire projectile
			//creates a projectile, assigns it some values based on the creator, and gives it
			//an expiration
			//input: creator, range, projectile type (in future)
			//output: none

			FireProjectile(mob/creator as mob, range as num){
				//Still a little hardcoded
				var/obj/projectile/B = new /obj/projectile;
				B.range = range;
				B.icon = 'fireball.dmi';

				var/matrix/M = matrix();
				M.Turn(creator.angle);
				B.angle = creator.angle;
				B.transform = M;

				var/icon/I = icon(creator.icon);

				var/w = I.Width();
				var/h = I.Height();

				B.Move(creator.loc,0,creator.step_x + (w/2),creator.step_y + (h/2));
			}
		}

		//A template for ranged powers
		range{
			var{
				range = 10;
			}


			//A very very basic example of how a power might work
			sample_power{
				use(){
					FireProjectile(usr, range);
				}
			}
		}

		//A template for movement powers
		movement{

			dash{
				use(){
					usr.icon_state = "dash";
					var/turf/current = get_step(usr,usr.moving_direction);
					current = get_step(current,usr.moving_direction);
					current = get_step(current,usr.moving_direction);
					current = get_step(current,usr.moving_direction);
					current = get_step(current,usr.moving_direction);
					current = get_step(current,usr.moving_direction);
					current = get_step(current,usr.moving_direction);
					current = get_step(current,usr.moving_direction);

					walk_to(usr,current,0,0,32);
					sleep(5);
					usr.icon_state = "walk";
				}
			}
		}
	}
}