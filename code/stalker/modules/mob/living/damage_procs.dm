/mob/living/proc/adjustPsyLoss(amount)
	if(HAS_TRAIT(src, TRAIT_BLOWOUT_IMMUNE))
		return FALSE
	if(status_flags & GODMODE)
		return FALSE
	psyloss = clamp((psyloss + (amount * CONFIG_GET(number/damage_multiplier))), 0, maxHealth * 2)
	return amount
