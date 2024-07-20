#define NORTH_EDGING	"north"
#define SOUTH_EDGING	"south"
#define EAST_EDGING		"east"
#define WEST_EDGING		"west"

/turf/open/floor/plating/asteroid/snow/lite
	name = "snow"
	desc = "Looks cold."
	icon = 'icons/turf/snow.dmi'
	baseturfs = /turf/open/floor/plating/asteroid/snow
	icon_state = "snow"
	// icon_plating = "snow"
	temperature = 293
	slowdown = 4
	// environment_type = "snow"
	// dug = 1

/obj/structure/grille/stalker
	desc = "A tough and rigid iron fence. I cant climb over this."
	name = "fence"
	icon = 'icons/stalker/structure.dmi'
	icon_state = "fence1"
	density = 1
	anchored = 1
	obj_flags = CONDUCTS_ELECTRICITY
	layer = CLOSED_DOOR_LAYER
	max_integrity = 10000000

/obj/structure/grille/stalker/ex_act(severity, target)
	return

/obj/structure/grille/stalker/attack_paw(mob/user)
	return

/obj/structure/grille/stalker/attack_hand(mob/living/user)
	user.do_attack_animation(src)
	return

/obj/structure/grille/stalker/attack_animal(var/mob/living/simple_animal/M)
	M.do_attack_animation(src)
	return

/obj/structure/grille/stalker/bullet_act(var/obj/projectile/Proj)
	if(!Proj)
		return
	..()
	if((Proj.damage_type != STAMINA)) //Grilles can't be exhausted to death
		return
	return

/obj/structure/grille/stalker/attackby(obj/item/W, mob/user, params)
	return

/obj/structure/grille/hitby(atom/movable/AM, skipcatch, hitpush, blocked, datum/thrownthing/throwingdatum)
	..()
	return

/obj/structure/grille/stalker/wood
	desc = "Old wooden fence with some substantial damage."
	icon_state = "zabor_horizontal1"
	density = 1
	opacity = 1

/obj/structure/grille/stalker/beton
	icon = 'icons/stalker/beton_zabor.dmi'
	desc = "Too strong."
	icon_state = "1"
	density = 1
	opacity = 1

/obj/structure/grille/stalker/beton/green
	icon = 'icons/stalker/green_zabor.dmi'
	desc = "Green fence. Better than gray."
	icon_state = "1"

/obj/structure/grille/stalker/beton/CanPass(atom/movable/mover, turf/target, height=0)
	. = ..()
	if(height==0) return 1
	if(istype(mover) && (mover.pass_flags == PASSGRILLE))
		return 1
	else
		if(istype(mover, /obj/projectile) && density)
			return prob(0)
		else
			return !density

/turf/open/stalker
	name = "stalker turf"
	icon = 'icons/stalker/grass.dmi'
	planetary_atmos = TRUE
	footstep = FOOTSTEP_TILE
	barefootstep = FOOTSTEP_TILE
	//light_range = 3

/turf/open/stalker/Initialize(mapload)
	. = ..()
	flags_1 |= GLOBAL_LIGHT_TURF_1

/turf/open/stalker/floor
	name = "grass"
	icon = 'icons/stalker/grass.dmi'
	baseturfs = /turf/open/stalker/floor/dirt
	icon_state = "grass1"
	//overlay_priority = 0
	footstep = FOOTSTEP_TILE

/turf/open/stalker/floor/digable
	footstep = FOOTSTEP_GRASS
	barefootstep = FOOTSTEP_GRASS
	var/list/flora_weights = list(
		/obj/structure/flora/bush/sparsegrass/style_random = 30,
		/obj/structure/flora/bush/sparsegrass/style_random = 30,
		/obj/structure/flora/bush/grassy/style_random = 15,
		/obj/structure/flora/bush/sunny/style_random = 15,
		/obj/structure/flora/bush/wildplant/root = 15,
		/obj/structure/flora/bush/wildplant/root/wild_potato = 1,
		/obj/structure/flora/bush/wildplant/root/wild_tato = 1,
		/obj/structure/flora/bush/wildplant/wild_fungus = 1,
		/obj/structure/flora/bush/wildplant/wild_berries = 1,
		/obj/structure/flora/bush/wildplant/wild_bayleaf = 1,
		/obj/structure/flora/bush/wildplant/root/wild_carrot = 1,
		/obj/structure/flora/bush/wildplant/root/wild_parsnip = 1,
		/obj/structure/flora/bush/wildplant/root/wild_whitebeet = 1,
		/obj/structure/flora/bush/wildplant/root/wild_redbeet = 1,
		/obj/structure/flora/bush/wildplant/root/wild_onion = 1,
		/obj/structure/flora/bush/wildplant/root/wild_garlic = 1,
	)

