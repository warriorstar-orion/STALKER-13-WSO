/datum/reagent/medicine
	var/id

/datum/reagent/medicine/bicaridine
	name = "Bicaridine"
	id = "bicaridine"
	description = "Restores bruising. Overdose causes it instead."
	reagent_state = LIQUID
	color = "#C8A5DC"
	overdose_threshold = 30

/datum/reagent/medicine/bicaridine/on_mob_life(mob/living/carbon/M)
	M.adjustBruteLoss(-7*REM, 0)
	..()
	. = 1

/datum/reagent/medicine/bicaridine/overdose_process(mob/living/M)
	M.adjustBruteLoss(9*REM, FALSE, FALSE, BODYTYPE_ORGANIC)
	..()
	. = 1

/datum/reagent/medicine/kelotane
	name = "Kelotane"
	id = "kelotane"
	description = "Restores fire damage. Overdose causes it instead."
	reagent_state = LIQUID
	color = "#C8A5DC"
	overdose_threshold = 30

/datum/reagent/medicine/kelotane/on_mob_life(mob/living/carbon/M)
	M.adjustFireLoss(-7*REM, 0)
	..()
	. = 1

/datum/reagent/medicine/kelotane/overdose_process(mob/living/M)
	M.adjustFireLoss(9*REM, FALSE, FALSE, BODYTYPE_ORGANIC)
	..()
	. = 1

/datum/reagent/plantnutriment/compost
	name = "compost"
	description = "A mixture of waste and rotten plant matter that nurtures plants and keeps them free of pests."
	color = "#44341F"
	taste_description = "rot"
	reagent_state = "SOLID"
