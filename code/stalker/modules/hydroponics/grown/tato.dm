/obj/item/seeds/tato
	name = "pack of tato seeds"
	desc = "a pack of tato seeds"
	icon_state = "seed-tato"
	species = "tato"
	plantname = "Tato Plants"
	product = /obj/item/food/grown/tato
	lifespan = 30
	maturation = 10
	production = 1
	yield = 4
	growthstages = 4
	growing_icon = 'icons/obj/service/hydroponics/growing_vegetables.dmi'
	icon_grow = "tato-grow"
	icon_dead = "tato-dead"
	icon_harvest = "tato-harvest"
	genes = list(/datum/plant_gene/trait/battery, /datum/plant_gene/trait/repeated_harvest)
	reagents_add = list(/datum/reagent/consumable/nutriment = 0.1)

/obj/item/food/grown/tato
	seed = /obj/item/seeds/tato
	name = "tato"
	desc = "The outside looks like a tomato, but the inside is brown. Tastes as absolutely disgusting as it looks, but will keep you from starving."
	icon_state = "tato"
	filling_color = "#E9967A"
	bitesize = 100
	foodtype = VEGETABLES
	juice_results = list("potato" = 0)
	distill_reagent = /datum/reagent/consumable/ethanol/stalkervodka
