/obj/item/knife/hunting
	name = "hunting knife"
	icon_state = "huntingknife"
	item_state = "knife"
	desc = "A hunting knife that is typically used by stalkers and military personnel alike. It has a serrated edge which is fit for survival usage, and a bayonet lug on its hilt."
	force = 30
	throwforce = 20
	sharpness = IS_SHARP_ACCURATE
	slot_flags = ITEM_SLOT_BELT
	w_class = WEIGHT_CLASS_SMALL
	hitsound = "sound/weapons/knifeswing.ogg"
	attack_verb = list("slashed", "stabbed", "sliced", "torn", "ripped", "cut")

/obj/item/knife/m9
	name = "m9 knife"
	icon_state = "m9knife"
	item_state = "knife"
	desc = "An M9 Phrobis III multipurpose knife and bayonet. Sports a 7-inch blade and is purpose-built to stab things, in your hands or on a gun. Really pointy."
	force = 35
	throwforce = 20
	armour_penetration = 35
	sharpness = IS_SHARP_ACCURATE
	slot_flags = ITEM_SLOT_BELT
	w_class = WEIGHT_CLASS_SMALL
	hitsound = "sound/weapons/knifeswing.ogg"
	attack_verb = list("penetrated", "stabbed", "punctured", "impaled", "skewered", "pierced")
