/obj/item/seeds/beet/red/zona
	name = "pack of redbeet seeds"
	desc = "These seeds grow into red beet producing plants."
	icon_state = "seed-beet/red"
	species = "zona redbeet"
	plantname = "red-beet plants"
	product = /obj/item/food/grown/beet/red/zona
	lifespan = 60
	endurance = 50
	yield = 6
	growing_icon = 'icons/obj/service/hydroponics/growing_vegetables.dmi'
	icon_dead = "whitebeet-dead"
	genes = list(/datum/plant_gene/trait/maxchem)
	reagents_add = list("vitamin" = 0.05, "nutriment" = 0.05, "uranium" = 0.25)

/obj/item/food/grown/beet/red/zona
	seed = /obj/item/seeds/beet/red/zona
	name = "red-beet"
	desc = "You can't beat red beet. This one looks sickly."
	icon_state = "zonaredbeet"
	bite_consumption_mod = 2
	foodtypes = VEGETABLES
	wine_power = 60

/obj/item/seeds/beet/white/zona
	name = "pack of mutant white-beet seeds"
	desc = "These seeds grow into sugary beet producing plants."
	icon_state = "seed-beet/white"
	species = "zona whitebeet"
	plantname = "white-beet plants"
	product = /obj/item/food/grown/beet/white/zona
	lifespan = 60
	endurance = 50
	yield = 6
	growing_icon = 'icons/obj/service/hydroponics/growing_vegetables.dmi'
	icon_dead = "beet/white-dead"
	mutatelist = list(/obj/item/seeds/beet/red/zona)
	reagents_add = list("vitamin" = 0.04, "sugar" = 0.2, "nutriment" = 0.05, "uranium" = 0.25)

/obj/item/food/grown/beet/white/zona
	seed = /obj/item/seeds/beet/white/zona
	name = "decrepit white-beet"
	desc = "You can't beat white-beet. This one looks sickly."
	icon_state = "zonawhitebeet"
	filling_color = "#F4A460"
	bite_consumption_mod = 2
	foodtypes = VEGETABLES
	wine_power = 40
