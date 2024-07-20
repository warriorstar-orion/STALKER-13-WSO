/obj/item/storage/belt/artifact
	name = "artifact belt"
	desc = "Special belt for artifacts."
	icon_state = "artifactbelt"
	worn_icon_state = "utility"

/obj/item/storage/belt/artifact/Initialize(mapload)
	. = ..()
	atom_storage.max_specific_storage = WEIGHT_CLASS_NORMAL
	atom_storage.max_slots = 5
	atom_storage.set_holdable(list(/obj/item/artifact))

/obj/item/storage/belt/artifact/small
	name = "small artifact belt"
	desc = "Special belt for artifacts."
	icon_state = "artifactbeltsmall"
	worn_icon_state = "artifacts"

/obj/item/storage/belt/artifact/small/Initialize(mapload)
	. = ..()
	atom_storage.max_slots = 2
