/obj/item/stalker/loot
	icon = 'icons/stalker/loot.dmi'

/obj/item/stalker/loot/mutantparts
	name = "mutant parts"

/obj/item/stalker/loot/mutantparts/dog_tail
	name = "Dog tail"
	desc = "The resistance of the mutant dog's skin to electricity and chemical agents has long been the subject of scientific attention. It can be sold for small amount. Ecololgists may be interest in this."
	icon_state = "pes"
	grind_results = list("carbon" = 10, "unknownsubstance" = 5, /datum/reagent/consumable/nutriment = 10, "blood" = 10)

/obj/item/stalker/loot/mutantparts/rat_tail
	name = "Rat tail"
	desc = "This is a rat tail... whether or not it will be any use will be up to the scientist to find out. It can be sold for small amount. Ecololgists may be interest in this."
	icon_state = "rattail"
	grind_results = list("carbon" = 5, "unknownsubstance" = 2.5, /datum/reagent/consumable/nutriment = 5, "blood" = 5)

/obj/item/stalker/loot/mutantparts/flesh_eye
	name = "Flesh eye"
	desc = "The mutated, swollen eye of the Flesh acquired a number of strange characteristics, the most useful of which is the ability to regenerate the lens. The specifics of the process are unknown, although such discovery would most certainly revolutionize modern medicine. You can play your part in scientific development by selling Flesh eyes to scientists for their experiments."
	icon_state = "plot"
	grind_results = list("carbon" = 5, "unknownsubstancetwo" = 5, /datum/reagent/consumable/nutriment = 10, "blood" = 10)

/obj/item/stalker/loot/mutantparts/boar_leg
	name = "Boar hoof"
	desc = "The hoof of a wild boar is used by scientists for manufacturing of some medicines, the most widespread of which are anti radiation drugs."
	icon_state = "kaban"
	grind_results = list("carbon" = 5, "unknownsubstancetwo" = 5, /datum/reagent/consumable/nutriment = 10, "blood" = 10)

/obj/item/stalker/loot/mutantparts/snork_leg
	name = "Snork leg"
	desc = "Snork feet contain a huge number of highly elastic tendons. This explains the beast's ability to make those unbelievably long jumps."
	icon_state = "snork_leg"
	grind_results = list("carbon" = 10, "unknownsubstancefour" = 5, /datum/reagent/consumable/nutriment = 10, "blood" = 10)

/obj/item/stalker/loot/mutantparts/pseudo_tail
	name = "Pseudodog tail"
	desc = "The resistance of the skin of mutated dogs to chemical and electrical effects has long attracted the attention of scientists. Due to the lack of fat deposits, the tails of dogs are most suitable for laboratory research."
	icon_state = "psevdopes"
	grind_results = list("carbon" = 10, "unknownsubstance" = 5, /datum/reagent/consumable/nutriment = 10, "blood" = 10)

/obj/item/stalker/loot/mutantparts/bloodsucker
	name = "bloodsucker tendrils"
	desc = "Bloodsucker's tentacles contain a special gland used for secreting an enzyme that dissolves the victim's skin and at the same time prevents blood from clotting. If scientists can determine the structure of the enzyme, it will help make a breakthrough in medicine. "
	icon_state = "bloodsucker"
	grind_results = list("carbon" = 10, "unknownsubstancefour" = 7.5, /datum/reagent/consumable/nutriment = 10, "blood" = 10)

/obj/item/stalker/loot/mutantparts/controller_brain
	name = "controller brain"
	desc = "A brain. You can feel the psy-waves unconfortably pushing into your thoughts when you hold it."
	icon_state = "controller_brain"
	grind_results = list("carbon" = 10, "unknownsubstancefour" = 7.5, /datum/reagent/consumable/nutriment = 10, "blood" = 10)

