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

/obj/item/seeds/carrot/zona
	name = "pack of mutant carrot seeds"
	desc = "These seeds grow into carrots."
	icon_state = "seed-carrot"
	species = "zona carrot"
	plantname = "Carrots"
	product = /obj/item/food/grown/carrot/zona
	maturation = 10
	production = 1
	yield = 5
	growthstages = 3
	growing_icon = 'icons/obj/service/hydroponics/growing_vegetables.dmi'
	mutatelist = list(/obj/item/seeds/carrot/parsnip)
	reagents_add = list("oculine" = 0.25, "vitamin" = 0.04, "nutriment" = 0.05, "uranium" = 0.25)

/obj/item/food/grown/carrot/zona
	seed = /obj/item/seeds/carrot/zona
	name = "decrepit carrot"
	desc = "It's good for the eyes! This one seems sickly."
	icon_state = "zonacarrot"
	filling_color = "#FFA500"
	bite_consumption_mod = 2
	foodtypes = VEGETABLES
	juice_results = list("carrotjuice" = 0)
	wine_power = 30

/obj/item/seeds/carrot/parsnip/zona
	name = "pack of mutant parsnip seeds"
	desc = "These seeds grow into parsnips."
	icon_state = "seed-parsnip"
	species = "zona parsnip"
	plantname = "Parsnip"
	product = /obj/item/reagent_containers/food/snacks/grown/carrot/parsnip/zona
	icon_dead = "carrot-dead"
	mutatelist = list()
	reagents_add = list("vitamin" = 0.05, "nutriment" = 0.05, "uranium" = 0.25)

/obj/item/food/grown/carrot/parsnip/zona
	seed = /obj/item/seeds/carrot/parsnip/zona
	name = "decrepit parsnip"
	desc = "Closely related to carrots. This one looks sickly."
	icon_state = "zonaparsnip"
	bitesize_mod = 2
	foodtype = VEGETABLES
	wine_power = 35

// TODO(wso): Sorry, carrot shivs will come later
// /obj/item/food/grown/carrot/zona/attackby(obj/item/I, mob/user, params)
// 	if(I.is_sharp())
// 		to_chat(user, "<span class='notice'>You sharpen the carrot into a shiv with [I].</span>")
// 		var/obj/item/kitchen/knife/carrotshiv/Shiv = new /obj/item/kitchen/knife/carrotshiv
// 		remove_item_from_storage(user)
// 		qdel(src)
// 		user.put_in_hands(Shiv)
// 	else
// 		return ..()
