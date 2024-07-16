/obj/structure/stalker/tree
	name = "tree"
	icon = 'icons/stalker/derevya.dmi'
	icon_state = "derevo1"
	density = 0
	opacity = 0
	layer = 9

/obj/structure/stalker/tree/New()
	icon_state = "derevo[rand(1, 5)]"

/*
/obj/structure/stalker/tree/topol
	icon_state = "topol"

/obj/structure/stalker/tree/bereza1
	icon_state = "bereza1"

/obj/structure/stalker/tree/bereza2
	icon_state = "bereza2"

/obj/structure/stalker/tree/el1
	icon_state = "el1"

/obj/structure/stalker/tree/el2
	icon_state = "el2"
*/

/obj/structure/stalker/tree/leafless/
	name = "dead tree"
	icon = 'icons/stalker/derevya.dmi'
	icon_state = "derevo1l"
	density = 0
	opacity = 0
	layer = 9

/obj/structure/stalker/tree/leafless/New()
	icon_state = "derevo[rand(1, 5)]l"

/*
/obj/structure/stalker/tree/leafless/derevo2
	icon_state = "derevo2ll"

/obj/structure/stalker/tree/leafless/derevo3
	icon_state = "derevo3ll"

/obj/structure/stalker/tree/leafless/bereza1
	icon_state = "bereza1ll"

/obj/structure/stalker/tree/leafless/bereza2
	icon_state = "bereza2ll"
*/

/obj/structure/stalker/tree/leaflessred/
	name = "dead tree"
	icon = 'icons/stalker/derevya.dmi'
	icon_state = "derevored1l"
	density = 0
	opacity = 1
	layer = 9

/obj/structure/stalker/tree/leaflessred/New()
	icon_state = "derevored[rand(1, 5)]l"

/obj/structure/flora/ausbushes/wildplant
	name = "wild weeds"
	desc = "A useless weed which serves no purpose but to steal from other plants."
	icon_state = "wild_root1"
	anchored = 1
	density = 0
	var/has_plod = TRUE
	var/produce
	var/timer = 5000 //50 seconds

/obj/structure/flora/ausbushes/wildplant/attack_hand(mob/user)
	if(!ispath(produce))
		return ..()

	if(has_plod)
		var/obj/item/product = new produce
		if(!istype(product))
			return //Something fucked up here or it's a weird product
		user.put_in_hands(product)
		to_chat(user, "<span class='notice'>You pluck [product] from [src].</span>")
		has_plod = FALSE
		update_icon() //Won't update due to proc otherwise
		timer = initial(timer) + rand(-100,100) //add some variability
		addtimer(CALLBACK(src, .proc/regrow),timer) //Set up the timer properly
	update_icon()

/obj/structure/flora/ausbushes/wildplant/proc/regrow()
	if(!QDELETED(src))
		has_plod = TRUE
		update_icon()

/obj/structure/flora/ausbushes/wildplant/update_icon()
	if(has_plod)
		icon_state = "[initial(icon_state)]"
	else
		icon_state = "[initial(icon_state)]_no"

/obj/structure/flora/ausbushes/wildplant/root
	name = "wild weeds"
	desc = "A useless weed which serves no purpose but to steal from other plants."
	icon_state = "wild_root1"
	anchored = 1
	density = 0

/obj/structure/flora/ausbushes/wildplant/root/Initialize()
	icon_state = "wild_root[rand(1, 12)]"
	. = ..()

/obj/structure/flora/ausbushes/wildplant/root/wild_garlic
	name = "wild garlic roots"
	desc = "A hardy, delicious vegetable used to flavor many dishes. You can never have enough."
	produce = /obj/item/food/grown/garlic/zona
	icon_state = "wild_root1"

/obj/structure/flora/ausbushes/wildplant/root/wild_onion
	name = "wild onion"
	desc = "This onion is not cultivated, just out growing on its own."
	produce = /obj/item/food/grown/onion/zona
	icon_state = "wild_root1"

obj/structure/flora/ausbushes/wildplant/root/wild_redbeet
	name = "wild beet"
	desc = "Nothing beats beets."
	produce = /obj/item/food/grown/beet/red/zona
	icon_state = "wild_root1"

obj/structure/flora/ausbushes/wildplant/root/wild_whitebeet
	name = "wild beet"
	desc = "Nothing beats beets."
	produce = /obj/item/food/grown/beet/white/zona
	icon_state = "wild_root1"

/obj/structure/flora/ausbushes/wildplant/root/wild_parsnip
	name = "wild parsnip"
	desc = "Some free range parsnips!"
	produce = /obj/item/food/grown/carrot/parsnip/zona
	icon_state = "wild_root1"

/obj/structure/flora/ausbushes/wildplant/root/wild_carrot
	name = "wild carrot"
	desc = "Some free range carrots!"
	produce = /obj/item/food/grown/carrot/zona
	icon_state = "wild_root1"

/obj/structure/flora/ausbushes/wildplant/root/wild_tato
	name = "wild tato"
	desc = "The outside looks like a tomato, but the inside is brown. Tastes as absolutely disgusting as it looks, but will keep you from starving."
	produce = /obj/item/food/grown/tato
	icon_state = "wild_root1"

/obj/structure/flora/ausbushes/wildplant/root/wild_potato
	name = "wild potato"
	desc = "An essential ingredient to any slavic diet."
	produce = /obj/item/food/grown/potato/zona
	icon_state = "wild_root1"

/obj/structure/flora/ausbushes/wildplant/wild_fungus
	name = "cave fungi"
	desc = "This edible strain of fungus usually grows in dark places and is said to have anti-toxic properties."
	produce = /obj/item/food/grown/mushroom/fungus
	icon_state = "wild_fungus"

/obj/structure/flora/ausbushes/wildplant/wild_fungus/Initialize()
	icon_state = "wild_fungus[rand(1, 4)]"
	. = ..()

/obj/structure/flora/ausbushes/wildplant/wild_berries
	name = "wild berries"
	desc = "Nutritious!"
	produce = /obj/item/food/grown/berries
	icon_state = "wild_berries"

/obj/structure/flora/ausbushes/wildplant/wild_berries/Initialize()
	icon_state = "wild_berries[rand(1, 4)]"
	. = ..()

/obj/structure/flora/ausbushes/wildplant/wild_bayleaf
	name = "wild bay leaf"
	icon_state = "wild_bayleaf"
	desc = "Bay leaf is likely the most important herb."
	produce = /obj/item/food/grown/bayleaf

/obj/structure/flora/ausbushes/wildplant/wild_bayleaf/Initialize()
	icon_state = "wild_bayleaf[rand(1, 4)]"
	. = ..()
