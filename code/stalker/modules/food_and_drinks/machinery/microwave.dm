/obj/machinery/microwave/potbelly
	name = "wide potbelly stove"
	desc = "A warm stove for cooking food, or keeping warm in the winter. It's really old fashioned, but works wonders when there's no electricity."
	icon = 'icons/stalker/bochka.dmi'
	icon_state = "potbelly0"

/obj/machinery/microwave/potbelly/attackby(obj/item/O, mob/user, params)
	if(istype(O, /obj/item/screwdriver))
		return
	..()

/obj/machinery/microwave/potbelly/update_icon()
	if(operating)
		icon_state = "potbelly1"
	else
		icon_state = "potbelly0"

/obj/machinery/microwave/barrelstove
	name = "barrel stove"
	desc = "A warm stove for cooking food, or keeping warm in the winter. It's a barrel with slits cut into it, and it works wonders when there's no electricity."
	icon = 'icons/stalker/bochka.dmi'
	icon_state = "barrelstove0"
	density = 1

/obj/machinery/microwave/barrelstove/update_icon()
	if(operating)
		icon_state = "barrelstove1"
	else
		icon_state = "barrelstove0"
