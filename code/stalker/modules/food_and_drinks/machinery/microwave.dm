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
