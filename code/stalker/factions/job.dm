/datum/job/stalker
	var/faction_spawner = /obj/effect/landmark/stalker/loners/loner

/datum/job/stalker/get_latejoin_spawn_point()
	if(length(GLOB.stalker_faction_spawners[title]))
		return pick(GLOB.stalker_faction_spawners[title])

	return ..()

/datum/job/stalker/get_default_roundstart_spawn_point()
	if(length(GLOB.stalker_faction_spawners[title]))
		return pick(GLOB.stalker_faction_spawners[title])

	return ..()
