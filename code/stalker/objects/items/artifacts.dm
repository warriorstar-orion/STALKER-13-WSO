GLOBAL_LIST_EMPTY(zona_artifacts)

/obj/item/artifact
	name = "artifact"
	desc = "An artifact, must have been created by the presence of an anomaly."
	icon = 'icons/stalker/obj/artifacts.dmi'
	w_class = WEIGHT_CLASS_SMALL
	invisibility = INVISIBILITY_ARTIFACT
	/// Amounts of rads we apply to user on handle_user()
	var/rads_amount = 2
	/// Artifact level, higher = better
	var/artifact_level = 1
	/// Whether or not we have been picked up at least once
	var/has_been_picked = FALSE
	/// Effect used for detectors to detect us
	var/mutable_appearance/detector_appearance
	/// Artifact armor we apply to the user when worn
	var/datum/armor/artifact_armor

/obj/item/artifact/Initialize(mapload)
	. = ..()
	GLOB.zona_artifacts += src
	if(ispath(artifact_armor))
		artifact_armor = get_armor_by_type(artifact_armor)
	detector_appearance = new(src)
	detector_appearance.alpha = 100
	detector_appearance.invisibility = 0
	detector_appearance.loc = src
	detector_appearance.override = TRUE
	LAZYADD(update_on_z, detector_appearance)

/obj/item/artifact/Destroy(force)
	. = ..()
	GLOB.zona_artifacts -= src
	artifact_armor = null
	detector_appearance = null

/obj/item/artifact/equipped(mob/user, slot, initial)
	. = ..()
	if(!has_been_picked)
		has_been_picked = TRUE
		invisibility = 0
	if(detector_appearance)
		user.client?.images -= detector_appearance
	detector_appearance = null

/obj/item/artifact/proc/handle_user(mob/living/user, seconds_per_tick = 2)
	return TRUE

/* radiation unfuckening pending, i hate you tg
/obj/item/artifact/proc/Think(mob/user)
	if(!charge)
		return 0
	if(istype(user, /mob/living/carbon))
		var/mob/living/carbon/mob = user
		if(istype(loc, user))
			mob.radiation = max(0, mob.radiation + radiation)

		else if(istype(loc, /obj/item/storage))
			mob.radiation = max(0, mob.radiation + radiation)

		return art_armor
	return 0
*/