/obj/item/stalker/loot/mutantparts/poltergeist_skin
	name = "poltergeist flesh"
	desc = "A chunk of flesh taken from a Poltergeist. It seems to be very slightly moving on its own, somehow."
	icon_state = "myaso"
	grind_results = list("carbon" = 5, "unknownsubstancethree" = 7.5, /datum/reagent/consumable/nutriment = 5, "blood" = 5, "slimejelly" = 5)

	/// Raw Meat ///

/obj/item/food/meat/slab/mutantmeat
	name = "mutant meat"
	desc = "Stringy, gamey meat from a mutant. It can be cooked on a campfire for more edibility."
	icon_state = "mutantmeat"
	grind_results = list("carbon" = 10, "unknownsubstance" = 5, /datum/reagent/consumable/nutriment = 10, "blood" = 10)
	tastes = list("meat" = 1)
	bite_consumption = 3
	foodtypes = MEAT | RAW
	food_reagents = list(/datum/reagent/consumable/nutriment = 3, "cooking_oil" = 2) //Meat has fats that a food processor can process into cooking oil

/obj/item/food/meat/slab/mutantmeat/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/dryable, /obj/item/food/sosjerky/mutant)

/obj/item/food/meat/slab/mutantmeat/make_processable()
	AddElement(/datum/element/processable, TOOL_KNIFE,  /obj/item/food/meat/rawcutlet/mutant, 3, 3 SECONDS, table_required = TRUE, screentip_verb = "Cut")

/obj/item/food/meat/slab/mutantmeat/make_grillable()
	AddComponent(/datum/component/grillable, /obj/item/food/meat/steak/mutant, rand(30 SECONDS, 90 SECONDS), TRUE, TRUE) //Add medium rare later maybe?

/obj/item/food/meat/slab/mutantmeat/dog_meat
	name = "dog meat"
	desc = "Stringy, gamey meat from a mutant dog. It can be cooked on a campfire for more edibility."
	icon_state = "mutantmeat"
	grind_results = list("carbon" = 10, "unknownsubstance" = 5, /datum/reagent/consumable/nutriment = 10, "blood" = 10)
	tastes = list("meat" = 1)

/obj/item/food/meat/slab/mutantmeat/dog_meat/make_processable()
	AddElement(/datum/element/processable, TOOL_KNIFE, /obj/item/food/meat/rawcutlet/mutant/dog, 3, 3 SECONDS, table_required = TRUE, screentip_verb = "Cut")

/obj/item/food/meat/slab/mutantmeat/dog_meat/make_grillable()
	AddComponent(/datum/component/grillable, /obj/item/food/meat/steak/mutant/dog, rand(30 SECONDS, 90 SECONDS), TRUE, TRUE) //Add medium rare later maybe?

/obj/item/food/meat/slab/mutantmeat/rat_meat
	name = "rat meat"
	desc = "This is rat meat. Whilst it doesnt look to appetizing, it can be cooked and eaten for some nutrition value."
	icon_state = "mutantmeat"
	grind_results = list("carbon" = 5, "unknownsubstance" = 2.5, /datum/reagent/consumable/nutriment = 5, "blood" = 5)
	tastes = list("meat" = 1)
	foodtypes = MEAT | RAW
	bite_consumption = 3

/obj/item/food/meat/slab/mutantmeat/rat_meat/make_processable()
	AddElement(/datum/element/processable, TOOL_KNIFE, /obj/item/food/meat/rawcutlet/mutant/rat, 3, 3 SECONDS, table_required = TRUE, screentip_verb = "Cut")

/obj/item/food/meat/slab/mutantmeat/rat_meat/make_grillable()
	AddComponent(/datum/component/grillable, /obj/item/food/meat/steak/mutant/rat, rand(30 SECONDS, 90 SECONDS), TRUE, TRUE) //Add medium rare later maybe?

/obj/item/food/meat/slab/mutantmeat/flesh_meat
	name = "Flesh meat"
	desc = "Meat from a flesh; it has a strong rotten and putrescent odor. It can still be cooked and eaten."
	icon_state = "mutantmeat"
	grind_results = list("carbon" = 5, "unknownsubstancetwo" = 5, /datum/reagent/consumable/nutriment = 10, "blood" = 10)
	tastes = list("meat" = 1)
	foodtypes = MEAT | RAW
	bite_consumption = 3

