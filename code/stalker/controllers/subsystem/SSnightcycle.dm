/*  6:00 AM 	- 	21600
	6:45 AM 	- 	24300
	11:45 AM 	- 	42300
	4:45 PM 	- 	60300
	9:45 PM 	- 	78300
	10:30 PM 	- 	81000 */
#define TIMEOFDAY_SUNRISE      "sunrise"
#define TIMEOFDAY_MORNING      "morning"
#define TIMEOFDAY_DAYTIME      "daytime"
#define TIMEOFDAY_AFTERNOON    "afternoon"
#define TIMEOFDAY_SUNSET       "sunset"
#define TIMEOFDAY_NIGHTTIME    "nighttime"

#define CYCLE_SUNRISE 	216000
#define CYCLE_MORNING 	243000
#define CYCLE_DAYTIME 	423000
#define CYCLE_AFTERNOON 603000
#define CYCLE_SUNSET 	783000
#define CYCLE_NIGHTTIME 810000

#define STEP_SUNRISE 1
#define STEP_MORNING 2
#define STEP_DAY 3
#define STEP_AFTERNOON 4
#define STEP_SUNSET 5
#define STEP_NIGHT 6

SUBSYSTEM_DEF(nightcycle)
	name = "Day/Night Cycle"
	wait = 5 //5 ticks in between checks, this thing doesn't need to fire so fast, as it's tied to gameclock not its own ticker
	//This will also give the game time to light up the columns and not choke
	//var/flags = 0			//see MC.dm in __DEFINES Most flags must be set on world start to take full effect. (You can also restart the mc to force them to process again
	can_fire = TRUE
	var/currentTime
	flags = SS_NO_INIT
	var/currentZOffset = 1
	var/z_list = list(1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 13, 14)
	var/steps = list(new /datum/time_of_day/sunrise(), new /datum/time_of_day/morning(), new /datum/time_of_day/daytime(),
					 new /datum/time_of_day/afternoon(), new /datum/time_of_day/sunset(), new /datum/time_of_day/night())
	var/step = STEP_NIGHT // index of steps list
	var/datum/time_of_day/step_datum
	var/currentColumn
	var/working = 0
	var/doColumns //number of columns to do at a time
	var/newTime = null
	var/duration = 0

/datum/controller/subsystem/nightcycle/fire(resumed = FALSE)
	if(nextBracket())
		working = 1
		currentColumn = 1

	CHECK_TICK
	if (working)
		doWork()

/datum/controller/subsystem/nightcycle/proc/is_daylight()
	if(!step_datum)
		return FALSE
	switch (step_datum.name)
		if (TIMEOFDAY_SUNRISE, TIMEOFDAY_SUNSET, TIMEOFDAY_NIGHTTIME)
			return FALSE
		if (TIMEOFDAY_MORNING, TIMEOFDAY_MORNING, TIMEOFDAY_AFTERNOON)
			return TRUE

/datum/controller/subsystem/nightcycle/proc/nextBracket()
	if (world.time > duration)
		setNextStep()
		return TRUE

/datum/controller/subsystem/nightcycle/proc/doWork()
	var/list/currentTurfs = list()
	var/x = min(currentColumn + doColumns, world.maxx)
	var/z = z_list[currentZOffset]
	var/start_turf = locate(x,world.maxy,z)
	var/end_turf = locate(x,1,z)
	currentTurfs = get_line(start_turf,end_turf)
	for (var/turf/T in currentTurfs)
		if(istype(T, /turf/open) && !QDELETED(T)) //Turfs are qdeleted on changeturf
			T.set_light(3, step_datum.sunPower, step_datum.color)

	currentColumn = x + 1
	if (currentColumn > world.maxx)
		if (currentZOffset < length(z_list))
			currentZOffset++
			currentColumn = 1
		else
			currentZOffset = 1
			currentColumn = 1
			working = 0
		return

/datum/controller/subsystem/nightcycle/proc/setNextStep()
	if (step >= length(steps))
		step = 1
		step_datum = steps[step]
	else
		step++
		step_datum = steps[step]
	duration = world.time + step_datum.duration


/datum/controller/subsystem/nightcycle/proc/setTime(var/force_step)
	step = force_step
	step_datum = steps[step]
	duration = world.time + step_datum.duration
	working = 1
	currentColumn = 1


/datum/time_of_day
	var/name = ""
	var/color = ""
	var/duration = 300
	var/sunPower = 0

/datum/time_of_day/sunrise
	name = TIMEOFDAY_SUNRISE
	color = "#ffd1b3"
	sunPower = 0.1
	duration = 2250

/datum/time_of_day/morning
	name = TIMEOFDAY_MORNING
	color = "#fff2e6"
	sunPower = 0.4
	duration = 2250

/datum/time_of_day/daytime
	name = TIMEOFDAY_DAYTIME
	color = "#FFFFFF"
	sunPower = 0.75
	duration = 9000

/datum/time_of_day/afternoon
	name = TIMEOFDAY_AFTERNOON
	color = "#fff2e6"
	sunPower = 0.4
	duration = 2250

/datum/time_of_day/sunset
	name = TIMEOFDAY_SUNSET
	color = "#ffcccc"
	sunPower = 0.1
	duration = 2250

/datum/time_of_day/night
	name = TIMEOFDAY_NIGHTTIME
	color = "#27283d"
	sunPower = 0.1
	duration = 9000

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
