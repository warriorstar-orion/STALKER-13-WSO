/obj/structure/reagent_dispensers/compostvat
	name = "vat of compost"
	desc = "A huge metal vat with a tap on the front. Filled with composted waste."
	icon_state = "vatdirty"
	anchored = TRUE
	reagent_id = "compost"
	tank_volume = 12000

/obj/structure/reagent_dispensers/compostbin
	name = "compost bin"
	desc = "An odiforous bin with a big hole at the top where refuse is thrown to decompose into fertilizer. There are flies which buzz around the top."
	icon_state = "compostbin"
	reagent_id = "compost"
	anchored = TRUE
	tank_volume = 12000

/obj/structure/reagent_dispensers/compostbinmetal
	name = "compost bin"
	desc = "An odiforous bin where refuse is thrown to decompose into fertilizer. There are flies which buzz around the top."
	icon_state = "compostbinmetal-1"
	reagent_id = "compost"
	anchored = TRUE
	tank_volume = 12000

/obj/structure/reagent_dispensers/compostbinmetal/update_icon()
	. = ..()
	var/percent = round((reagents.total_volume / 12000 * 100))
	switch(percent)
		if(0 to 24)
			icon_state = "[initial(icon_state)]-4"
		if(25 to 49)
			icon_state = "[initial(icon_state)]-3"
		if(50 to 74)
			icon_state = "[initial(icon_state)]-2"
		if(75 to 99)
			icon_state = "[initial(icon_state)]-1"
		if(100)
			icon_state = "[initial(icon_state)]"

/obj/structure/reagent_dispensers/watertank1
	name = "large red tank"
	desc = "A large red tank that has been weathered by time. Despite its age, it appear to still have quite a lot of water in it."
	icon = 'icons/stalker/obj/objects.dmi'
	icon_state = "watertank1"
	reagent_id = "water"
	anchored = TRUE
	tank_volume = 35750

/obj/structure/reagent_dispensers/watertank2
	name = "large blue tank"
	desc = "A large blue tank that has been weathered by time. Despite its age, it appear to still have quite a lot of water in it."
	icon = 'icons/stalker/obj/objects.dmi'
	icon_state = "watertank2"
	reagent_id = "water"
	anchored = TRUE
	tank_volume = 35750