/obj/item/food/meat/slab/mutantmeat/flesh_meat/make_processable()
	AddElement(/datum/element/processable, TOOL_KNIFE, /obj/item/food/meat/rawcutlet/mutant/flesh, 3, 3 SECONDS, table_required = TRUE, screentip_verb = "Cut")

/obj/item/food/meat/slab/mutantmeat/flesh_meat/make_grillable()
	AddComponent(/datum/component/grillable, /obj/item/food/meat/steak/mutant/flesh, rand(30 SECONDS, 90 SECONDS), TRUE, TRUE) //Add medium rare later maybe?

/obj/item/food/meat/slab/mutantmeat/boar_meat
	name = "Boar meat"
	desc = "The meat of a wild mutated boar; it seems thick and hard to bend. It can be cooked and eaten."
	icon_state = "mutantmeat"
	grind_results = list("carbon" = 5, "unknownsubstancetwo" = 5, /datum/reagent/consumable/nutriment = 10, "blood" = 10)
	tastes = list("meat" = 1)
	foodtypes = MEAT | RAW
	bite_consumption = 3

/obj/item/food/meat/slab/mutantmeat/boar_meat/make_processable()
	AddElement(/datum/element/processable, TOOL_KNIFE, /obj/item/food/meat/rawcutlet/mutant/boar, 3, 3 SECONDS, table_required = TRUE, screentip_verb = "Cut")

/obj/item/food/meat/slab/mutantmeat/boar_meat/make_grillable()
	AddComponent(/datum/component/grillable, /obj/item/food/meat/steak/mutant/boar, rand(30 SECONDS, 90 SECONDS), TRUE, TRUE) //Add medium rare later maybe?

/obj/item/food/meat/slab/mutantmeat/snork_meat
	name = "Snork meat"
	desc = "Snork meat, it is extremely lean and tough, but it can be cooked and eaten for small nutrition gain."
	icon_state = "mutantmeat"
	grind_results = list("carbon" = 10, "unknownsubstancefour" = 5, /datum/reagent/consumable/nutriment = 10, "blood" = 10)
	tastes = list("meat" = 1)
	foodtypes = MEAT | RAW
	bite_consumption = 3

/obj/item/food/meat/slab/mutantmeat/snork_meat/make_processable()
	AddElement(/datum/element/processable, TOOL_KNIFE, /obj/item/food/meat/rawcutlet/mutant/snork, 3, 3 SECONDS, table_required = TRUE, screentip_verb = "Cut")

/obj/item/food/meat/slab/mutantmeat/snork_meat/make_grillable()
	AddComponent(/datum/component/grillable, /obj/item/food/meat/steak/mutant/snork, rand(30 SECONDS, 90 SECONDS), TRUE, TRUE) //Add medium rare later maybe?

/obj/item/food/meat/slab/mutantmeat/pseudo_meat
	name = "pseudodog meat"
	desc = "Stringy, gamey meat from a pseudodog. An odd resource, but can be cooked for food purposes."
	icon_state = "mutantmeat"
	grind_results = list("carbon" = 10, "unknownsubstance" = 5, /datum/reagent/consumable/nutriment = 10, "blood" = 10)
	tastes = list("meat" = 1)
	foodtypes = MEAT | RAW
	bite_consumption = 3

/obj/item/food/meat/slab/mutantmeat/pseudo_meat/make_processable()
	AddElement(/datum/element/processable, TOOL_KNIFE, /obj/item/food/meat/rawcutlet/mutant/pseudo, 3, 3 SECONDS, table_required = TRUE, screentip_verb = "Cut")

/obj/item/food/meat/slab/mutantmeat/pseudo_meat/make_grillable()
	AddComponent(/datum/component/grillable, /obj/item/food/meat/steak/mutant/pseudo, rand(30 SECONDS, 90 SECONDS), TRUE, TRUE) //Add medium rare later maybe?

