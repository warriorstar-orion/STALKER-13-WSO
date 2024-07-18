/obj/item/reagent_containers/cup/soda_cans/energetic
	name = "energy drink"
	desc = "Excellent energy drink Non-Stop. Contains caffeine, taurine, and a powerful vitamin complex that relieves fatigue and adds strength. Feel like you need a boost? Then this is exactly what you need."
	icon = 'icons/stalker/food.dmi'
	icon_state = "nonstop"
	list_reagents = list("energetic" = 10, /datum/reagent/water = 20)
	w_class = 2

/obj/item/reagent_containers/cup/soda_cans/crunk
	name = "crunk energy drink"
	desc = "Great energy drink. Contains caffeine, taurine and lots of vitamines. Can't make a step? Then it's what you need. WARNING: Potentially hazardous to your health!"
	icon = 'icons/stalker/food.dmi'
	icon_state = "crunk"
	list_reagents = list("grey_bull" = 25, "energetic" = 15)
	w_class = 2


// BEER

/obj/item/reagent_containers/cup/soda_cans/lowqualbeer
	name = "Ukrainian Beer"
	desc = "Refreshing wheat-beer made in the Ukraine."
	icon = 'icons/stalker/food.dmi'
	icon_state = "pivo"
	list_reagents = list("beer" = 40)
	w_class = 2

/obj/item/reagent_containers/cup/soda_cans/highqualbeer
	name = "Russian Beer"
	desc = "Tasty and thick Imperial Dark-Stout made in Russia."
	icon = 'icons/stalker/food.dmi'
	icon_state = "pivo2"
	list_reagents = list("ale" = 38, /datum/reagent/medicine/omnizine = 2)
	w_class = 2

// JUICE & DRINKS

/obj/item/reagent_containers/cup/soda_cans/terragon
	name = "Terragon Soda"
	desc = "Refreshing and slightly sweet Terragon soda"
	icon = 'icons/stalker/food.dmi'
	icon_state = "terragon"
	list_reagents = list("energetic" = 3, "terragonsoda" = 37)
	w_class = 2

/obj/item/reagent_containers/cup/soda_cans/pineapple
	name = "Army-Pineapple Juice"
	desc = "Army-Pineapple juice. Sugary and full of carbohydrates: It's just what a Stalker needs!"
	icon = 'icons/stalker/food.dmi'
	icon_state = "army_pineapple"
	list_reagents = list(/datum/reagent/medicine/omnizine = 3, "pine" = 37)
	w_class = 2

/obj/item/reagent_containers/cup/soda_cans/purifiedwater
	name = "Purified Water"
	desc = "a small plastic container filled with purified and deradiated water!"
	icon = 'icons/stalker/food.dmi'
	icon_state = "purified_water"
	list_reagents = list(/datum/reagent/water = 40)
	w_class = 2

/obj/item/reagent_containers/cup/soda_cans/zonetea
	name = "Beards Tea"
	desc = "Produced from select medicinal mushrooms with a birch tannin base: This invigorating and rejuvinating beverage is well-loved by any Stalkers who can afford it!"
	icon = 'icons/stalker/food.dmi'
	icon_state = "zonetea"
	list_reagents = list("tea" = 15, /datum/reagent/medicine/omnizine = 10, "potass_iodide" = 10, "energetic" = 3, "psicodine" = 2)
	w_class = 2

/obj/item/reagent_containers/cup/soda_cans/voda
	name = "Mineral Water"
	desc = "Refreshing mineral water."
	icon = 'icons/stalker/food.dmi'
	icon_state = "voda"
	list_reagents = list("energetic" = 3, /datum/reagent/water = 37)
	w_class = 2

/obj/item/reagent_containers/cup/glass/flask/jerrycan
	name = "jerrycan"
	desc = "A large green metal jerrycan. It appears to hold quite a lot!"
	icon_state = "jerrycan"
	custom_materials = list(/datum/material/silver = SMALL_MATERIAL_AMOUNT)
	volume = 375

/obj/item/reagent_containers/cup/glass/flask/jerrycan/compost
	name = "jerrycan"
	desc = "A large green metal jerrycan. It appears to hold quite a lot!"
	icon_state = "jerrycan"
	custom_materials = list(/datum/material/silver = SMALL_MATERIAL_AMOUNT)
	volume = 375
	list_reagents = list("compost" = 375)
