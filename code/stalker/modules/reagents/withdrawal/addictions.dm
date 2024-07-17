/datum/addiction/cocaine
	name = "cocaine"

/datum/addiction/cocaine/withdrawal_stage_1_process(mob/living/carbon/affected_carbon, seconds_per_tick)
	. = ..()
	affected_carbon.adjustOrganLoss(ORGAN_SLOT_BRAIN, 5 * REM)


/datum/addiction/cocaine/withdrawal_stage_2_process(mob/living/carbon/affected_carbon, seconds_per_tick)
	. = ..()
	affected_carbon.adjustToxLoss(5*REM, 0)

/datum/addiction/cocaine/withdrawal_stage_3_process(mob/living/carbon/affected_carbon, seconds_per_tick)
	. = ..()
	affected_carbon.adjustOrganLoss(ORGAN_SLOT_BRAIN, 3 * REM)
	affected_carbon.adjustToxLoss(5 * REM, 0)
	affected_carbon.adjustBruteLoss(5 * REM, 0)