/obj/item/food/meat/slab/mutantmeat/bloodsucker_meat
	name = "bloodsucker meat"
	desc = "Bloodsucker meat, it smells putrescent and seems to twitch every once and a while. Can be cooked and eaten for surpisingly good nutrition value."
	icon_state = "mutantmeat"
	grind_results = list("carbon" = 10, "unknownsubstancefour" = 7.5, /datum/reagent/consumable/nutriment = 10, "blood" = 10)
	tastes = list("meat" = 1)
	foodtypes = MEAT | RAW
	bite_consumption = 3

/obj/item/food/meat/slab/mutantmeat/bloodsucker_meat/make_processable()
	AddElement(/datum/element/processable, TOOL_KNIFE, /obj/item/food/meat/rawcutlet/mutant/bloodsucker, 3, 3 SECONDS, table_required = TRUE, screentip_verb = "Cut")

/obj/item/food/meat/slab/mutantmeat/bloodsucker_meat/make_grillable()
	AddComponent(/datum/component/grillable, /obj/item/food/meat/steak/mutant/bloodsucker, rand(30 SECONDS, 90 SECONDS), TRUE, TRUE) //Add medium rare later maybe?

/obj/item/food/meat/slab/mutantmeat/controller_meat
	name = "controller meat"
	desc = "Mutant meat from a controller. You can feel pulsating coming from this sticky slab of flesh. Can be cooked and eaten for surpisingly good nutrition value."
	icon_state = "mutantmeat"
	grind_results = list("carbon" = 10, "unknownsubstancefour" = 7.5, /datum/reagent/consumable/nutriment = 10, "blood" = 10)
	tastes = list("meat" = 1)
	foodtypes = MEAT | RAW
	bite_consumption = 3

/obj/item/food/meat/slab/mutantmeat/controller_meat/make_processable()
	AddElement(/datum/element/processable, TOOL_KNIFE, /obj/item/food/meat/rawcutlet/mutant/controller, 3, 3 SECONDS, table_required = TRUE, screentip_verb = "Cut")

/obj/item/food/meat/slab/mutantmeat/controller_meat/make_grillable()
	AddComponent(/datum/component/grillable, /obj/item/food/meat/steak/mutant/controller, rand(30 SECONDS, 90 SECONDS), TRUE, TRUE) //Add medium rare later maybe?


	/// Cooked Meat ///

/obj/item/food/meat/steak/mutant
	name = "Cooked mutant meat"
	desc = "Stringy, gamey meat from a mutant."
	icon_state = "mutantmeatcooked"

/obj/item/food/meat/steak/mutant/dog
	name = "Cooked dog meat"
	desc = "Stringy, gamey meat from a mutant dog."

/obj/item/food/meat/steak/mutant/rat
	name = "Cooked rat meat"
	desc = "This is rat meat... It does not appear to be too appetizing as it is."

/obj/item/food/meat/steak/mutant/flesh
	name = "Cooked flesh meat"
	desc = "Meat from a flesh; it has a strong rotten and putrescent odor."

/obj/item/food/meat/steak/mutant/boar
	name = "Cooked boar meat"
	desc = "The meat of a wild mutated boar; it seems thick and hard to bend."

/obj/item/food/meat/steak/mutant/snork
	name = "Cooked snork meat"
	desc = "Snork meat, it is extremely lean and tough."

/obj/item/food/meat/steak/mutant/pseudo
	name = "Cooked pseudodog meat"
	desc = "Stringy, gamey meat from a pseudodog."

/obj/item/food/meat/steak/mutant/bloodsucker
	name = "Cooked bloodsucker meat"
	desc = "Bloodsucker meat, it smells putrescent and seems to twitch every once and a while."

/obj/item/food/meat/steak/mutant/controller
	name = "Cooked controller meat"
	desc = "Mutant meat from a controller. You can feel pulsating coming from this sticky slab of flesh."
