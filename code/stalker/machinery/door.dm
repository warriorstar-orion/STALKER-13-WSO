// Airlock filler ported from Paradise
/obj/airlock_filler_object
	name = "airlock fluff"
	desc = "You shouldn't be able to see this fluff!"
	icon = null
	icon_state = null
	density = TRUE
	opacity = TRUE
	anchored = TRUE
	invisibility = INVISIBILITY_MAXIMUM
	//atmos_canpass = CANPASS_DENSITY
	/// The door/airlock this fluff panel is attached to
	var/obj/machinery/door/filled_airlock

/obj/airlock_filler_object/Bumped(atom/A)
	if(isnull(filled_airlock))
		stack_trace("Someone bumped into an airlock filler with no parent airlock specified!")
	return filled_airlock.Bumped(A)

/obj/airlock_filler_object/Destroy()
	filled_airlock = null
	return ..()

/// Multi-tile airlocks pair with a filler panel, if one goes so does the other.
/obj/airlock_filler_object/proc/pair_airlock(obj/machinery/door/parent_airlock)
	if(isnull(parent_airlock))
		stack_trace("Attempted to pair an airlock filler with no parent airlock specified!")

	filled_airlock = parent_airlock
	RegisterSignal(filled_airlock, PROC_REF(no_airlock))

/obj/airlock_filler_object/proc/no_airlock()
	UnregisterSignal(filled_airlock)
	qdel(src)

/// Multi-tile airlocks (using a filler panel) have special handling for movables with PASS_FLAG_GLASS
/obj/airlock_filler_object/CanPass(atom/movable/mover, turf/target)
	. = ..()
	if(.)
		return

	if(istype(mover))
		return !opacity

/obj/machinery/door/airlock/stalker
	icon = 'icons/stalker/door_sidor.dmi'
	overlays_file = 'icons/stalker/door_sidor.dmi'
	autoclose = 50

/obj/machinery/door/airlock/stalker/New()
	..()

/obj/machinery/door/airlock/stalker/sidor
	name = "door"
	icon_state = "closed"

/obj/machinery/door/poddoor/sidor
	name = "door"
	desc = "A heavy duty blast door that opens mechanically."
	icon = 'icons/stalker/door_sidor.dmi'
	icon_state = "closed"
	id = null
	// TODO(wso): Move to automatic airlock type things
	// auto_close = 50

/obj/machinery/door/poddoor/sidor/skadovsk
	icon = 'icons/stalker/door_sidor2.dmi'
	icon_state = "closed"
	// TODO(wso): Move to automatic airlock type things
	// auto_close = 50

/obj/machinery/door/poddoor/sidor/skadovsk/special
	icon = 'icons/stalker/door_sidor2.dmi'
	icon_state = "closed"
	autoclose = 50
/*
/obj/machinery/door/poddoor/sidor/skadovsk/special/open(ignorepower = 0)
	if(!SSticker.round_start_time || world.time >= SSticker.round_start_time + SKADOVSK_LOCKDOWN_TIMER)
		return ..()
	else
		say("The gateway will only open after [round((SSticker.round_start_time + SKADOVSK_LOCKDOWN_TIMER - world.time)/300) + 1] min. due to external psi radiation.")
		return 0
*/
