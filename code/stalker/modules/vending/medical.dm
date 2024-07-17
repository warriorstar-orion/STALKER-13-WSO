/obj/machinery/vending/medical/busted
	name = "\improper Busted Medical Vendor"
	desc = "Medical drug dispenser."
	icon_state = "med-broken"
	icon_deny = "med-deny"
//	product_ads = "Go save some lives!;The best stuff for your infirmary!.;Only the finest tools.;Natural chemicals!;This stuff saves lives.;Don't you want some?;Ping!"
//	req_access = list(ACCESS_MEDICAL)
	products = list(/obj/item/reagent_containers/pill/potassium_iodide = 1,
/obj/item/reagent_containers/pill/radioprotectant = 1,
/obj/item/reagent_containers/pill/vinca = 1,
/obj/item/reagent_containers/pill/psyblock = 0,
/obj/item/reagent_containers/pill/cocaine = 1,
/obj/item/reagent_containers/pill/analgesic = 0,
/obj/item/reagent_containers/pill/caffeine = 1,
/obj/item/reagent_containers/hypospray/medipen/stalker/anabiotic = 0,
/obj/item/reagent_containers/hypospray/medipen/stalker/hercules = 0,
/obj/item/reagent_containers/hypospray/medipen/stalker/metamizole = 0,
/obj/item/reagent_containers/hypospray/medipen/stalker/antirad = 2,
/obj/item/reagent_containers/hypospray/medipen/stalker/axyltallisal = 0,
)
	armor = list("melee" = 100, "bullet" = 100, "laser" = 100, "energy" = 100, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 100, "acid" = 50)
	resistance_flags = FIRE_PROOF
	refill_canister = /obj/item/vending_refill/medical