/turf/open/stalker/floor/digable/grass
	icon = 'icons/stalker/zemlya.dmi'
	icon_state = "grass1"

/turf/open/stalker/floor/digable/grass/Initialize(mapload)
	. = ..()
	if(prob(50))
		return

	var/flora_type = pick_weight(flora_weights)
	new flora_type(get_turf(src))

/turf/open/stalker/floor/digable/grass/dump
	icon = 'icons/stalker/zemlya.dmi'
	icon_state = "dump_grass1"

/turf/open/stalker/floor/digable/grass/dump/New()
	icon_state = "dump_grass[rand(1, 3)]"

/turf/open/stalker/floor/digable/gryaz_rocky
	name = "rocky dirt"
	icon = 'icons/stalker/zemlya.dmi'
	icon_state = "gryaz_rocky1"

/turf/open/stalker/floor/digable/gryaz_rocky/New()
	icon_state = "gryaz_rocky[rand(1, 8)]"
	if(!GryazEdgeCache || !GryazEdgeCache.len)
		GryazEdgeCache = list()
		GryazEdgeCache.len = 10
		GryazEdgeCache[NORTH] = image('icons/stalker/zemlya.dmi', "gryaz_side_n", layer = HIGH_TURF_LAYER)
		GryazEdgeCache[SOUTH] = image('icons/stalker/zemlya.dmi', "gryaz_side_s", layer = HIGH_TURF_LAYER)
		GryazEdgeCache[EAST] = image('icons/stalker/zemlya.dmi', "gryaz_side_e", layer = HIGH_TURF_LAYER)
		GryazEdgeCache[WEST] = image('icons/stalker/zemlya.dmi', "gryaz_side_w", layer = HIGH_TURF_LAYER)

	// spawn(1)
	// 	var/turf/T
	// 	for(var/i = 0, i <= 3, i++)
	// 		if(!get_step(src, 2**i))
	// 			continue
	// 		if(layer > get_step(src, 2**i).layer)
	// 			T = get_step(src, 2**i)
	// 			if(T)
	// 				T.overlays += GryazEdgeCache[2**i]
	return

/turf/open/stalker/floor/dirt
	icon = 'icons/turf/floors.dmi'
	icon_state = "dirt"
	base_icon_state = "dirt"

/turf/open/stalker/floor/dirt/dark
	icon_state = "greenerdirt"
	base_icon_state = "greenerdirt"

/turf/open/stalker/floor/sidor
	name = "floor"
	icon = 'icons/stalker/beton.dmi'
	icon_state = "sidorpol"

/obj/machinery/door/unpowered/stalker
	icon = 'icons/stalker/beton.dmi'

/turf/open/stalker/floor/asphalt
	name = "road"
	icon = 'icons/stalker/Prishtina/asphalt.dmi'
	icon_state = "road1"
	layer = MID_TURF_LAYER
	//overlay_priority = 1

/turf/open/stalker/floor/digable/swamp
	icon = 'icons/stalker/zemlya.dmi'
	icon_state = "swamp_grass1"

/turf/open/stalker/floor/digable/grass/swamp/New()
	icon_state = "swamp_grass[rand(1, 3)]"

var/global/list/AsphaltEdgeCache

