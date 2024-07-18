/obj/item/storage/belt/military/tactibelt
	icon_state = "tactibelt"
	worn_icon_state = "tactibelt"
	inhand_icon_state = "tactibelt"
	desc = "A tactical holster-belt, for holding spare ammo, grenades, knives and sidearms."

/obj/item/storage/belt/military/tactibelt/Initialize(mapload)
	. = ..()
	atom_storage.max_slots = 4

/obj/item/storage/belt/military/webbing
	icon_state = "webbing"
	worn_icon_state = "webbing"
	inhand_icon_state = "webbing"
	desc = "A set of pouches, typically worn on top of armor to increase carrying capacity."

/obj/item/storage/belt/military/webbing/Initialize(mapload)
	. = ..()
	atom_storage.max_slots = 6

/obj/item/storage/belt/military/chestrig
	icon_state = "chestrig"
	inhand_icon_state = "chestrig"
	desc = "A hefty chestrig with a numerous amount of pouch slots. Ideal for carrying important equipment."

/obj/item/storage/belt/military/chestrig/Initialize(mapload)
	. = ..()
	atom_storage.max_slots = 8
