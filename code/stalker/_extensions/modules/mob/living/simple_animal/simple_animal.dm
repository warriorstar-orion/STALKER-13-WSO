/mob/living/simple_animal
	var/list/idle_sounds = list()
	//Healable by medical stacks? Defaults to yes.
	var/healable = 1

/mob/living/simple_animal/proc/handle_automated_sounds()
	if(idle_sounds)
		if(rand(0,200) < speak_chance)
			var/s = pick(idle_sounds)
			playsound(src, s, 65, 1)