/turf/open/stalker/floor/asphalt/New()
	icon_state = "road[rand(1, 3)]"
	if(!AsphaltEdgeCache || !AsphaltEdgeCache.len)
		AsphaltEdgeCache = list()
		AsphaltEdgeCache.len = 10
		AsphaltEdgeCache[NORTH] = image('icons/stalker/Prishtina/asphalt.dmi', "roadn", layer = HIGH_TURF_LAYER)
		AsphaltEdgeCache[SOUTH] = image('icons/stalker/Prishtina/asphalt.dmi', "roads", layer = HIGH_TURF_LAYER)
		AsphaltEdgeCache[EAST] = image('icons/stalker/Prishtina/asphalt.dmi', "roade", layer = HIGH_TURF_LAYER)
		AsphaltEdgeCache[WEST] = image('icons/stalker/Prishtina/asphalt.dmi', "roadw", layer = HIGH_TURF_LAYER)

	// spawn(1)
	// 	var/turf/T
	// 	for(var/i = 0, i <= 3, i++)
	// 		if(!get_step(src, 2**i))
	// 			continue
	// 		if(layer > get_step(src, 2**i).layer)
	// 			T = get_step(src, 2**i)
	// 			if(T)
	// 				T.overlays += AsphaltEdgeCache[2**i]
	return

/turf/open/stalker/floor/tropa
	name = "road"
	icon = 'icons/stalker/tropa.dmi'
	icon_state = "tropa"
	// TODO(wso): Double check this
	layer = ABOVE_NORMAL_TURF_LAYER
	//overlay_priority = 2
	footstep = FOOTSTEP_SAND
	barefootstep = FOOTSTEP_SAND

var/global/list/TropaEdgeCache

/turf/open/stalker/floor/tropa/New()
	if(!TropaEdgeCache || !TropaEdgeCache.len)
		TropaEdgeCache = list()
		TropaEdgeCache.len = 10
		TropaEdgeCache[NORTH] = image('icons/stalker/tropa.dmi', "tropa_side_n", layer = HIGH_TURF_LAYER)
		TropaEdgeCache[SOUTH] = image('icons/stalker/tropa.dmi', "tropa_side_s", layer = HIGH_TURF_LAYER)
		TropaEdgeCache[EAST] = image('icons/stalker/tropa.dmi', "tropa_side_e", layer = HIGH_TURF_LAYER)
		TropaEdgeCache[WEST] = image('icons/stalker/tropa.dmi', "tropa_side_w", layer = HIGH_TURF_LAYER)

	// spawn(1)
	// 	var/turf/T
	// 	for(var/i = 0, i <= 3, i++)
	// 		if(!get_step(src, 2**i))
	// 			continue
	// 		if(layer > get_step(src, 2**i).layer)
	// 			T = get_step(src, 2**i)
	// 			if(T)
	// 				T.overlays += TropaEdgeCache[2**i]
	return

/turf/open/stalker/floor/road
	name = "road"
	icon = 'icons/stalker/building_road.dmi'
	icon_state = "road2"
	layer = MID_TURF_LAYER
	//overlay_priority = 3

var/global/list/WhiteRoadCache

/turf/open/stalker/floor/road/New()
	switch(rand(1, 100))
		if(1 to 65)
			icon_state = "road2"
		if(66 to 85)
			icon_state = "road1"
		if(86 to 90)
			icon_state = "road3"
		if(91 to 95)
			icon_state = "road4"
		if(96 to 100)
			icon_state = "road5"

	if(!WhiteRoadCache || !WhiteRoadCache.len)
		WhiteRoadCache = list()
		WhiteRoadCache.len = 10
		WhiteRoadCache[NORTH] = image('icons/stalker/warning_stripes.dmi', "road_b5", layer = HIGH_TURF_LAYER)
		WhiteRoadCache[SOUTH] = image('icons/stalker/warning_stripes.dmi', "road_b6", layer = HIGH_TURF_LAYER)
		WhiteRoadCache[EAST] = image('icons/stalker/warning_stripes.dmi', "road_b8", layer = HIGH_TURF_LAYER)
		WhiteRoadCache[WEST] = image('icons/stalker/warning_stripes.dmi', "road_b7", layer = HIGH_TURF_LAYER)

	// spawn(1)
	// 	for(var/i = 0, i <= 3, i++)
	// 		if(!get_step(src, 2**i) || (!istype(get_step(src, 2**i), src.type) && (src.layer > get_step(src, 2**i).layer)))
	// 			src.overlays += WhiteRoadCache[2**i]

	return

