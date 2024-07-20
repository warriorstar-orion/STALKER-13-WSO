#define NO_LOOT "getfucked"

GLOBAL_LIST_EMPTY(zona_anomalies)

/obj/effect/zona_anomaly
	name = "anomaly"
	desc = "A dangerous anomaly."
	icon = 'icons/stalker/obj/anomalies.dmi'
	plane = GAME_PLANE
	layer = BELOW_MOB_LAYER
	density = FALSE
	anchored = TRUE
	pass_flags = PASSTABLE | PASSMOB
	pass_flags_self = PASSMOB
	light_power = 1.5
	/// Icon state when the anomaly gets activated
	var/active_icon_state
	/// Light range when active
	var/active_light_range = 0
	/// Light power when active
	var/active_light_power = 3
	/// Light color when active
	var/active_light_color = COLOR_WHITE
	/// Idle sound, in case this anomaly has one
	var/datum/looping_sound/idle_sound
	/// Sound that plays when we flare up
	var/activation_sound
	/// Mobs currently trapped in this anomaly
	var/list/mob/living/trapped
	/// Loot this anomaly spawns when neutralized - Weighted list
	var/list/loot
	/// How much loot this anomaly spawns when neutralized
	var/loot_amount = 1
	/// How much damage this anomaly causes
	var/damage = 0
	/// Damage type we apply
	var/damage_type = BURN
	/// Armor type we check for when applying damage
	var/armor_check = ENERGY
	/// How many fire_stacks to apply to the mob
	var/fire_stacks = 0
	/// Whether or not to call fire_act() on the mob after applying damage
	var/igniting = FALSE
	/// Whether or not to gib the mob
	var/gibbing = FALSE
	/// Delay before we try to affect a mob - VERY IMPORTANT, gives player time to escape anomaly!
	var/affect_mob_delay = 0
	/// Duration of the affect cooldown, affect runs on process once the mob is trapped and gets first affected
	var/affect_cooldown_duration = 1 SECONDS
	/// Affect cooldown
	COOLDOWN_DECLARE(affect_cooldown)
	/// Whether the anomaly processes constantly or not
	var/constant_processing = FALSE

/obj/effect/zona_anomaly/Initialize()
	. = ..()
	GLOB.zona_anomalies += src
	spawn_artifact()
	var/static/list/loc_connections = list(
		COMSIG_ATOM_ENTERED = PROC_REF(on_entered),
		COMSIG_ATOM_EXITED = PROC_REF(on_exited),
	)
	AddElement(/datum/element/connect_loc, loc_connections)
	if(idle_sound)
		idle_sound = new idle_sound(src, TRUE)
	if(constant_processing)
		START_PROCESSING(SSzona_anomalies, src)

/obj/effect/zona_anomaly/Destroy(force)
	. = ..()
	GLOB.zona_anomalies -= src
	if(idle_sound)
		QDEL_NULL(idle_sound)
	STOP_PROCESSING(SSzona_anomalies, src)

/obj/effect/zona_anomaly/Moved(atom/old_loc, movement_dir, forced, list/old_locs, momentum_change)
	. = ..()
	if(!isturf(loc))
		return
	for(var/atom/movable/movable_atom in loc)
		on_entered(loc, movable_atom)

/obj/effect/zona_anomaly/process(seconds_per_tick)
	if(!COOLDOWN_FINISHED(src, affect_cooldown))
		return

	// mobs might have left
	if(!constant_processing && !length(trapped))
		return PROCESS_KILL

	COOLDOWN_START(src, affect_cooldown, affect_cooldown_duration)
	var/flared_up = FALSE
	for(var/mob/living/affected as anything in trapped)
		if(!flared_up)
			flare_up()
			flared_up = TRUE
		affect_mob(affected)
		// untrap dead mobs, we don't care about them
		if(!QDELETED(affected) && (affected.stat >= DEAD))
			untrap_mob(affected)

	// mobs might have been gibbed
	if(!constant_processing && !length(trapped))
		return PROCESS_KILL

/obj/effect/zona_anomaly/proc/spawn_artifact()
	if(!length(loot) || (loot_amount <= 0))
		return
	var/picked_loot = pick_weight(loot)
	for(var/i in 1 to loot_amount)
		if(!picked_loot || (picked_loot == NO_LOOT))
			return

		var/obj/item/loot_spawn = new picked_loot(src.loc)
		random_move_item(loot_spawn)

