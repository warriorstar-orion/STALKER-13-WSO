/obj/item/seeds/potato/zona
	name = "pack of mutant otato seeds"
	desc = "Boil 'em! Mash 'em! Stick 'em in a stew!"
	icon_state = "seed-potato"
	species = "zona potato"
	plantname = "Potato Plants"
	product = /obj/item/food/grown/potato/zona
	lifespan = 30
	maturation = 10
	production = 1
	yield = 4
	growthstages = 4
	growing_icon = 'icons/obj/service/hydroponics/growing_vegetables.dmi'
	icon_grow = "potato-grow"
	icon_dead = "potato-dead"
	reagents_add = list(/datum/reagent/consumable/nutriment/vitamin = 0.04, /datum/reagent/consumable/nutriment = 0.1, "uranium" = 0.25)

/obj/item/food/grown/potato/zona
	seed = /obj/item/seeds/potato/zona
	name = "decrepit potato"
	desc = "Boil 'em! Mash 'em! Stick 'em in a stew! This potato looks very unappetizing."
	icon_state = "zonapotato"
	filling_color = "#E9967A"
	bite_consumption = 100
	foodtypes = VEGETABLES
	// TODO(wso): Fix juicing results
	// juice_results = list("potato" = 0)
	distill_reagent = "vodka"