/turf/open/stalker/floor/gryaz
	name = "dirt"
	icon = 'icons/stalker/zemlya.dmi'
	icon_state = "gryaz1"
	// TODO(wso): Double check this
	layer = ABOVE_NORMAL_TURF_LAYER
	//overlay_priority = 4
	footstep = FOOTSTEP_GRASS
	barefootstep = FOOTSTEP_GRASS

var/global/list/GryazEdgeCache

/turf/open/stalker/floor/gryaz/New()
	icon_state = "gryaz[rand(1, 3)]"
	if(!GryazEdgeCache || !GryazEdgeCache.len)
		GryazEdgeCache = list()
		GryazEdgeCache.len = 10
		GryazEdgeCache[NORTH] = image('icons/stalker/zemlya.dmi', "gryaz_side_n", layer = HIGH_TURF_LAYER)
		GryazEdgeCache[SOUTH] = image('icons/stalker/zemlya.dmi', "gryaz_side_s", layer = HIGH_TURF_LAYER)
		GryazEdgeCache[EAST] = image('icons/stalker/zemlya.dmi', "gryaz_side_e", layer = HIGH_TURF_LAYER)
		GryazEdgeCache[WEST] = image('icons/stalker/zemlya.dmi', "gryaz_side_w", layer = HIGH_TURF_LAYER)

	// spawn(1)
	// 	var/turf/T
	// 	for(var/i = 0, i <= 3, i++)
	// 		if(!get_step(src, 2**i))
	// 			continue
	// 		if(layer > get_step(src, 2**i).layer)
	// 			T = get_step(src, 2**i)
	// 			if(T)
	// 				T.overlays += GryazEdgeCache[2**i]
	return

/turf/open/stalker/floor/gryaz/Initialize(mapload)
	. = ..()
	if (prob(15))
		new /obj/structure/flora/bush/wildplant/root(get_turf(src))
	if (prob(15))
		new /obj/structure/flora/bush/sparsegrass/style_random(get_turf(src))
	if (prob(1))
		new /obj/structure/flora/bush/wildplant/wild_fungus(get_turf(src))

/turf/open/stalker/floor/gryaz/gryaz2
	icon_state = "gryaz2"

/turf/open/stalker/floor/gryaz/gryaz3
	icon_state = "gryaz3"

/obj/structure/stalker/rails
	name = "rails"
	icon = 'icons/stalker/rails.dmi'
	icon_state = "sp"
	layer = TRAM_FLOOR_LAYER
	anchored = 1
	density = 0
	opacity = 0

/turf/open/stalker/floor/plasteel
	name = "floor"
	icon = 'icons/stalker/floor.dmi'

/turf/open/stalker/floor/plasteel/plita
	icon_state = "plita1"

/turf/open/stalker/floor/plasteel/plita/New()
	icon_state = "plita[rand(1, 4)]"

/turf/open/stalker/floor/plasteel/plitochka
	icon_state = "plitka1"

/turf/open/stalker/floor/plasteel/plitochka/New()
	icon_state = "plitka[rand(1, 7)]"

/turf/open/stalker/floor/plasteel/plitka
	icon_state = "plitka_old1"

/turf/open/stalker/floor/plasteel/plitka/New()
	icon_state = "plitka_old[rand(1, 8)]"

/turf/open/stalker/floor/water
	name = "water"
	icon = 'icons/stalker/water.dmi'
	smoothing_flags = USES_SMOOTHING
	var/smooth_icon = 'icons/stalker/smoothwater.dmi'
	icon_state = "water"
	layer = HIGH_TURF_LAYER
	var/busy = 0
	slowdown = 2
	footstep = FOOTSTEP_WATER
	barefootstep = FOOTSTEP_WATER
	clawfootstep = FOOTSTEP_WATER
	heavyfootstep = FOOTSTEP_WATER
	tiled_dirt = FALSE
	var/obj/structure/water_source/water_source

