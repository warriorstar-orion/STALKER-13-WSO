/obj/effect/zona_anomaly/electro
	name = "electro anomaly"
	icon_state = "electra0"
	active_icon_state = "electra1"
	light_range = 1
	active_light_range = 3
	light_color = "#7ac8e2"
	active_light_color = "#7ac8e2"
	idle_sound = /datum/looping_sound/electro_anomaly
	activation_sound = 'sound/stalker/anomalies/electra_blast1.ogg'
	damage = 40
	damage_type = BURN
	armor_check = ENERGY
	affect_mob_delay = 0
	affect_cooldown_duration = 2 SECONDS
	// this loot table seems very wrong
	loot = list(
		NO_LOOT = 90,
		/obj/item/artifact/flash = 2.5,
		/obj/item/artifact/moonlight = 1.75,
		/obj/item/artifact/battery = 0.75,
		/obj/item/artifact/pustishka = 0.25,
	)

/obj/effect/zona_anomaly/vortex
	name = "vortex anomaly"
	icon_state = "karusel0"
	active_icon_state = "karusel1"
	light_range = 0
	active_light_range = 0
	activation_sound = 'sound/stalker/anomalies/gravi_blast1.ogg'
	damage = 30
	damage_type = BRUTE
	armor_check = BOMB
	gibbing = TRUE
	affect_mob_delay = 1 SECONDS
	affect_cooldown_duration = 4 SECONDS
	loot = list(
		NO_LOOT = 76,
		/obj/item/artifact/meduza = 10,
		/obj/item/artifact/stoneflower/depleted = 8,
		/obj/item/artifact/nightstar/depleted = 4,
		/obj/item/artifact/soul = 2,
	)

/obj/effect/zona_anomaly/vortex/Initialize()
	. = ..()
	AddComponent(/datum/component/move_towards_unanchored)

/obj/effect/zona_anomaly/springboard
	name = "springboard anomaly"
	icon_state = "tramplin0"
	active_icon_state = "tramplin1"
	light_range = 0
	active_light_range = 0
	activation_sound = 'sound/stalker/anomalies/gravi_blast1.ogg'
	damage = 15
	damage_type = BRUTE
	armor_check = BOMB
	affect_mob_delay = 0.5 SECONDS
	affect_cooldown_duration = 2 SECONDS
	loot = list(
		NO_LOOT = 80,
		/obj/item/artifact/meduza = 12,
		/obj/item/artifact/stoneflower/depleted = 5.5,
		/obj/item/artifact/nightstar/depleted = 2,
		/obj/item/artifact/soul = 0.5,
	)

/obj/effect/zona_anomaly/springboard/affect_mob(mob/living/affected, first_affect = FALSE)
	. = ..()
	if(QDELETED(affected))
		return

	var/range = rand(1, 6)
	var/turf/target_turf = get_turf_in_angle(rand(0, 360), get_turf(src), rand(1, 6))
	affected.throw_at(target_turf, range, 2)

/obj/effect/zona_anomaly/burner
	name = "burner anomaly"
	icon_state = "jarka0"
	active_icon_state = "jarka1"
	activation_sound = 'sound/stalker/anomalies/zharka1.ogg'
	light_range = 3
	active_light_range = 4
	light_color = "#FFAA33"
	active_light_color = "#FFAA33"
	damage = 20
	damage_type = BURN
	armor_check = FIRE
	fire_stacks = 3
	igniting = TRUE
	affect_mob_delay = 0
	affect_cooldown_duration = 2 SECONDS
	loot = list(
		NO_LOOT = 90,
		/obj/item/artifact/droplet = 5,
		/obj/item/artifact/fireball = 3,
		/obj/item/artifact/crystal = 1.5,
		/obj/item/artifact/maminibusi = 0.5,
	)

/obj/effect/zona_anomaly/burner/comet
	name = "comet anomaly"
	icon_state = "jarka1"
	active_icon_state = "jarka1"
	damage = 40
	fire_stacks = 10
	loot = list(
		/obj/item/artifact/droplet = 45,
		/obj/item/artifact/fireball = 40,
		/obj/item/artifact/crystal = 10,
		/obj/item/artifact/maminibusi = 5,
	)
	loot_amount = 2

/obj/effect/zona_anomaly/burner/comet/Initialize()
	. = ..()
	AddComponent(/datum/component/circular_movement, get_turf(src))

/obj/effect/zona_anomaly/fruit_punch
	name = "fruit punch anomaly"
	icon_state = "holodec"
	active_icon_state = "holodec" //needs activate icon
	light_range = 3
	active_light_range = 4
	light_color = "#70cc33"
	active_light_color = "#70cc33"
	activation_sound = 'sound/stalker/anomalies/buzz_hit.ogg'
	damage = 60
	damage_type = BURN
	armor_check = ACID
	affect_mob_delay = 0
	affect_cooldown_duration = 2 SECONDS
	loot = list(
		NO_LOOT = 80,
		/obj/item/artifact/stone_blood = 10,
		/obj/item/artifact/bubble = 5.5,
		/obj/item/artifact/mica = 3,
		/obj/item/artifact/firefly = 1.5,
	)
	constant_processing = TRUE
	var/can_have_son = TRUE
	var/obj/effect/zona_anomaly/son

/obj/effect/zona_anomaly/fruit_punch/process()
	. = ..()
	if(!can_have_son)
		return
	if(son)
		return
	var/mob/living/my_enemy = locate(/mob/living) in oview(1, src)
	if(my_enemy)
		create_son(my_enemy.loc)
		do_attack_animation(son)
		son.prepare_affect_mob(my_enemy)
	else
		for(var/obj/item/my_item in oview(1, src))
			if(istype(my_item, /obj/item/artifact))
				continue
			create_son(my_item.loc)
			do_attack_animation(son)
			son.affect_item(my_item)
			return

/obj/effect/zona_anomaly/fruit_punch/proc/create_son(turf/creation_loc, qdel_time = 4 SECONDS)
	son = new /obj/effect/zona_anomaly/fruit_punch/splash(creation_loc)
	RegisterSignal(son, COMSIG_QDELETING, PROC_REF(son_deleted))
	if(qdel_time)
		QDEL_IN(son, qdel_time)

/obj/effect/zona_anomaly/fruit_punch/proc/son_deleted()
	SIGNAL_HANDLER

	son = null

/obj/effect/zona_anomaly/fruit_punch/splash
	name = "fruit punch splash"
	icon_state = "holodec_splash"
	active_icon_state = "holodec_splash" //needs active icon
	light_range = 0
	active_light_range = 1
	damage = 30
	loot = null
	can_have_son = FALSE

/obj/effect/zona_anomaly/fruit_punch/splash/Initialize(mapload)
	. = ..()
	if(!mapload)
		flick("holodec_splash_creation", src)

/obj/effect/zona_anomaly/burnt_fuzz
	name = "burnt fuzz anomaly"
	icon_state = "puh"
	active_icon_state = "puh" //needs active icon
	activation_sound = 'sound/stalker/anomalies/buzz_hit.ogg'
	damage = 65
	armor_check = BIO
	affect_mob_delay = 0
	affect_cooldown_duration = 2 SECONDS

/obj/effect/zona_anomaly/burnt_fuzz/Initialize(mapload)
	. = ..()
	icon_state = pick("puh","puh2")
	active_icon_state = icon_state

#undef NO_LOOT
