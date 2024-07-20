/obj/structure/sink/wellbroken
	name = "water well"
	icon = 'icons/stalker/farm.dmi'
	icon_state = "well2"
	desc = "A well with broken beams around it. It appears there is still water down there!"

/obj/structure/sink/wellsmall
	name = "water well"
	icon = 'icons/obj/watercloset.dmi'
	icon_state = "well3"
	desc = "A small well. It appears there is still water down there!"

/obj/structure/sink/wellpump
	name = "water pump"
	desc = "A small well. It appears there is still water down there!"
	icon = 'icons/obj/watercloset.dmi'
	icon_state = "waterpump"

//ATTACK HAND IGNORING PARENT RETURN VALUE
/obj/structure/sink/wellpump/attack_hand(mob/M)
	icon_state = "waterpump-use"
	. = ..()
	icon_state = "waterpump"

/obj/structure/sink/wellpump/attackby(obj/item/O, mob/user, params)
	icon_state = "waterpump-use"
	. = ..()
	icon_state = "waterpump"

/obj/structure/sink/wellpump/deconstruct(disassembled = TRUE)
	qdel(src)
