#define TIMEOFDAY_SUNRISE	"sunrise"
#define TIMEOFDAY_MORNING	"morning"
#define TIMEOFDAY_DAYTIME	"daytime"
#define TIMEOFDAY_AFTERNOON "afternoon"
#define TIMEOFDAY_SUNSET	"sunset"
#define TIMEOFDAY_NIGHTTIME	"nighttime"

#define CYCLE_SUNRISE 	(6 HOURS)
#define CYCLE_MORNING 	(7 HOURS)
#define CYCLE_DAYTIME 	(10 HOURS)
#define CYCLE_AFTERNOON (16 HOURS)
#define CYCLE_SUNSET 	(20 HOURS)
#define CYCLE_NIGHTTIME (22 HOURS)

/// Nightcycle uses the starlight lighting system to simulate the time of day.
SUBSYSTEM_DEF(nightcycle)
	name = "Day/Night Cycle"
	wait = 30 SECONDS // This thing doesn't need to fire so fast, as it's tied to gameclock not its own ticker
	init_order = INIT_ORDER_NIGHTCYCLE

	VAR_PRIVATE/current_time = TIMEOFDAY_NIGHTTIME
	VAR_PRIVATE/sun_color
	VAR_PRIVATE/sun_power
	VAR_PRIVATE/sun_range

/datum/controller/subsystem/nightcycle/Initialize()
	return SS_INIT_SUCCESS

/datum/controller/subsystem/nightcycle/fire(resumed)
	if(next_bracket())
		set_base_starlight(sun_color, sun_power, sun_range)

/datum/controller/subsystem/nightcycle/proc/next_bracket()
	var/time = station_time()
	var/new_time = TIMEOFDAY_NIGHTTIME

	switch (time)
		if (CYCLE_SUNRISE 	to CYCLE_MORNING - 1)
			new_time = TIMEOFDAY_SUNRISE
		if (CYCLE_MORNING 	to CYCLE_DAYTIME 	- 1)
			new_time = TIMEOFDAY_MORNING
		if (CYCLE_DAYTIME 	to CYCLE_AFTERNOON	- 1)
			new_time = TIMEOFDAY_DAYTIME
		if (CYCLE_AFTERNOON to CYCLE_SUNSET 	- 1)
			new_time = TIMEOFDAY_AFTERNOON
		if (CYCLE_SUNSET 	to CYCLE_NIGHTTIME - 1)
			new_time = TIMEOFDAY_SUNSET

	if (new_time == current_time)
		return FALSE

	current_time = new_time
	update_light(current_time)
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
		if (TIMEOFDAY_NIGHTTIME)
			new_time = CYCLE_NIGHTTIME

	if(new_time != 0)
		var/old_time = station_time()
		SSticker.gametime_offset += new_time - old_time
		return TRUE

/datum/controller/subsystem/nightcycle/proc/update_light(new_time)
	switch (new_time)
		if (TIMEOFDAY_SUNRISE)
			sun_color = "#ffd1b3"
			sun_power = 0.3
		if (TIMEOFDAY_MORNING)
			sun_color = "#fff2e6"
			sun_power = 0.5
		if (TIMEOFDAY_DAYTIME)
			sun_color = "#FFFFFF"
			sun_power = 0.75
		if (TIMEOFDAY_AFTERNOON)
			sun_color = "#fff2e6"
			sun_power = 0.5
		if (TIMEOFDAY_SUNSET)
			sun_color = "#ffcccc"
			sun_power = 0.3
		if(TIMEOFDAY_NIGHTTIME)
			sun_color = "#00111a"
			sun_power = 0.20

/datum/controller/subsystem/nightcycle/proc/is_daylight()
	switch(current_time)
		if (TIMEOFDAY_SUNRISE, TIMEOFDAY_MORNING, TIMEOFDAY_AFTERNOON)
			return TRUE
		else
			return FALSE

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
