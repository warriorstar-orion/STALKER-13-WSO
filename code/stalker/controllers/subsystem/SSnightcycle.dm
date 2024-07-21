#define TIMEOFDAY_SUNRISE	"sunrise"
#define TIMEOFDAY_DAYTIME	"daytime"
#define TIMEOFDAY_EVENING	"evening"
#define TIMEOFDAY_NIGHTTIME	"nighttime"

#define CYCLE_SUNRISE 	183000  // 05:05
#define CYCLE_DAYTIME	336000	// 09:20
#define CYCLE_EVENING	603000	// 16:45
#define CYCLE_NIGHTTIME 810000	// 22:30

/proc/most_populated_zlevels_asc(a, b)
	return cmp_numeric_asc(SSmobs.clients_by_zlevel[a].len, SSmobs.clients_by_zlevel[b].len)

SUBSYSTEM_DEF(nightcycle)
	name = "Day/Night Cycle"
	wait = 7 // This thing doesn't need to fire so fast, as it's tied to gameclock not its own ticker
	can_fire = TRUE
	init_order = INIT_ORDER_NIGHTCYCLE

	VAR_PRIVATE/current_time
	VAR_PRIVATE/sun_color
	VAR_PRIVATE/sun_power
	VAR_PRIVATE/sun_range
	VAR_PRIVATE/new_time
	VAR_PRIVATE/list/z_level_queue = list()
	VAR_PRIVATE/list/z_turfs = list()
	VAR_PRIVATE/max_turfs_per_fire = 255

/datum/controller/subsystem/nightcycle/Initialize()
	// Call this on init so that the SS doesn't immediately start updating turfs
	// and instead waits until the next cycle.
	nextBracket()
	return SS_INIT_SUCCESS

/datum/controller/subsystem/nightcycle/proc/still_busy()
	return length(z_turfs) || length(z_level_queue)

/datum/controller/subsystem/nightcycle/fire(resumed)
	if((!still_busy()) && (!resumed) && nextBracket())
		logger.Log(LOG_CATEGORY_DEBUG, "SSnightcycle prepping next run.")
		z_level_queue.Cut()
		z_turfs.Cut()
		for(var/datum/space_level/zlevel in SSmapping.z_list)
			z_level_queue += zlevel.z_value
		z_level_queue = sort_list(z_level_queue, cmp=GLOBAL_PROC_REF(most_populated_zlevels_asc))

	if(!length(z_turfs) && length(z_level_queue))
		var/next_z_level = z_level_queue[z_level_queue.len]
		z_turfs = get_area_turfs(/area/stalker/blowout/outdoor, target_z = next_z_level, subtypes = TRUE)
		logger.Log(LOG_CATEGORY_DEBUG, "SSnightcycle retrieved next_z_level=[next_z_level].")
		z_level_queue.len--

	var/current_turfs = 0
	while(length(z_turfs) && current_turfs < max_turfs_per_fire)
		var/turf/T = z_turfs[z_turfs.len]
		if(istype(T, /turf/open) && !QDELETED(T))
			T.set_light(MINIMUM_USEFUL_LIGHT_RANGE, sun_power, sun_color)
			current_turfs++
		z_turfs.len--

		if(MC_TICK_CHECK)
			logger.Log(LOG_CATEGORY_DEBUG, "SSnightcycle ran and applied [current_turfs] turfs.")
			return

/datum/controller/subsystem/nightcycle/proc/nextBracket()
	var/time = station_time()

	switch (time)
		if (CYCLE_SUNRISE to CYCLE_DAYTIME - 1)
			new_time = TIMEOFDAY_SUNRISE
		if (CYCLE_DAYTIME to CYCLE_EVENING - 1)
			new_time = TIMEOFDAY_DAYTIME
		if (CYCLE_EVENING to CYCLE_NIGHTTIME - 1)
			new_time = TIMEOFDAY_EVENING
		else
			new_time = TIMEOFDAY_NIGHTTIME

	if (new_time == current_time)
		return FALSE

	current_time = new_time
	updateLight(current_time)
	return TRUE

/datum/controller/subsystem/nightcycle/proc/set_time_of_day(time_name)
	var/new_time = 0
	switch (time_name)
		if (TIMEOFDAY_SUNRISE)
			new_time = CYCLE_SUNRISE
		if (TIMEOFDAY_DAYTIME)
			new_time = CYCLE_DAYTIME
		if (TIMEOFDAY_EVENING)
			new_time = CYCLE_EVENING
		if(TIMEOFDAY_NIGHTTIME)
			new_time = CYCLE_NIGHTTIME

	if(new_time != 0)
		var/old_time = station_time()
		SSticker.gametime_offset += new_time - old_time

/datum/controller/subsystem/nightcycle/proc/updateLight(new_time)
	switch (new_time)
		if (TIMEOFDAY_SUNRISE)
			sun_color = "#ffd1b3"
			sun_power = 0.3 * 255
		if (TIMEOFDAY_DAYTIME)
			sun_color = "#FFFFFF"
			sun_power = 0.75 * 255
		if (TIMEOFDAY_EVENING)
			sun_color = "#ffc894"
			sun_power = 0.5 * 255
		if(TIMEOFDAY_NIGHTTIME)
			sun_color = "#00111a"
			sun_power = 0.20 * 255

/datum/controller/subsystem/nightcycle/proc/is_daylight()
	return current_time == TIMEOFDAY_DAYTIME

#undef TIMEOFDAY_SUNRISE
#undef TIMEOFDAY_DAYTIME
#undef TIMEOFDAY_EVENING
#undef TIMEOFDAY_NIGHTTIME

#undef CYCLE_SUNRISE
#undef CYCLE_DAYTIME
#undef CYCLE_EVENING
#undef CYCLE_NIGHTTIME
