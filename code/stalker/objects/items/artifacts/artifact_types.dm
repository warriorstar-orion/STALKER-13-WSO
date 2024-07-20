/////////////////////////////////////////Gravity artifacts/////////////////////////////////////////
/obj/item/artifact/meduza
	name = "jellyfish"
	desc = "This gravitational artifact attracts and absorbs radioactive particles, reducing the effects of radiation on the body. Very common in the Zone and is unofficially used outside the Zone for treating acute radiation sickness in exceptional circumstances."
	icon_state = "meduza"
	rads_amount = -2
	artifact_level = 1

/obj/item/artifact/stoneflower
	name = "stone flower"
	desc = "Born in gravitional anomalies. This artifact is found in only a few areas of the Zone. The bits of metallic compounds create a beautiful light play."
	icon_state = "stoneflower"
	rads_amount = 2
	artifact_level = 2
	artifact_armor = /datum/armor/artifact_stoneflower

/datum/armor/artifact_stoneflower
	bullet = 10

/obj/item/artifact/stoneflower/depleted
	name = "depleted stone flower"
	artifact_armor = null

/obj/item/artifact/nightstar
	name = "night star"
	desc = "This wonderful artifact is formed by gravitional anomalies anomaly. The use of the artifact demands the neutralization of deadly radiation. Expensive and rare."
	icon_state = "nightstar"
	rads_amount = 3
	artifact_level = 3
	artifact_armor = /datum/armor/artifact_nightstar

/datum/armor/artifact_nightstar
	bullet = 20

/obj/item/artifact/nightstar/depleted
	name = "depleted night star"
	artifact_armor = null

/obj/item/artifact/soul
	name = "soul"
	desc = "A unique organic artifact with properties just as unique. Somehow it increases the body's overall recovery rate from damage of any kind, without accelerating the accumulation of toxins. Thanks to its effects and attractive appearance, this artifact is a valuable collector's item. Emits radiation."
	icon_state = "soul"
	rads_amount = 2
	artifact_level = 4

/obj/item/artifact/soul/handle_user(mob/living/user, seconds_per_tick = 2)
	. = ..()
	if(!.)
		return
	user.adjustBruteLoss(-0.5 * seconds_per_tick)

/////////////////////////////////////////Electro artifacts/////////////////////////////////////////
/obj/item/artifact/flash
	name = "flash"
	desc = "This electrostatic artifact is a powerful absorbent of electricity, which it later discharges. Flash is capable of protecting its bearer from electric shocks of up to 5,000 volts. Emits radiation."
	icon_state = "flash"
	rads_amount = 1
	artifact_level = 1
	artifact_armor = /datum/armor/artifact_flash

/datum/armor/artifact_flash
	energy = 10

/obj/item/artifact/moonlight
	name = "moonlight"
	desc = "Degenerate case of the activity of the Electro anomaly. It seems that such a wonderful round form is created when the anomaly is subjected to thermal influences. Expensive artifact."
	icon_state = "moonlight"
	rads_amount = 2
	artifact_level = 2
	artifact_armor = /datum/armor/artifact_moonlight

/datum/armor/artifact_moonlight
	energy = 20

/obj/item/artifact/pustishka
	name = "shell"
	desc = "Degenerate case of the Electra anomaly activity. Apparently, such a remarkable rounded shape can be obtained by subjecting the anomaly to thermal action. Expensive artifact."
	icon_state = "pustishka"
	rads_amount = 2
	artifact_level = 3
	artifact_armor = /datum/armor/artifact_pustishka

/datum/armor/artifact_pustishka
	energy = 30

/obj/item/artifact/battery
	name = "battery"
	desc = "The composition of this artifact includes electrostatic elements, but scientists have yet to identify the exact physical conditions required for its formation. The artifact is popular in the Zone and valued by its residents and visitors for its energizing properties, although it can tire the body out through prolonged use. Doesn't emit radiation."
	icon_state = "battery"
	artifact_level = 4
	artifact_armor = /datum/armor/artifact_battery

/datum/armor/artifact_battery
	energy = 40

