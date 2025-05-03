/mob/living/proc/adjustPsyLoss(amount)
	if(HAS_TRAIT(src, TRAIT_BLOWOUT_IMMUNE))
		return FALSE
	if(HAS_TRAIT(src, TRAIT_GODMODE))
		return FALSE
	psyloss = clamp((psyloss + (amount * CONFIG_GET(number/damage_multiplier))), 0, maxHealth * 2)
	return amount
