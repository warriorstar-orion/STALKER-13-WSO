/*  6:00 AM 	- 	21600
	6:45 AM 	- 	24300
	11:45 AM 	- 	42300
	4:45 PM 	- 	60300
	9:45 PM 	- 	78300
	10:30 PM 	- 	81000 */
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
	//var/list/timeBrackets = list("SUNRISE" = , "MORNING" = , "DAYTIME" = , "EVENING" = , "" = ,)
	var/currentTime
	var/sunColour
	var/sunPower
	var/sunRange
	var/currentColumn
	var/currentZLevel
	var/working = 0
	var/doColumns //number of columns to do at a time
	var/newTime
	var/list/day_night_levels = list()

//used to initialize the subsystem AFTER the map has loaded
/datum/controller/subsystem/nightcycle/Initialize(start_timeofday)

	//loop over all blowout areas and set them up to use the day night cycle
	for(var/area/stalker/blowout/B in world)

		//grab all floors in this area
		for(var/turf/open/stalker/floor/F in B)

			//enable the day night effects on this turf
			// TODO(wso): Figure out what modern lighting should be doing here
			// F.turf_light_range = 3
			// F.turf_light_range = 0.75

			//make sure this zlevel is included
			var/cur_z = "[F.z]"
			day_night_levels |= cur_z

	return ..(start_timeofday)

/datum/controller/subsystem/nightcycle/fire(resumed = FALSE)
	//message_admins("/datum/controller/subsystem/nightcycle/fire([resumed]) check1")
	if(nextBracket())
		working = 1
		currentColumn = 1
		currentZLevel = 1

	CHECK_TICK
	if (working)
		//message_admins("/datum/controller/subsystem/nightcycle/fire([resumed]) working tick")
		doWork()

/datum/controller/subsystem/nightcycle/proc/nextBracket()
	var/Time = station_time()

	switch (Time)
		if (CYCLE_SUNRISE 	to CYCLE_MORNING - 1)
			newTime = "SUNRISE"
		if (CYCLE_MORNING 	to CYCLE_DAYTIME 	- 1)
			newTime = "MORNING"
		if (CYCLE_DAYTIME 	to CYCLE_AFTERNOON	- 1)
			newTime = "DAYTIME"
		if (CYCLE_AFTERNOON to CYCLE_SUNSET 	- 1)
			newTime = "AFTERNOON"
		if (CYCLE_SUNSET 	to CYCLE_NIGHTTIME - 1)
			newTime = "SUNSET"
		else
			newTime = "NIGHTTIME"

	if (newTime != currentTime)
		//message_admins("new time bracket triggered /datum/controller/subsystem/nightcycle/proc/nextBracket() Time:[Time] newTime:[newTime]")
		currentTime = newTime
		updateLight(currentTime)
		/*if(newTime == "MORNING") //Only change lamps when we need to
			for(var/obj/structure/lamp_post/LP in GLOB.lamppost)
				LP.icon_state = "[initial(LP.icon_state)]"
				LP.set_light(0)
		else if(newTime == "SUNSET")
			for(var/obj/structure/lamp_post/LP in GLOB.lamppost)
				LP.icon_state = "[initial(LP.icon_state)]-on"
				LP.set_light(LP.on_range,LP.on_power,LP.light_color)*/
		. = TRUE
	else
		//message_admins("/datum/controller/subsystem/nightcycle/proc/nextBracket() Time:[Time] newTime:[newTime]")

/datum/controller/subsystem/nightcycle/proc/doWork()
	update_line(currentZLevel)
	/*for(var/curz = 1, curz <= world.maxz, curz++)
		update_line(curz)*/

// TODO(wso): Figure out what modern lighting should be doing here
/datum/controller/subsystem/nightcycle/proc/update_line(var/z_level)
	return
// 	var/list/currentTurfs = list()
// 	var/x = min(currentColumn + doColumns, world.maxx)
// //	for (var/z in SSmapping.levels_by_trait(ZTRAIT_STATION))
// 	//HACK. Z level 2 is always surface and nobody sets their fucking traits correctly.
// 	//This should be done with a ztrait for surface/subsurface
// 	var/start_turf = locate(x,world.maxy,z_level)
// 	var/end_turf = locate(x,1,z_level)

// //	currentTurfs = block(locate(currentColumn,1,z), locate(x,world.maxy,z)) //this is probably brutal on the overhead
// 	// currentTurfs = get_line(start_turf,end_turf)
// 	// for (var/turf/T in currentTurfs)
// 	// 	if(T.turf_light_range && !QDELETED(T)) //Turfs are qdeleted on changeturf
// 	// 		T.set_light(T.turf_light_range, sunPower, sunColour)

// 	currentColumn = x + 1
// 	if (currentColumn > world.maxx)
// 		currentColumn = 1
// 		currentZLevel = z_level + 1

// 	if (currentZLevel > world.maxz)
// 		currentZLevel = 1
// 		working = 0
// 		return

/datum/controller/subsystem/nightcycle/proc/set_time_of_day(time_name)
	var/new_time = 0
	switch (time_name)
		if ("SUNRISE")
			new_time = CYCLE_SUNRISE
		if ("MORNING")
			new_time = CYCLE_MORNING
		if ("DAYTIME")
			new_time = CYCLE_DAYTIME
		if ("AFTERNOON")
			new_time = CYCLE_AFTERNOON
		if ("SUNSET")
			new_time = CYCLE_SUNSET
		if("NIGHTTIME")
			new_time = CYCLE_NIGHTTIME

	if(new_time != 0)
		var/old_time = station_time()
		SSticker.gametime_offset += new_time - old_time

/datum/controller/subsystem/nightcycle/proc/updateLight(newTime)
	switch (newTime)
		if ("SUNRISE")
			sunColour = "#ffd1b3"
			sunPower = 0.3
		if ("MORNING")
			sunColour = "#fff2e6"
			sunPower = 0.5
		if ("DAYTIME")
			sunColour = "#FFFFFF"
			sunPower = 0.75
		if ("AFTERNOON")
			sunColour = "#fff2e6"
			sunPower = 0.5
		if ("SUNSET")
			sunColour = "#ffcccc"
			sunPower = 0.3
		if("NIGHTTIME")
			sunColour = "#00111a"
			sunPower = 0.20

/datum/controller/subsystem/nightcycle/proc/is_daylight()
	switch (currentTime)
		if ("SUNRISE")
			return 0
		if ("MORNING")
			return 1
		if ("DAYTIME")
			return 1
		if ("AFTERNOON")
			return 1
		if ("SUNSET")
			return 0
		if("NIGHTTIME")
			return 0

#undef CYCLE_SUNRISE
#undef CYCLE_MORNING
#undef CYCLE_DAYTIME
#undef CYCLE_AFTERNOON
#undef CYCLE_SUNSET
#undef CYCLE_NIGHTTIME
