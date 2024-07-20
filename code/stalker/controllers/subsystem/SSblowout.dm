SUBSYSTEM_DEF(blowouts)
	name = "Blowouts"
	wait = 2 SECONDS
	flags = SS_NO_INIT
	priority = FIRE_PRIORITY_BLOWOUTS
	runlevels = RUNLEVEL_GAME
	/// Amount of blowouts we have had so far
	var/blowout_count = 0
	/// Phase of current blowout
	var/blowout_stage = 0
	/// Current blowout cooldown
	COOLDOWN_DECLARE(cooldown)
	/// Minimum blowout cooldown duration
	var/cooldown_duration_min = 30 MINUTES
	/// Maximum blowout cooldown duration
	var/cooldown_duration_max = 60 MINUTES
	/// Start time of the last blowout
	var/start_time = 0
	/// Mobs that can be affected by blowout right now
	var/list/blowout_affected_mobs = list()

	var/static/list/ambient_sounds = list(
		'sound/stalker/blowout/blowout_ambient_01.ogg',
		'sound/stalker/blowout/blowout_ambient_02.ogg',
		'sound/stalker/blowout/blowout_ambient_03.ogg',
		'sound/stalker/blowout/blowout_ambient_04.ogg',
		'sound/stalker/blowout/blowout_ambient_05.ogg',
		'sound/stalker/blowout/blowout_ambient_06.ogg',
		'sound/stalker/blowout/blowout_ambient_07.ogg',
		'sound/stalker/blowout/blowout_ambient_08.ogg',
	)
	var/static/list/rumble_sounds = list(
		'sound/stalker/blowout/blowout_ambient_rumble_01.ogg',
		'sound/stalker/blowout/blowout_ambient_rumble_02.ogg',
		'sound/stalker/blowout/blowout_ambient_rumble_03.ogg',
		'sound/stalker/blowout/blowout_ambient_rumble_04.ogg',
	)
	var/static/list/wave_sounds = list(
		'sound/stalker/blowout/blowout_wave_01.ogg',
		'sound/stalker/blowout/blowout_wave_02.ogg',
		'sound/stalker/blowout/blowout_wave_03.ogg',
	)
	var/static/list/boom_sounds = list(
		'sound/stalker/blowout/blowout_boom_01.ogg',
		'sound/stalker/blowout/blowout_boom_02.ogg',
		'sound/stalker/blowout/blowout_boom_03.ogg',
	)
	var/static/list/lightning_sounds = list(
		'sound/stalker/blowout/blowout_lightning_01.ogg',
		'sound/stalker/blowout/blowout_lightning_02.ogg',
		'sound/stalker/blowout/blowout_lightning_03.ogg',
		'sound/stalker/blowout/blowout_lightning_04.ogg',
		'sound/stalker/blowout/blowout_lightning_05.ogg',
		'sound/stalker/blowout/blowout_flare_01.ogg',
		'sound/stalker/blowout/blowout_flare_02.ogg',
		'sound/stalker/blowout/blowout_flare_03.ogg',
		'sound/stalker/blowout/blowout_flare_04.ogg',
	)
	var/static/list/wind_sounds = list(
		'sound/stalker/blowout/blowout_wind_01.ogg',
		'sound/stalker/blowout/blowout_wind_02.ogg',
		'sound/stalker/blowout/blowout_wind_03.ogg',
	)

/datum/controller/subsystem/blowouts/fire(resumed)
	if(!COOLDOWN_FINISHED(src, cooldown))
		return

	if(blowout_stage <= 0)
		start_blowout()
		return

	blowout_sounds()

	if(world.time - start_time >= BLOWOUT_TIME_STAGE_3)
		blowout_stage = 0
		end_blowout()
	else if(world.time - start_time >= BLOWOUT_TIME_STAGE_2)
		if(blowout_stage >= 3)
			return
		blowout_stage = 3
		blowout_refresh()
		blowout_affect_mobs()
		blowout_clean()
	else if(world.time - start_time >=  BLOWOUT_TIME_STAGE_1)
		if(blowout_stage >= 2)
			return
		blowout_stage = 2
		blowout_wave()

/datum/controller/subsystem/blowouts/proc/start_blowout()
	start_time = world.time
	blowout_stage = 1

	send_blowout_sound(sound('sound/stalker/blowout/blowout_begin_02.ogg', channel = CHANNEL_BLOWOUT_IMPACT, volume = 50))
	send_blowout_sound(sound('sound/stalker/blowout/blowout_siren.ogg', channel = CHANNEL_BLOWOUT_SIREN, volume = 60))

	var/list/listeners = list()
	var/list/valid_z_levels = SSmapping.levels_by_trait(ZTRAIT_BLOWOUTS)
	for(var/valid_z in valid_z_levels)
		listeners += SSmobs.clients_by_zlevel[valid_z]
	for(var/mob/listener as anything in listeners)
		if(HAS_TRAIT(listener, TRAIT_BLOWOUT_SUSCEPTIBLE))
			to_chat(listener, span_danger(span_big("You need to look for shelter, the emission will begin soon!")))
		else
			to_chat(listener, span_notice(span_big("You are in cover, you should stay in there until the emission is over.")))

	SEND_SIGNAL(src, COMSIG_BLOWOUT_START)

/datum/controller/subsystem/blowouts/proc/blowout_wave()
	send_blowout_sound(sound('sound/stalker/blowout/blowout_particle_wave.ogg', channel = CHANNEL_BLOWOUT_IMPACT, volume = 70))

/datum/controller/subsystem/blowouts/proc/blowout_clean()
	SEND_SIGNAL(src, COMSIG_BLOWOUT_CLEAN)

