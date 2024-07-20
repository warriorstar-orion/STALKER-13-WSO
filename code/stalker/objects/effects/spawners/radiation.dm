/obj/effect/abstract/radiation // Only does rad damage
	name = "radiation"
	icon = 'icons/stalker/effects/radiation.dmi'
	icon_state = "rad"
	invisibility = INVISIBILITY_ABSTRACT
	resistance_flags = UNACIDABLE
	density = FALSE
	anchored = TRUE
	/// Cooldown between pulses
	var/radiation_cooldown_duration = 2 SECONDS
	/// Range of rads per pulse
	var/radiation_range = 0
	/// Threshold of radiation pulse
	var/radiation_threshold = RAD_MEDIUM_INSULATION
	/// Chance of irradiating per pulse
	var/radiation_chance = 75
	/// Amount of rads to inflict per pulse
	var/radiation_rads = 0
	/// Minimum exposure time before affecting movables inside turf
	var/radiation_minimum_exposure_time = 0

/obj/effect/abstract/radiation/Initialize(mapload)
	. = ..()
	return INITIALIZE_HINT_LATELOAD

/obj/effect/abstract/radiation/LateInitialize()
	. = ..()
	var/static/list/loc_connections = list(
		COMSIG_ATOM_ENTERED = PROC_REF(on_entered),
		COMSIG_ATOM_EXITED = PROC_REF(on_exited),
	)
	AddElement(/datum/element/connect_loc, loc_connections)
	try_irradiate()

/obj/effect/abstract/radiation/proc/on_entered(turf/source, atom/movable/arrived, atom/old_loc, list/atom/old_locs)
	SIGNAL_HANDLER

	try_irradiate(source)

/obj/effect/abstract/radiation/proc/on_exited(turf/source, atom/movable/gone, direction)
	SIGNAL_HANDLER

	try_stop_irradiate(source)

/obj/effect/abstract/radiation/proc/try_irradiate(turf/source)
	var/valid_target = FALSE
	for(var/atom/movable/movable as anything in source)
		if(CAN_IRRADIATE(movable))
			valid_target = TRUE
	if(valid_target)
		AddComponent(/datum/component/radioactive_emitter, \
					cooldown_time = radiation_cooldown_duration, \
					range = radiation_range, \
					threshold = radiation_threshold, \
					rads = radiation_rads, \
					chance = radiation_chance, \
					minimum_exposure_time = radiation_minimum_exposure_time)

/obj/effect/abstract/radiation/proc/try_stop_irradiate(turf/source)
	var/valid_target = FALSE
	for(var/atom/movable/movable as anything in source)
		if(CAN_IRRADIATE(movable))
			valid_target = TRUE
	if(!valid_target)
		qdel(GetComponent(/datum/component/radioactive_emitter))

/obj/effect/abstract/radiation/low
	radiation_rads = 15
	icon_state = "rad_low"

/obj/effect/abstract/radiation/medium
	radiation_rads = 25
	icon_state = "rad_medium"

/obj/effect/abstract/radiation/high
	radiation_rads = 50
	icon_state = "rad_high"
