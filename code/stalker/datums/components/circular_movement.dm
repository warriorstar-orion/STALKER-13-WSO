/// Simple component that moves parent around in a circle, basically
/datum/component/circular_movement
	/// Turf we center our movement around
	var/turf/center
	/// Radius of movement
	var/radius = 2
	/// Variation of radius when moving around
	var/radius_variation = 0
	/// Current angle of movement
	var/current_angle = 0
	/// How much we increase the angle every process
	var/increments = 15

/datum/component/circular_movement/Initialize(turf/center, radius = 2, radius_variation = 0, starting_angle = 0, increments = 15)
	if(!ismovable(parent))
		return COMPONENT_INCOMPATIBLE
	//pointless
	if(!center || (radius < 0))
		qdel(src)
		return
	src.center = center
	src.radius = radius
	src.current_angle = starting_angle
	src.increments = increments
	START_PROCESSING(SScircular_movement, src)

/datum/component/circular_movement/Destroy(force, silent)
	STOP_PROCESSING(SScircular_movement, src)
	return ..()

/datum/component/circular_movement/process(seconds_per_tick)
	var/atom/movable/parent_movable = parent
	var/turf/turf_in_angle = get_turf_in_angle(current_angle, center, radius + rand(-radius_variation, radius_variation))
	if(turf_in_angle)
		parent_movable.forceMove(turf_in_angle)
	current_angle += increments
	current_angle = SIMPLIFY_DEGREES(current_angle)
