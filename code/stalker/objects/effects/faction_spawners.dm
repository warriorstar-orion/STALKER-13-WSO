GLOBAL_LIST_EMPTY(stalker_faction_spawners)

/// Faction spawners are used independent of roundstart or latejoin so we
/// just get rid of that distinction here and in SSjobs.
/obj/effect/landmark/stalker
	name = "Stalker Spawner"

/obj/effect/landmark/stalker/Initialize(mapload)
	. = ..()
	LAZYADDASSOCLIST(GLOB.stalker_faction_spawners, name, src)

/obj/effect/landmark/stalker/duty/soldier
	name = JOB_DUTY

/obj/effect/landmark/stalker/duty/barman
	name = JOB_BARMAN2

/obj/effect/landmark/stalker/duty/liutenant
	name = JOB_DUTY_LIEUTENANT

/obj/effect/landmark/stalker/army/soldier
	name = JOB_ARMY

/obj/effect/landmark/stalker/army/spetsnaz
	name = JOB_ARMY_SPETSNAZ

/obj/effect/landmark/stalker/army/commander
	name = JOB_ARMY_COMMANDER

/obj/effect/landmark/stalker/bandits/bandit
	name = JOB_BANDIT

/obj/effect/landmark/stalker/bandits/barman
	name = JOB_BANDIT_BARMAN

/obj/effect/landmark/stalker/bandits/boss
	name = JOB_BANDITBOSS

/obj/effect/landmark/stalker/loners/loner
	name = JOB_LONER

/obj/effect/landmark/stalker/loners/barman
	name = JOB_BARMAN

/obj/effect/landmark/stalker/loners/old
	name = JOB_OLDSTALKER

/obj/effect/landmark/stalker/loners/tourist
	name = JOB_TOURIST

/obj/effect/landmark/stalker/loners/trader
	name = JOB_TRADER

/obj/effect/landmark/stalker/ecologist
	name = JOB_ECOLOGIST

/obj/effect/landmark/stalker/ecologist/guard
	name = JOB_ECOLOGISTGUARD

/obj/effect/landmark/stalker/ecologist/chief
	name = JOB_CHIEF_ECOLOGIST

/obj/effect/landmark/stalker/freedom/soldier
	name = JOB_FREEDOM

/obj/effect/landmark/stalker/freedom/lieutenant
	name = JOB_FREEDOM_LIEUTENANT

/obj/effect/landmark/stalker/mercenaries/mercenary
	name = JOB_MERCENARY

/obj/effect/landmark/stalker/mercenaries/commander
	name = JOB_MERCENARYCOMMANDER

/obj/effect/landmark/stalker/clearsky/soldier
	name = JOB_CLEARSKY

/obj/effect/landmark/stalker/clearsky/leader
	name = JOB_CLEARSKY_LEADER

/obj/effect/landmark/stalker/monolith/soldier
	name = JOB_MONOLITH

/obj/effect/landmark/stalker/monolith/preacher
	name = JOB_MONOLITH_HEGUMEN

/obj/effect/landmark/stalker/renegades/renegade
	name = JOB_RENEGADE
