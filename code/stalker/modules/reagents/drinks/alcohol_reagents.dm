/obj/item/reagent_containers/cup/glass/bottle/vodka/bluegoose
	name = "blue goose vodka"
	desc = "A expensive vodka which is only for flexing."
	icon_state = "bluegoose"
	list_reagents = list(/datum/reagent/consumable/ethanol/vodka = 100)

/obj/item/reagent_containers/cup/glass/bottle/vodka/kazaki
	name = "Cossacks vodka"
	desc = "Vodka by ukrainian company GSC. Easy to drink. Can reduce radiation from human's body."
	icon = 'icons/stalker/obj/drinks/bottles.dmi'
	icon_state = "gsc_vodka"
	list_reagents = list(/datum/reagent/consumable/ethanol/vodka = 90, /datum/reagent/medicine/potass_iodide = 10)

/obj/item/reagent_containers/cup/glass/bottle/vodka/stolichnaya
	name = "Stolichnaya vodka"
	desc = "Vodka which comes from some of Russia's oldest distilleries. Smooth in both flavour and burn. Some Stalkers swear by it's ability to cure radiation poisoning!"
	icon = 'icons/stalker/obj/drinks/bottles.dmi'
	icon_state = "stolichnaya"
	list_reagents = list(/datum/reagent/consumable/ethanol/vodka = 80, /datum/reagent/medicine/potass_iodide = 20)
	w_class = 2

/obj/item/reagent_containers/cup/glass/bottle/vodka/blacklabelvodka
	name = "Black-Label vodka"
	desc = "Produced in the European Union. This grain-alcohol is proof that even in The Zone? Luxury can be found! A potent and energetic drink!"
	icon = 'icons/stalker/obj/drinks/bottles.dmi'
	icon_state = "blacklabel_vodka"
	list_reagents = list(/datum/reagent/consumable/ethanol/vodka = 70, /datum/reagent/medicine/potass_iodide = 20, /datum/reagent/drug/energetic = 10)
	w_class = 2

/obj/item/reagent_containers/cup/glass/bottle/vodka/stalkervodka
	name = "Zone-Produced vodka"
	desc = "Vodka produced by the desperation of some 'ingenious' stalkers using local mushrooms and wild-grasses. It tastes and smells like filthy piss, but it'll do the job cheap!"
	icon = 'icons/obj/drinks/drinks.dmi'
	icon_state = "stalker_vodka"
	list_reagents = list(/datum/reagent/consumable/ethanol/stalkervodka = 100)

/datum/reagent/consumable/ethanol/stalkervodka
	name = "Vodka"
	// id = "stalkervodka"
	description = "Number one drink AND fueling choice for Russians worldwide. This one smells off..."
	color = "#0064C8" // rgb: 0, 100, 200
	boozepwr = 75
	taste_description = "putrid grain alcohol"
	// TODO(wso): Port to glass/cup default reagent containers
	// glass_icon_state = "ginvodkaglass"
	// glass_name = "glass of dirty vodka"
	// glass_desc = "The glass contain wodka. Xynta."
	// shot_glass_icon_state = "shotglassclear"

/datum/reagent/consumable/ethanol/stalkervodka/on_mob_life(mob/living/carbon/drinker, seconds_per_tick, times_fired)
	drinker.adjustToxLoss(-6 * REM * seconds_per_tick)
	return ..()