/obj/effect/zona_anomaly/proc/random_move_item(atom/movable/spawned)
	var/list/available_turfs = view(1, src)
	if(!length(available_turfs))
		return FALSE
	var/turf/new_turf = pick(available_turfs)
	if(!new_turf)
		return FALSE
	spawned.forceMove(new_turf)
	return TRUE

/obj/effect/zona_anomaly/proc/flare_up(flare_down_time = 1 SECONDS)
	icon_state = active_icon_state
	set_light(active_light_range, active_light_power, active_light_color)
	if(activation_sound)
		playsound(src, pick(activation_sound), vol = 80, vary = TRUE)
	if(flare_down_time)
		addtimer(CALLBACK(src, PROC_REF(flare_down)), flare_down_time)

/obj/effect/zona_anomaly/proc/flare_down()
	icon_state = initial(icon_state)
	set_light(initial(light_range), initial(light_power), initial(light_color))

/obj/effect/zona_anomaly/proc/on_entered(turf/source, atom/movable/arrived, atom/old_loc, list/atom/old_locs)
	SIGNAL_HANDLER

	if(!COOLDOWN_FINISHED(src, affect_cooldown))
		return

	if(isliving(arrived))
		prepare_affect_mob(arrived)
	else if(isitem(arrived))
		affect_item(arrived)

/obj/effect/zona_anomaly/proc/on_exited(turf/source, atom/movable/gone, direction)
	SIGNAL_HANDLER

	if(!(gone in trapped))
		return

	untrap_mob(gone)

/obj/effect/zona_anomaly/proc/trap_mob(mob/living/affected)
	if(affected in trapped)
		return
	RegisterSignal(affected, COMSIG_QDELETING, PROC_REF(trapped_mob_deleted))
	LAZYADD(trapped, affected)
	if(!constant_processing)
		START_PROCESSING(SSzona_anomalies, src)

/obj/effect/zona_anomaly/proc/untrap_mob(mob/living/affected)
	UnregisterSignal(affected, COMSIG_QDELETING)
	LAZYREMOVE(trapped, affected)
	if(!length(trapped) && !constant_processing)
		STOP_PROCESSING(SSzona_anomalies, src)

/obj/effect/zona_anomaly/proc/trapped_mob_deleted(mob/living/source)
	SIGNAL_HANDLER

	untrap_mob(source)

/obj/effect/zona_anomaly/proc/prepare_affect_mob(mob/living/affected)
	COOLDOWN_START(src, affect_cooldown, affect_cooldown_duration)
	trap_mob(affected)
	flare_up()
	addtimer(CALLBACK(src, PROC_REF(affect_mob), affected), affect_mob_delay)

/obj/effect/zona_anomaly/proc/affect_mob(mob/living/affected, first_affect = FALSE)
	fuck_mob_up(affected, first_affect)

/obj/effect/zona_anomaly/proc/fuck_mob_up(mob/living/affected, first_affect = FALSE)
	//mob managed to escape
	if(!(affected in trapped))
		return
	//simplemobs always get gibbed
	if(isanimal(affected))
		affected.gib()
		return

	if(damage && damage_type)
		var/armor_affected = (armor_check ? affected.getarmor(type = armor_check) : null)
		affected.apply_damage(damage, damage_type, blocked = armor_affected)
	if(fire_stacks)
		affected.adjust_fire_stacks(fire_stacks)
	if(igniting)
		affected.ignite_mob()
	if(gibbing)
		var/list/equipped_items = list()
		equipped_items |= affected.get_equipped_items(TRUE)
		equipped_items |= affected.held_items
		//throw the guys items around, strip his ass naked lol
		for(var/obj/item/equipped_item in equipped_items)
			random_move_item(equipped_item)
		//bye bye
		affected.gib()
	return TRUE

/obj/effect/zona_anomaly/proc/affect_item(obj/item/affected)
	//ignore artifacts lol
	if(istype(affected, /obj/item/artifact))
		return
	flare_up()
	addtimer(CALLBACK(src, PROC_REF(melt_item), affected), 1 SECONDS)
	COOLDOWN_START(src, affect_cooldown, affect_cooldown_duration)

/obj/effect/zona_anomaly/proc/melt_item(obj/item/affected)
	//cant be melted
	if(affected.resistance_flags & UNACIDABLE|ACID_PROOF)
		return

	var/obj/effect/decal/cleanable/molten_object/molten_item = new /obj/effect/decal/cleanable/molten_object(affected.loc)
	molten_item.desc = "Looks like this was \a [affected] some time ago."
	qdel(affected)
