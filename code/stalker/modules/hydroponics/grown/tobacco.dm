/obj/item/seeds/tobacco/strong
	name = "pack of strong tobacco seeds"
	desc = "These seeds grow into strong tobacco plants."
	icon_state = "seed-stobacco"
	species = "stobacco"
	plantname = "Strong Tobacco Plant"
	product = /obj/item/food/grown/tobacco/strong
	mutatelist = list()
	reagents_add = list("salbutamol" = 0.05, "nicotine" = 0.08, "nutriment" = 0.03)
	rarity = 20

/obj/item/food/grown/tobacco/strong
	seed = /obj/item/seeds/tobacco/strong
	name = "strong tobacco leaves"
	desc = "Dry them out to make some strong smokes."
	icon_state = "stobacco_leaves"
	distill_reagent = null
	wine_power = 50