/////////////////////////////////////////Fire artifacts/////////////////////////////////////////
/obj/item/artifact/droplet
	name = "droplet"
	desc = "Formed in the fireer anomaly at high temperatures. From the exterior looks like a tear-like shade compound with a glossy surface, covered in cracks."
	icon_state = "droplet"
	rads_amount = -1
	artifact_level = 1
	artifact_armor = /datum/armor/artifact_droplet

/datum/armor/artifact_droplet
	/* rads armor doesn't exist, wtf do i do?
	rad = 10
	*/

/obj/item/artifact/fireball
	name = "fireball"
	desc = "Crystallizes in the anomaly fireer. Fights well with radioactivity, though the heightened rate of energy exchange wears out the muscles of the moving apparatus. Won't be able to run for long. Artifact emits heat."
	icon_state = "fireball"
	rads_amount = -2
	artifact_level = 2
	artifact_armor = /datum/armor/artifact_fireball

/datum/armor/artifact_fireball
	/* rads armor doesn't exist, wtf do i do?
	rad = 15
	*/

/obj/item/artifact/crystal
	name = "crystal"
	desc = "Is created when heavy metals fall into the fireer anomaly. This artifact eliminates radiation wonderfully. It is highly valued by stalkers and hard to find."
	icon_state = "crystal"
	rads_amount = -5
	artifact_level = 4

/obj/item/artifact/maminibusi
	name = "mama's beads"
	desc = "Much about this artifact remains a complete mystery to scientists. At the same time, it is known for certain that emissions produced by pulses in its thicker sections force blood in open wounds to clot quicker, forming a protective scab. One of the most noticeable effects of this artifact is the increased speed of wound healing. Emits radiation."
	icon_state = "mamini_busi"
	rads_amount = 5
	artifact_level = 4

/obj/item/artifact/maminibusi/handle_user(mob/living/user, seconds_per_tick = 2)
	. = ..()
	if(!.)
		return
	user.adjustFireLoss(-0.5 * seconds_per_tick)

/////////////////////////////////////////Chemical artifacts/////////////////////////////////////////
/obj/item/artifact/stone_blood
	name = "stone blood"
	desc = "A reddish formation of compressed and fossilized plants, soil and animal debris. Can partially neutralize chemical poisons. Emits radiation."
	icon_state = "stone_blood"
	rads_amount = 1
	artifact_level = 1
	artifact_armor = /datum/armor/artifact_stone_blood

/datum/armor/artifact_stone_blood
	bio = 10

/obj/item/artifact/bubble
	name = "bubble"
	desc = "A compound of several hollow organic formations, this artifact emits a gaseous substance that can neutralize radioactive particles inside the body without harming it. Because of its effectiveness, this artifact is in great demand."
	icon_state = "bubble"
	rads_amount = -3
	artifact_level = 2

/obj/item/artifact/mica
	name = "mica"
	desc = "Anomaly \"Fruit Punch\" is able to create such an artifact at the rarest, most extreme collection of physical conditions. The result is a semi-transparent, hard object. A rare and expensive artifact."
	icon_state = "mica"
	rads_amount = 3
	artifact_level = 3
	artifact_armor = /datum/armor/artifact_mica

/datum/armor/artifact_mica
	bio = 10
	laser = 10

/obj/item/artifact/mica/handle_user(mob/living/user, seconds_per_tick = 2)
	. = ..()
	if(!.)
		return
	if(ishuman(user))
		var/mob/living/carbon/human/human_user = user
		if(human_user.blood_volume < BLOOD_VOLUME_NORMAL)
			human_user.blood_volume += 0.5 * seconds_per_tick

/obj/item/artifact/firefly
	name = "firefly"
	desc = "Firefly interacts with fields unknown to science, considerably speeding up regeneration of tissue and organs in living beings, as well as normalizing metabolic processes. This artifact can literally get a badly wounded stalker back on his feet in seconds. Unfortunately, Firefly is extremely rare. Emits radiation."
	icon_state = "firefly"
	rads_amount = 5
	artifact_level = 4

/obj/item/artifact/firefly/handle_user(mob/living/user, seconds_per_tick = 2)
	. = ..()
	if(!.)
		return
	user.adjustBruteLoss(-0.25 * seconds_per_tick)
	user.adjustFireLoss(-0.25 * seconds_per_tick)