// TODO(wso): Probably a better replacement for water so we don't need any of this
// /turf/open/stalker/floor/water/Initialize()
// 	water_source = new(src)
// 	if(smooth)
// 		var/matrix/M = new
// 		M.Translate(-7, -7)
// 		transform = M
// 		icon = smooth_icon
// 	. = ..()

/turf/open/stalker/floor/water/attack_hand(mob/living/user)
	return water_source.attack_hand(user)

/turf/open/stalker/floor/water/attackby(obj/item/O, mob/user, params)
	if(busy)
		user << "<span class='warning'>Someone's already washing here!</span>"
		return

	if(istype(O, /obj/item/reagent_containers))
		var/obj/item/reagent_containers/RG = O
		if(RG.flags_1 & OPENCONTAINER)
			RG.reagents.add_reagent("water", min(RG.volume - RG.reagents.total_volume, RG.amount_per_transfer_from_this))
			user << "<span class='notice'>You fill [RG] from [src].</span>"
			return

	/*if(istype(O, /obj/item/melee/baton))
		var/obj/item/weapon/melee/baton/B = O
		if(B.bcell)
			if(B.bcell.charge > 0 && B.status == 1)
				flick("baton_active", src)
				var/stunforce = B.stunforce
				user.Stun(stunforce)
				user.Weaken(stunforce)
				user.stuttering = stunforce
				B.deductcharge(B.hitcost)
				user.visible_message("<span class='warning'>[user] shocks themself while attempting to wash the active [B.name]!</span>", \
									"<span class='userdanger'>You unwisely attempt to wash [B] while it's still on.</span>")
				playsound(src, "sparks", 50, 1)
				return
	*/ //Какие нахуй батоны на зоне? - valtos
	if(istype(O, /obj/item/mop))
		O.reagents.add_reagent("water", 5)
		user << "<span class='notice'>You wet [O] in [src].</span>"
		playsound(loc, 'sound/effects/slosh.ogg', 25, 1)

	var/obj/item/I = O
	if(!I || !istype(I))
		return
	if(I.flags_1 & ABSTRACT) //Abstract items like grabs won't wash. No-drop items will though because it's still technically an item in your hand.
		return

	user << "<span class='notice'>You start washing [I]...</span>"
	busy = 1
	if(!do_after(user, 40, target = src))
		busy = 0
		return
	busy = 0
	//O.clean_blood()
	user.visible_message("<span class='notice'>[user] washes [I] using [src].</span>", \
						"<span class='notice'>You wash [I] using [src].</span>")

/turf/open/stalker/floor/water/Entered(atom/movable/A)
	..()
	if(istype(A, /mob/living/carbon))
		var/mob/living/carbon/L = A
		L.update_top_overlay()
		if(istype(A, /mob/living/carbon/human))
			var/mob/living/carbon/human/H = A
			/*if(H.shoes)
				H.shoes.clean_blood()*/
			if(H.fire_stacks)
				H.fire_stacks = 0
				// TODO(wso): How to extinguish mob
				// H.ExtinguishMob()

/turf/open/stalker/floor/water/Exited(atom/movable/A)
	..()
	if(istype(A, /mob/living/carbon))
		var/mob/living/carbon/L = A
		L.update_top_overlay()
		flick("water_splash_movement", src)
/*
var/global/list/WaterEdgeCache

/turf/open/stalker/floor/water/New()
	if(!WaterEdgeCache || !WaterEdgeCache.len)
		WaterEdgeCache = list()
		WaterEdgeCache.len = 10
		WaterEdgeCache[NORTH] = image('icons/stalker/water.dmi', "water_north", layer = 2)
		WaterEdgeCache[SOUTH] = image('icons/stalker/water.dmi', "water_south", layer = 2)
		WaterEdgeCache[EAST] = image('icons/stalker/water.dmi', "water_east", layer = 2)
		WaterEdgeCache[WEST] = image('icons/stalker/water.dmi', "water_west", layer = 2)

	spawn(1)
		var/turf/T
		for(var/i = 0, i <= 3, i++)
			if(!get_step(src, 2**i))
				continue
			if(overlay_priority > get_step(src, 2**i).overlay_priority)
				T = get_step(src, 2**i)
				if(T)
					T.overlays += WaterEdgeCache[2**i]
	return
*/
/turf/open/stalker/floor/wood
	icon = 'icons/stalker/floor.dmi'
	name = "floor"
	footstep = FOOTSTEP_WOOD
	barefootstep = FOOTSTEP_WOOD
	clawfootstep = FOOTSTEP_WOOD_CLAW

