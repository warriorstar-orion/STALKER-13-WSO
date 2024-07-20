/obj/item/seeds/cannabis/violetriot
	name = "pack of violet riot weed seeds"
	desc = "These seeds grow into the violent riot strain of weed. Groovy."
	icon_state = "seed-violetriotcannabis"
	species = "violetriotcannabis"
	plantname = "Violet Riot Weed"
	product = /obj/item/food/grown/cannabis/violetriot
	mutatelist = list()
	reagents_add = list(/datum/reagent/toxin/mindbreaker = 0.15, /datum/reagent/toxin/lipolicide = 0.35)
	rarity = 40

/obj/item/seeds/cannabis/neonpeon
	name = "pack of neon peon weed seeds"
	desc = "These seeds grow into neon peon weed."
	icon_state = "seed-neonpeoncannabis"
	species = "neonpeoncannabis"
	plantname = "Neon Peon Weed"
	product = /obj/item/food/grown/cannabis/neonpeon
	mutatelist = list()
	reagents_add = list(/datum/reagent/drug/mushroomhallucinogen = 0.15,
						/datum/reagent/mercury = 0.15,
						/datum/reagent/lithium = 0.15,
						/datum/reagent/medicine/atropine = 0.15,
						/datum/reagent/medicine/haloperidol = 0.15,
						/datum/reagent/drug/methamphetamine = 0.15,
						/datum/reagent/consumable/capsaicin = 0.15,
						/datum/reagent/barbers_aid = 0.15,
						/datum/reagent/drug/bath_salts = 0.15,
						/datum/reagent/toxin/itching_powder = 0.15,
						// TODO(wso): eh
						// "crank" = 0.15,
						/datum/reagent/drug/krokodil = 0.15,
						/datum/reagent/toxin/histamine = 0.15,
						/datum/reagent/toxin/lipolicide = 0.15)
	rarity = 69

/obj/item/food/grown/cannabis/violetriot
	seed = /obj/item/seeds/cannabis/violetriot
	name = "violet riot cannabis nug"
	desc = "It has a soothing earthy stench to it that has a hint of lavender."
	icon_state = "violetriotcannabisnug"
	wine_power = 60

/obj/item/food/grown/cannabis/neonpeon
	seed = /obj/item/seeds/cannabis/neonpeon
	name = "neon peon nug"
	desc = "The nug emits a thin, wispy, green vapor that smells of sulfur married to a sickly sweet odor."
	icon_state = "neonpeoncannabisnug"
	// volume = 420
	wine_power = 90
