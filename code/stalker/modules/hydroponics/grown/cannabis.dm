/obj/item/seeds/cannabis/violetriot
	name = "pack of violet riot weed seeds"
	desc = "These seeds grow into the violent riot strain of weed. Groovy."
	icon_state = "seed-violetriotcannabis"
	species = "violetriotcannabis"
	plantname = "Violet Riot Weed"
	product = /obj/item/food/grown/cannabis/violetriot
	mutatelist = list()
	reagents_add = list("mindbreaker" = 0.15, "lipolicide" = 0.35)
	rarity = 40

/obj/item/seeds/cannabis/neonpeon
	name = "pack of neon peon weed seeds"
	desc = "These seeds grow into neon peon weed."
	icon_state = "seed-neonpeoncannabis"
	species = "neonpeoncannabis"
	plantname = "Neon Peon Weed"
	product = /obj/item/food/grown/cannabis/neonpeon
	mutatelist = list()
	reagents_add = list("lsd" = 0.15,
						"mercury" = 0.15,
						"lithium" = 0.15,
						"atropine" = 0.15,
						"haloperidol" = 0.15,
						"methamphetamine" = 0.15,
						"capsaicin" = 0.15,
						"barbers_aid" = 0.15,
						"bath_salts" = 0.15,
						"itching_powder" = 0.15,
						"crank" = 0.15,
						"krokodil" = 0.15,
						"histamine" = 0.15,
						"lipolicide" = 0.15)
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
	volume = 420
	wine_power = 90
