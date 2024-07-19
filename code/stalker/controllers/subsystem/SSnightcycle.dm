/*  6:00 AM 	- 	21600
	6:45 AM 	- 	24300
	11:45 AM 	- 	42300
	4:45 PM 	- 	60300
	9:45 PM 	- 	78300
	10:30 PM 	- 	81000 */

#define TIMEOFDAY_SUNRISE "sunrise"
#define TIMEOFDAY_MORNING "morning"
#define TIMEOFDAY_DAYTIME "daytime"
#define TIMEOFDAY_AFTERNOON "afternoon"
#define TIMEOFDAY_SUNSET "sunset"
#define TIMEOFDAY_NIGHTTIME "nighttime"

#define CYCLE_SUNRISE 	216000
#define CYCLE_MORNING 	243000
#define CYCLE_DAYTIME 	423000
#define CYCLE_AFTERNOON 603000
#define CYCLE_SUNSET 	783000
#define CYCLE_NIGHTTIME 810000

GLOBAL_LIST_INIT(nightcycle_turfs, list())

SUBSYSTEM_DEF(nightcycle)
	name = "Day/Night Cycle"
	wait = 5 //5 ticks in between checks, this thing doesn't need to fire so fast, as it's tied to gameclock not its own ticker
	//This will also give the game time to light up the columns and not choke
	//var/flags = 0			//see MC.dm in __DEFINES Most flags must be set on world start to take full effect. (You can also restart the mc to force them to process again
	can_fire = TRUE
	var/currentTime
	var/sunColour
	var/sunPower
	var/sunRange
	var/working = 0
	var/newTime
	var/list/day_night_levels = list()

//used to initialize the subsystem AFTER the map has loaded
/datum/controller/subsystem/nightcycle/Initialize(start_timeofday)
	//loop over all blowout areas and set them up to use the day night cycle
	// for(var/area/stalker/blowout/B in world)

	// 	//grab all floors in this area
	// 	for(var/turf/open/stalker/floor/F in B)

	// 		//enable the day night effects on this turf
	// 		// TODO(wso): Figure out what modern lighting should be doing here
	// 		// F.turf_light_range = 3
	// 		// F.turf_light_range = 0.75

	// 		//make sure this zlevel is included
	// 		var/cur_z = "[F.z]"
	// 		day_night_levels |= cur_z

	return SS_INIT_SUCCESS

/datum/controller/subsystem/nightcycle/fire(resumed = FALSE)
	if(nextBracket())
		for(var/area_type in GLOB.areas_by_type)
			CHECK_TICK
			if(ispath(area_type, /area/stalker/blowout/outdoor))
				var/area/A = GLOB.areas_by_type[area_type]
				A.set_base_lighting(new_base_lighting_color = sunColour, new_alpha = sunPower)

/datum/controller/subsystem/nightcycle/proc/nextBracket()
	var/Time = station_time()

	switch (Time)
		if (CYCLE_SUNRISE 	to CYCLE_MORNING - 1)
			newTime = TIMEOFDAY_SUNRISE
		if (CYCLE_MORNING 	to CYCLE_DAYTIME 	- 1)
			newTime = TIMEOFDAY_MORNING
		if (CYCLE_DAYTIME 	to CYCLE_AFTERNOON	- 1)
			newTime = TIMEOFDAY_DAYTIME
		if (CYCLE_AFTERNOON to CYCLE_SUNSET 	- 1)
			newTime = TIMEOFDAY_AFTERNOON
		if (CYCLE_SUNSET 	to CYCLE_NIGHTTIME - 1)
			newTime = TIMEOFDAY_SUNSET
		else
			newTime = TIMEOFDAY_NIGHTTIME

	if (newTime != currentTime)
		//message_admins("new time bracket triggered /datum/controller/subsystem/nightcycle/proc/nextBracket() Time:[Time] newTime:[newTime]")
		currentTime = newTime
		updateLight(currentTime)
		/*if(newTime == TIMEOFDAY_MORNING) //Only change lamps when we need to
			for(var/obj/structure/lamp_post/LP in GLOB.lamppost)
				LP.icon_state = "[initial(LP.icon_state)]"
				LP.set_light(0)
		else if(newTime == TIMEOFDAY_SUNSET)
			for(var/obj/structure/lamp_post/LP in GLOB.lamppost)
				LP.icon_state = "[initial(LP.icon_state)]-on"
				LP.set_light(LP.on_range,LP.on_power,LP.light_color)*/
		. = TRUE
	else
		//message_admins("/datum/controller/subsystem/nightcycle/proc/nextBracket() Time:[Time] newTime:[newTime]")

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
		if (TIMEOFDAY_SUNSET)
			sunColour = "#ffcccc"
			sunPower = 0.3 * 255
		if(TIMEOFDAY_NIGHTTIME)
			sunColour = "#00111a"
			sunPower = 0.20 * 255

/datum/controller/subsystem/nightcycle/proc/is_daylight()
	switch (currentTime)
		if (TIMEOFDAY_SUNRISE)
			return 0
		if (TIMEOFDAY_MORNING)
			return 1
		if (TIMEOFDAY_DAYTIME)
			return 1
		if (TIMEOFDAY_AFTERNOON)
			return 1
		if (TIMEOFDAY_SUNSET)
			return 0
		if(TIMEOFDAY_NIGHTTIME)
			return 0

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
