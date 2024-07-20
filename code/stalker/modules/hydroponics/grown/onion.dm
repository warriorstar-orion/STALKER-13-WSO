/obj/item/seeds/onion/zona
	name = "pack of mutant onion seeds"
	desc = "These seeds grow into onions."
	icon_state = "seed-onion"
	species = "zona onion"
	plantname = "Onion Sprouts"
	product = /obj/item/food/grown/onion/zona
	lifespan = 20
	maturation = 3
	production = 4
	yield = 6
	endurance = 25
	growthstages = 3
	weed_chance = 3
	growing_icon = 'icons/obj/service/hydroponics/growing_vegetables.dmi'
	reagents_add = list(/datum/reagent/consumable/nutriment/vitamin = 0.04, /datum/reagent/consumable/nutriment = 0.1, /datum/reagent/uranium = 0.25)

/obj/item/food/grown/onion/zona
	seed = /obj/item/seeds/onion/zona
	name = "decrepid onion"
	desc = "Nothing to cry over. This onion looks disguisting,"
	icon_state = "zonaonion"
	filling_color = "#C0C9A0"
	bite_consumption_mod = 2
	tastes = list("onions" = 1)
	wine_power = 30
