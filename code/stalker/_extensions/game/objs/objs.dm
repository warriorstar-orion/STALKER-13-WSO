/obj/proc/updateUsrDialog()
	if(!(obj_flags & IN_USE))
		return

	var/is_in_use = FALSE
	var/list/nearby = viewers(1, src)
	for(var/mob/M in nearby)
		if ((M.client && M.machine == src))
			is_in_use = TRUE
			ui_interact(M)
	if(issilicon(usr) || isAdminGhostAI(usr))
		if (!(usr in nearby))
			if (usr.client && usr.machine == src) // && M.machine == src is omitted because if we triggered this by using the dialog, it doesn't matter if our machine changed in between triggering it and this - the dialog is probably still supposed to refresh.
				is_in_use = TRUE
				ui_interact(usr)

	// check for TK users

	if(ishuman(usr))
		var/mob/living/carbon/human/H = usr
		if(!(usr in nearby))
			if(usr.client && usr.machine == src)
				if(H.dna.check_mutation(/datum/mutation/human/telekinesis))
					is_in_use = TRUE
					ui_interact(usr)
	if (is_in_use)
		obj_flags |= IN_USE
	else
		obj_flags &= ~IN_USE

/obj/proc/updateDialog(update_viewers = TRUE,update_ais = TRUE)
	// Check that people are actually using the machine. If not, don't update anymore.
	if(obj_flags & IN_USE)
		var/is_in_use = FALSE
		if(update_viewers)
			for(var/mob/M in viewers(1, src))
				if ((M.client && M.machine == src))
					is_in_use = TRUE
					src.interact(M)
		var/ai_in_use = FALSE
		if(update_ais)
			ai_in_use = AutoUpdateAI(src)

		if(update_viewers && update_ais) //State change is sure only if we check both
			if(!ai_in_use && !is_in_use)
				obj_flags &= ~IN_USE

