mob{
	player{
		icon = 'gfx/dgrayman.dmi';

		overlays = newlist();

		var{
			rping = 0;
			description as message;
		}

		New(){
			..()
			left_click_power = new /obj/powers/range/sample_power; //when initializing, put the power here
			right_click_power = new /obj/powers/movement/dash;
			vitality = 10;

			spawn while(usr){
				sleep(0.01);
				//rotateToTarget(); //this is a joke, btw.
				//if(mouse_turf != null) usr.dir = get_dir(usr, mouse_turf);
				usr.SetDirection();
				usr.CycleThroughPassives()
			}
		}

		proc{
			//fix html
			//Do some user frienly html cleanibg, parsing line breaks in <br>, adding <html>
			//to the beginning and </html> tot he end
			//input: message M to transform
			//output: return fixed message R
			FixHTML(M as message){
				var/R = "<html>";
				R += M;
				R += "</html>";
				R = dd_replacetext(R, "\n", "<br>");
				return R;
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
			moveUp(){
				set hidden = 1;
				client.North();
			}
			moveLeft(){
				set hidden = 1;
				client.West();
			}
			moveDown(){
				set hidden = 1;
				client.South();
			}
			moveRight(){
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

			//Sample of how logs can work
			show_logs(){
				var/review = input(src, "Pick log to read") in logs;
				usr << logs[review];
			}

			//show description
			//Display descriptions in their own window
			//input: target player P
			//output: none
			show_description(mob/player/P as mob){
				set hidden = 1;
				var/display = "<title>[P]'s Description</title>" + FixHTML(P.description);
				usr << browse(display, "window=description;display=1;size=600x800;border=0;can_close=1 can_resize=1;can_minimize=1;titlebar=1" );
			}

			//set description
			//sets your description as an html message
			//input: none
			//output: none
			set_description(){
				description = input("Set your description with html.","Set Direction", description) as message;
			}
		}
	}
}