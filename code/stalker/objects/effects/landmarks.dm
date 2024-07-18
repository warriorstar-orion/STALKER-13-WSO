GLOBAL_LIST_EMPTY(blowout_spawners)

/obj/effect/landmark/blowout_spawner
	name = "blowout spawner"
	var/spawn_range = 3
	var/mob_types = list()
	var/max_mobs = 5
	faction = list("mining")
	var/list/spawned_mobs = list()

/obj/effect/landmark/blowout_spawner/Initialize()
	. = ..()
	GLOB.blowout_spawners += src
	spawn_mobs()

/obj/effect/landmark/blowout_spawner/Destroy()
	. = ..()
	GLOB.blowout_spawners -= src

/obj/effect/landmark/blowout_spawner/proc/heal_mobs()
	for(var/mob/living/our_mob as anything in spawned_mobs)
		our_mob.revive(TRUE)

/obj/effect/landmark/blowout_spawner/proc/spawn_mobs()
	var/list/possible_tiles = view(spawn_range, src)
	for(var/turf/closed/closed_turf as anything in possible_tiles)
		possible_tiles -= closed_turf
	if(!length(possible_tiles))
		possible_tiles |= get_turf(src)
	var/current_mob_amount = length(spawned_mobs)
	var/picked_tile
	var/mob_type
	var/mob/living/spawned_mob
	for(var/i in 1 to (max_mobs - current_mob_amount))
		picked_tile = pick(possible_tiles)
		mob_type = pick(mob_types)
		spawned_mob = new mob_type(picked_tile)
		spawned_mob.faction = faction.Copy()
		spawned_mobs += spawned_mob
		RegisterSignal(spawned_mob, COMSIG_PARENT_QDELETING, PROC_REF(remove_mob_from_list))

/obj/effect/landmark/blowout_spawner/proc/remove_mob_from_list(mob/source)
	spawned_mobs -= source

/obj/effect/landmark/blowout_spawner/flesh
	max_mobs = 4
	mob_types = list(/mob/living/simple_animal/hostile/mutant/flesh)
	faction = list("stalker_mutants1", "monolith_forces")

/obj/effect/landmark/blowout_spawner/boar
	max_mobs = 3
	mob_types = list(/mob/living/simple_animal/hostile/mutant/boar)
	faction = list("stalker_mutants1", "monolith_forces")

/obj/effect/landmark/blowout_spawner/snork
	max_mobs = 3
	mob_types = list(/mob/living/simple_animal/hostile/mutant/snork)
	faction = list("stalker_mutants1", "monolith_forces")

/obj/effect/landmark/blowout_spawner/dog
	max_mobs = 4
	mob_types = list(/mob/living/simple_animal/hostile/mutant/dog)
	faction = list("stalker_mutants1", "monolith_forces")

/obj/effect/landmark/blowout_spawner/pseudo
	max_mobs = 2
	mob_types = list(/mob/living/simple_animal/hostile/mutant/pseudog)
	faction = list("stalker_mutants1", "monolith_forces")

/obj/effect/landmark/blowout_spawner/bloodsucker
	max_mobs = 2
	mob_types = list(/mob/living/simple_animal/hostile/mutant/bloodsucker)
	faction = list("stalker_mutants1", "monolith_forces")

/obj/effect/landmark/blowout_spawner/controller
	max_mobs = 1
	mob_types = list(/mob/living/simple_animal/hostile/mutant/controller)
	faction = list("stalker_mutants1", "monolith_forces")

/obj/effect/landmark/blowout_spawner/zombiesimp
	max_mobs = 5
	mob_types = list(/mob/living/simple_animal/hostile/mutant/zombiesimp,/mob/living/simple_animal/hostile/mutant/zombiesimp/ranged)
	faction = list("stalker_mutants1", "monolith_forces")

/obj/effect/landmark/blowout_spawner/allmutants
	max_mobs = 4
	mob_types = list(/mob/living/simple_animal/hostile/mutant/zombiesimp,/mob/living/simple_animal/hostile/mutant/zombiesimp/ranged,/mob/living/simple_animal/hostile/mutant/rat,/mob/living/simple_animal/hostile/mutant/flesh,/mob/living/simple_animal/hostile/mutant/boar,/mob/living/simple_animal/hostile/mutant/snork,/mob/living/simple_animal/hostile/mutant/bloodsucker)
	faction = list("stalker_mutants1", "monolith_forces")
