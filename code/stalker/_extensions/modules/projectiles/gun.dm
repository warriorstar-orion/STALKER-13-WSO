/obj/item/gun

	//Zooming
	// TODO(wso): Move to zoomed scope component
	var/zoomable = FALSE //whether the gun generates a Zoom action on creation
	var/zoomed = FALSE //Zoom toggle
	var/zoom_amt = 3 //Distance in TURFs to move the user's screen forward (the "zoom" effect)
	var/zoom_out_amt = 0
	var/datum/action/toggle_scope_zoom/azoom

	///////////////////////STALKER////////////////////////////////

	var/can_scope = 0        //scopeable? (will still have to clarify which guns mod fit on in the scope's filepath)
	var/draw_sound = 'sound/stalker/weapons/draw/ak74_draw.ogg'
	var/damagelose = 0		 //1 урона за 1 тайл = 0.33 ед
	var/distro = 0			 //gap between shotgun shot
	var/durability = 100     //durability of a gun
	var/jam = 0              //is weapon jammed or not
	var/list/obj/item/attachment/addons = list()
	var/obj/item/attachment/gl = null

	var/list/l_sounds_shots = list('sound/stalker/weapons/fading/rnd_shooting_1.ogg','sound/stalker/weapons/fading/rnd_shooting_2.ogg',
								'sound/stalker/weapons/fading/rnd_shooting_4.ogg','sound/stalker/weapons/fading/rnd_shooting_5.ogg',
								'sound/stalker/weapons/fading/rnd_shooting_6.ogg','sound/stalker/weapons/fading/rnd_shooting_7.ogg',
								'sound/stalker/weapons/fading/rnd_shooting_9.ogg','sound/stalker/weapons/fading/rnd_shooting_10.ogg',
								'sound/stalker/weapons/fading/rnd_shooting_11.ogg')

/datum/action/toggle_scope_zoom
	name = "Toggle Scope"
	check_flags = AB_CHECK_CONSCIOUS|AB_CHECK_RESTRAINED|AB_CHECK_STUN|AB_CHECK_LYING
	button_icon = 'icons/mob/actions/actions_items.dmi'
	button_icon_state = "sniper_zoom"
	var/obj/item/gun/gun = null

/datum/action/toggle_scope_zoom/Trigger()
	gun.zoom(owner)

/datum/action/toggle_scope_zoom/IsAvailable()
	. = ..()
	if(!. && gun)
		gun.zoom(owner, FALSE)

/datum/action/toggle_scope_zoom/Remove(mob/living/L)
	gun.zoom(L, FALSE)
	..()

/obj/item/gun/shiftv(mob/user)
	if(zoomable)
		zoom(user)

/obj/item/gun/proc/zoom(mob/living/user, forced_zoom)
	if(!user || !user.client)
		return

	switch(forced_zoom)
		if(FALSE)
			zoomed = FALSE
		if(TRUE)
			zoomed = TRUE
		else
			zoomed = !zoomed

	if(zoomed)
		var/_x = 0
		var/_y = 0
		switch(user.dir)
			if(NORTH)
				_y = zoom_amt
			if(EAST)
				_x = zoom_amt
			if(SOUTH)
				_y = -zoom_amt
			if(WEST)
				_x = -zoom_amt

		user.client.change_view(zoom_out_amt)
		user.client.pixel_x = world.icon_size*_x
		user.client.pixel_y = world.icon_size*_y
	else
		user.client.change_view(CONFIG_GET(string/default_view))
		user.client.pixel_x = 0
		user.client.pixel_y = 0
	return zoomed

//Proc, so that gun accessories/scopes/etc. can easily add zooming.
/obj/item/gun/proc/build_zooming()
	if(azoom)
		return

	if(zoomable)
		for(var/obj/item/attachment/scope/S in addons)
			zoom_amt += S.zoom_add
			zoom_out_amt += (5 + S.zoom_add)
		azoom = new()
		azoom.gun = src
