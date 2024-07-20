/// Simple component that tries to move parent towards the nearest anchored object in range
/datum/component/move_towards_unanchored

/datum/component/move_towards_unanchored/Initialize()
	if(!ismovable(parent))
		return COMPONENT_INCOMPATIBLE
	START_PROCESSING(SSprocessing, src)

/datum/component/move_towards_unanchored/Destroy(force, silent)
	STOP_PROCESSING(SSprocessing, src)
	return ..()

/datum/component/move_towards_unanchored/process(seconds_per_tick)
	for(var/atom/movable/movable in oview(2, parent))
		if(movable.anchored || (movable == parent))
			continue
		step_towards(parent, movable)
		break
