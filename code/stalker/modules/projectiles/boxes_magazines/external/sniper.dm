/obj/item/ammo_box/magazine/sniper_rounds/awp
	name = "heavy magazine (.338)"
	desc = "Given the scarcity of ammunition as is, don't expect to find another magazine. Short of purchasing another rifle, anyhow."
	icon_state = ".50mag"
	ammo_type = /obj/item/ammo_casing/p338
	max_ammo = 5
	caliber = ".338"

/obj/item/ammo_casing/p338
	name = ".338 bullet casing"
	desc = "A .338 bullet casing."
	caliber = ".338"
	projectile_type = /obj/item/projectile/bullet/p338
	icon_state = ".50"

/obj/item/projectile/bullet/p338
	name =".338 bullet"
	speed = 1.2//fuck you carl lapua was shit when you made it slow
	icon_state = "gaussstrong"
	damage = 70
	dismemberment = 25//You're damn right you're going to lose a limb.
	armour_penetration = 80//Strongest round in the game so far.
