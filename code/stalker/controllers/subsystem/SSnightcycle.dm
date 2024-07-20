#define TIMEOFDAY_SUNRISE	"sunrise"
#define TIMEOFDAY_MORNING	"morning"
#define TIMEOFDAY_DAYTIME	"daytime"
#define TIMEOFDAY_AFTERNOON	"afternoon"
#define TIMEOFDAY_EVENING	"evening"
#define TIMEOFDAY_SUNSET	"sunset"
#define TIMEOFDAY_NIGHTTIME	"nighttime"

#define CYCLE_SUNRISE 	216000  // 06:00
#define CYCLE_MORNING 	243000  // 06:45
#define CYCLE_DAYTIME	288000	// 08:00
#define CYCLE_AFTERNOON 423000	// 11:45
#define CYCLE_EVENING	603000	// 16:45
#define CYCLE_SUNSET 	783000  // 21:45
#define CYCLE_NIGHTTIME 810000	// 22:30

SUBSYSTEM_DEF(nightcycle)
	name = "Day/Night Cycle"
	wait = 10 // This thing doesn't need to fire so fast, as it's tied to gameclock not its own ticker
	can_fire = TRUE
	init_order = INIT_ORDER_NIGHTCYCLE
	var/currentTime
	var/sunColour
	var/sunPower
	var/sunRange
	var/working = 0
	var/newTime
	var/list/day_night_levels = list()

	var/list/z_level_queue = list()
	var/list/z_turfs = list()
	var/max_turfs_per_fire = 255

/datum/controller/subsystem/nightcycle/Initialize()
	nextBracket()
	return SS_INIT_SUCCESS

/datum/controller/subsystem/nightcycle/proc/has_work()
	if(length(z_turfs) > 0)
		return TRUE
	if(length(z_level_queue))
		return TRUE

	return FALSE

/datum/controller/subsystem/nightcycle/fire(resumed)
	if(!resumed && nextBracket())
		logger.Log(LOG_CATEGORY_DEBUG, "SSnightcycle prepping next run.")
		z_level_queue.Cut()
		z_turfs.Cut()
		for(var/datum/space_level/zlevel in SSmapping.z_list)
			z_level_queue += zlevel.z_value

	if(!length(z_turfs) && length(z_level_queue))
		var/next_z_level = z_level_queue[z_level_queue.len]
		z_turfs = get_area_turfs(/area/stalker/blowout/outdoor, target_z = next_z_level, subtypes = TRUE)
		logger.Log(LOG_CATEGORY_DEBUG, "SSnightcycle retrieved next_z_level=[next_z_level].")
		z_level_queue.len--

	var/current_turfs = 0
	while(length(z_turfs) && current_turfs < max_turfs_per_fire)
		var/turf/T = z_turfs[z_turfs.len]
		if(istype(T, /turf/open) && !QDELETED(T))
			T.set_light(MINIMUM_USEFUL_LIGHT_RANGE, sunPower, sunColour)
			current_turfs++
		z_turfs.len--

		if(MC_TICK_CHECK)
			logger.Log(LOG_CATEGORY_DEBUG, "SSnightcycle ran and applied [current_turfs] turfs.")
			return

/datum/controller/subsystem/nightcycle/proc/nextBracket()
	var/Time = station_time()

	switch (Time)
		if (CYCLE_SUNRISE 	to CYCLE_MORNING - 1)
			newTime = TIMEOFDAY_SUNRISE
		if (CYCLE_MORNING 	to CYCLE_DAYTIME 	- 1)
			newTime = TIMEOFDAY_MORNING
		if (CYCLE_DAYTIME 	to CYCLE_AFTERNOON	- 1)
			newTime = TIMEOFDAY_DAYTIME
		if (CYCLE_AFTERNOON to CYCLE_EVENING 	- 1)
			newTime = TIMEOFDAY_AFTERNOON
		if (CYCLE_EVENING to CYCLE_SUNSET - 1)
			newTime = TIMEOFDAY_EVENING
		if (CYCLE_SUNSET 	to CYCLE_NIGHTTIME - 1)
			newTime = TIMEOFDAY_SUNSET
		else
			newTime = TIMEOFDAY_NIGHTTIME

	if (newTime == currentTime)
		return FALSE

	currentTime = newTime
	updateLight(currentTime)
	return TRUE

/datum/controller/subsystem/nightcycle/proc/set_time_of_day(time_name)
	var/new_time = 0
	switch (time_name)
		if (TIMEOFDAY_SUNRISE)
			new_time = CYCLE_SUNRISE
		if (TIMEOFDAY_MORNING)
			new_time = CYCLE_MORNING
		if (TIMEOFDAY_DAYTIME)
			new_time = CYCLE_DAYTIME
		if (TIMEOFDAY_AFTERNOON)
			new_time = CYCLE_AFTERNOON
		if (TIMEOFDAY_SUNSET)
			new_time = CYCLE_SUNSET
		if(TIMEOFDAY_NIGHTTIME)
			new_time = CYCLE_NIGHTTIME

	if(new_time != 0)
		var/old_time = station_time()
		SSticker.gametime_offset += new_time - old_time

/datum/controller/subsystem/nightcycle/proc/updateLight(newTime)
	switch (newTime)
		if (TIMEOFDAY_SUNRISE)
			sunColour = "#ffd1b3"
			sunPower = 0.3 * 255
		if (TIMEOFDAY_MORNING)
			sunColour = "#fff2e6"
			sunPower = 0.5 * 255
		if (TIMEOFDAY_DAYTIME)
			sunColour = "#FFFFFF"
			sunPower = 0.75 * 255
		if (TIMEOFDAY_AFTERNOON)
			sunColour = "#fff2e6"
			sunPower = 0.5 * 255
		if (TIMEOFDAY_EVENING)
			sunColour = "#f9d0aad5"
			sunPower = 0.5 * 255
		if (TIMEOFDAY_SUNSET)
			sunColour = "#ffa5a5"
			sunPower = 0.3 * 255
		if(TIMEOFDAY_NIGHTTIME)
			sunColour = "#00111a"
			sunPower = 0.20 * 255

/datum/controller/subsystem/nightcycle/proc/is_daylight()
	switch (currentTime)
		if (TIMEOFDAY_SUNRISE, TIMEOFDAY_SUNSET, TIMEOFDAY_NIGHTTIME)
			return FALSE
		if (TIMEOFDAY_MORNING, TIMEOFDAY_MORNING, TIMEOFDAY_AFTERNOON)
			return TRUE

#undef TIMEOFDAY_SUNRISE
#undef TIMEOFDAY_MORNING
#undef TIMEOFDAY_DAYTIME
#undef TIMEOFDAY_AFTERNOON
#undef TIMEOFDAY_SUNSET
#undef TIMEOFDAY_NIGHTTIME

#undef CYCLE_SUNRISE
#undef CYCLE_MORNING
#undef CYCLE_DAYTIME
#undef CYCLE_AFTERNOON
#undef CYCLE_SUNSET
#undef CYCLE_NIGHTTIME
