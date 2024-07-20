GLOBAL_LIST_EMPTY(blowout_spawners)

/obj/effect/abstract/blowout_spawner
	name = "blowout spawner"
	icon = 'icons/stalker/effects/spawners.dmi'
	icon_state = "blowout"
	var/spawn_range = 3
	var/mob_types = list(/mob/living/basic/carp)
	var/max_mobs = 5
	var/list/spawned_mobs = list()
	var/list/traits = list(TRAIT_BLOWOUT_IMMUNE)

/obj/effect/abstract/blowout_spawner/Initialize()
	. = ..()
	GLOB.blowout_spawners += src
	spawn_mobs()

/obj/effect/abstract/blowout_spawner/Destroy()
	. = ..()
	GLOB.blowout_spawners -= src

/obj/effect/abstract/blowout_spawner/proc/heal_mobs()
	for(var/mob/living/our_mob as anything in spawned_mobs)
		our_mob.revive(HEAL_ALL)

/obj/effect/abstract/blowout_spawner/proc/spawn_mobs()
	var/list/possible_tiles = range(spawn_range, src)
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
		for(var/trait in traits)
			ADD_TRAIT(spawned_mob, trait, SPAWNER_TRAIT)
		RegisterSignal(spawned_mob, COMSIG_QDELETING, PROC_REF(remove_mob_from_list))

/obj/effect/abstract/blowout_spawner/proc/remove_mob_from_list(mob/source)
	SIGNAL_HANDLER

	spawned_mobs -= source