/turf/open/stalker/floor/wood/brown
	icon_state = "wooden_floor"

/turf/open/stalker/floor/wood/grey
	icon_state = "wooden_floor2"

/turf/open/stalker/floor/wood/black
	icon_state = "wooden_floor3"

/turf/open/stalker/floor/wood/oldgor
	icon_state = "wood1"

/turf/open/stalker/floor/wood/oldgor/New()
	switch(rand(1, 100))
		if(1 to 5)
			icon_state = "wood1"
		if(6 to 11)
			icon_state = "wood2"
		if(12 to 17)
			icon_state = "wood13"
		if(18 to 23)
			icon_state = "wood14"
		if(24 to 29)
			icon_state = "wood15"
		if(30 to 35)
			icon_state = "wood16"
		if(36 to 41)
			icon_state = "wood17"
		if(42 to 47)
			icon_state = "wood18"
		if(48 to 53)
			icon_state = "wood19"
		if(54 to 54)
			icon_state = "wood20"
		if(55 to 57)
			icon_state = "wood21"
		if(58 to 60)
			icon_state = "wood22"
		if(61 to 63)
			icon_state = "wood23"
		if(64 to 66)
			icon_state = "wood24"
		if(67 to 69)
			icon_state = "wood25"
		if(70 to 82)
			icon_state = "wood3"
		if(83 to 84)
			icon_state = "wood4"
		if(85 to 86)
			icon_state = "wood5"
		if(87 to 88)
			icon_state = "wood6"
		if(89 to 90)
			icon_state = "wood7"
		if(91 to 92)
			icon_state = "wood8"
		if(93 to 94)
			icon_state = "wood9"
		if(95 to 96)
			icon_state = "wood10"
		if(97 to 98)
			icon_state = "wood11"
		if(99 to 100)
			icon_state = "wood12"

/turf/open/stalker/floor/wood/oldvert
	icon_state = "woodd1"

/turf/open/stalker/floor/wood/oldvert/New()
	icon_state = "woodd[rand(1, 25)]"

/turf/open/stalker/floor/agroprom/beton
	name = "floor"
	icon = 'icons/stalker/pol_agroprom.dmi'
	icon_state = "beton1"

/turf/open/stalker/floor/agroprom/beton/New()
	icon_state = "beton[rand(1, 4)]"

/turf/open/stalker/floor/agroprom/gryaz
	name = "dirt"
	icon = 'icons/stalker/pol_agroprom.dmi'
	icon_state = "gryaz1"
	footstep = FOOTSTEP_GRASS
	barefootstep = FOOTSTEP_GRASS

/turf/open/stalker/floor/agroprom/gryaz/New()
	icon_state = "gryaz[rand(1, 11)]"

/turf/open/stalker/floor/lattice
	name = "lattice"
	icon = 'icons/stalker/floor.dmi'
	icon_state = "lattice_new1"
	// overlay_priority = HIGH_TURF_LAYER

/turf/open/stalker/floor/lattice/New()
	icon_state = "lattice_new[rand(1, 21)]"

/turf/open/stalker/floor/lattice/brokeone
	name = "lattice"
	icon = 'icons/stalker/floor.dmi'
	icon_state = "lattice1"

/turf/open/stalker/floor/lattice/brokeone/New()
	icon_state = "lattice[rand(1, 4)]"

/turf/open/stalker/floor/lattice/broketwo
	name = "lattice"
	icon = 'icons/stalker/floor.dmi'
	icon_state = "lattice2_1"

/turf/open/stalker/floor/lattice/broketwo/New()
	icon_state = "lattice2_[rand(1, 7)]"

/turf/open/stalker/floor/plasteel/plita/orange
	icon_state = "plita_or1"

/turf/open/stalker/floor/plasteel/plita/orange/New()
	icon_state = "plita_or[rand(1, 9)]"