/datum/controller/subsystem/blowouts/proc/blowout_affect_mobs()
	for(var/mob/living/blowie as anything in blowout_affected_mobs)
		if(HAS_TRAIT(blowie, TRAIT_BLOWOUT_IMMUNE) || (blowie.status_flags & GODMODE))
			continue
		if(ishuman(blowie))
			var/mob/living/carbon/human/zomboid = blowie
			to_chat(zomboid, span_userdanger(span_big("You have succumbed to the zone!")))
			/* implement the stupid god damn mobs later, they might be refactored into basic mobs maybe
			var/mob/living/new_zombie = new /mob/living/simple_animal/hostile/mutant/zombiesimp(zomboid.loc)
			ADD_TRAIT(new_zombie, TRAIT_BLOWOUT_IMMUNE, INNATE_TRAIT)
			*/
			zomboid.ghostize(FALSE)
			zomboid.unequip_everything()
			qdel(zomboid)
		else
			blowie.gib()
		CHECK_TICK

/datum/controller/subsystem/blowouts/proc/blowout_refresh()
	send_blowout_sound(sound('sound/stalker/blowout/blowout_impact_02.ogg', channel = CHANNEL_BLOWOUT_IMPACT, volume = 70))
	send_blowout_sound(sound('sound/stalker/blowout/blowout_outro.ogg', channel = CHANNEL_BLOWOUT_SIREN, volume = 70))

	for(var/obj/item/artifact/artifact as anything in GLOB.zona_artifacts)
		if(!artifact.has_been_picked)
			qdel(artifact)
		CHECK_TICK

	for(var/obj/effect/zona_anomaly/anomaly as anything in GLOB.zona_anomalies)
		anomaly.spawn_artifact()
		CHECK_TICK

	for(var/obj/effect/abstract/blowout_spawner/spawner as anything in GLOB.blowout_spawners)
		spawner.heal_mobs()
		spawner.spawn_mobs()
		CHECK_TICK

	for(var/datum/job/job as anything in SSjob.joinable_occupations)
		job.total_positions = initial(job.total_positions)

	/* NOT IMPLEMENTED YET
	for(var/obj/machinery/stalker/sidorpoint/sidorpoint as anything in GLOB.cps)
		sidorpoint.SendJobTotalPositions()
		CHECK_TICK

	for(var/obj/structure/stalker/cacheable/cache as anything in GLOB.stalker_caches)
		if(cache.internal_cache)
			qdel(cache.internal_cache)
		cache.internal_cache = null
		cache.cache_chance = rand(3, 7)
		cache.RefreshContents()
		CHECK_TICK
	*/

/datum/controller/subsystem/blowouts/proc/end_blowout()
	//silence blowout sounds for everyone, no need to account for z
	SEND_SOUND(world, sound(null, channel = CHANNEL_BLOWOUT_AMBIENT))
	SEND_SOUND(world, sound(null, channel = CHANNEL_BLOWOUT_WAVE))
	SEND_SOUND(world, sound(null, channel = CHANNEL_BLOWOUT_WIND))
	SEND_SOUND(world, sound(null, channel = CHANNEL_BLOWOUT_RUMBLE))
	SEND_SOUND(world, sound(null, channel = CHANNEL_BLOWOUT_BOOM))
	SEND_SOUND(world, sound(null, channel = CHANNEL_BLOWOUT_LIGHTING))
	SEND_SOUND(world, sound(null, channel = CHANNEL_BLOWOUT_IMPACT))
	SEND_SOUND(world, sound(null, channel = CHANNEL_BLOWOUT_SIREN))

	var/cooldown_amount = rand(cooldown_duration_min, cooldown_duration_max)
	COOLDOWN_START(src, cooldown, cooldown_amount)

/datum/controller/subsystem/blowouts/proc/blowout_sounds()
	for(var/mob/living/blowie in blowout_affected_mobs)
		switch(blowout_stage)
			if(1)
				shake_camera(blowie, 0.1 SECONDS, 1)
			if(2)
				shake_camera(blowie, 0.2 SECONDS, 1)
			if(3)
				shake_camera(blowie, 1 SECONDS, 1)

	if(prob(20))
		send_blowout_sound(sound(pick(ambient_sounds), channel = CHANNEL_BLOWOUT_AMBIENT, volume = 70))

	if(prob(30))
		send_blowout_sound(sound(pick(wave_sounds), channel = CHANNEL_BLOWOUT_WAVE, volume = 70))

	if(prob(20))
		send_blowout_sound(sound(pick(wind_sounds), channel = CHANNEL_BLOWOUT_WIND, volume = 70))

	if(prob(30))
		send_blowout_sound(sound(pick(rumble_sounds), channel = CHANNEL_BLOWOUT_RUMBLE, volume = 70))

	if(prob(50))
		send_blowout_sound(sound(pick(boom_sounds), channel = CHANNEL_BLOWOUT_BOOM, volume = 70))

	if(prob(50))
		send_blowout_sound(sound(pick(lightning_sounds), channel = CHANNEL_BLOWOUT_LIGHTING, volume = 70))

/datum/controller/subsystem/blowouts/proc/send_blowout_sound(sound/sent)
	var/list/listeners = list()
	var/list/valid_z_levels = SSmapping.levels_by_trait(ZTRAIT_BLOWOUTS)
	for(var/valid_z in valid_z_levels)
		listeners += SSmobs.clients_by_zlevel[valid_z]
	for(var/mob/listener in listeners)
		SEND_SOUND(listener, sent)
