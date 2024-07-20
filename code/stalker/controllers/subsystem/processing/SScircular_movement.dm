/// The subsystem used to tick [/datum/component/circular_movement] instances.
PROCESSING_SUBSYSTEM_DEF(circular_movement)
	name = "Circular Movement"
	flags = SS_NO_INIT
	runlevels = RUNLEVEL_GAME | RUNLEVEL_POSTGAME
	wait = 0.5 SECONDS
