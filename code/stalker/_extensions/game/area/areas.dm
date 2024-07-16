/area
	var/list/related
	var/environment = 0
	var/safezone = 0
	var/ecosafezone = 0
	var/banditsafezone = 0
	var/dutysafezone = 0
	var/freedomsafezone = 0
	var/renegadesafezone = 0
	var/cssafezone = 0
	var/monolithsafezone = 0
	var/militarysafezone = 0
	var/mercenarysafezone = 0
	var/controlled_by = null
	var/blowout = 0
	var/ambient_music_cooldown				= 6000
	var/ambient_environment_cooldown		= 666
	var/list/ambient_background_cooldown = null
	var/list/ambient_music = list(	'sound/stalker/ambience/amb01.ogg','sound/stalker/ambience/amb02.ogg',
									'sound/stalker/ambience/amb03.ogg','sound/stalker/ambience/amb04.ogg',
									'sound/stalker/ambience/amb05.ogg','sound/stalker/ambience/amb06.ogg',
									'sound/stalker/ambience/amb07.ogg','sound/stalker/ambience/amb08.ogg',
									'sound/stalker/ambience/amb09.ogg','sound/stalker/ambience/amb10.ogg',
									'sound/stalker/ambience/amb11.ogg','sound/stalker/ambience/amb12.ogg',
									'sound/stalker/ambience/amb13.ogg','sound/stalker/ambience/amb15.ogg',
									'sound/stalker/ambience/amb16.ogg','sound/stalker/ambience/amb17.ogg',
									'sound/stalker/ambience/amb20.ogg','sound/stalker/ambience/amb21.ogg',
									'sound/stalker/ambience/amb22.ogg','sound/stalker/ambience/amb23.ogg',
									'sound/stalker/ambience/amb24.ogg','sound/stalker/ambience/amb25.ogg',
									'sound/stalker/ambience/amb26.ogg','sound/stalker/ambience/amb27.ogg',
									/*'sound/stalker/ambience/amb28.ogg',*/'sound/stalker/ambience/amb29.ogg',
									'sound/stalker/ambience/amb30.ogg','sound/stalker/ambience/amb31.ogg',
									'sound/stalker/ambience/amb32.ogg','sound/stalker/ambience/amb33.ogg',
									'sound/stalker/ambience/amb34.ogg','sound/stalker/ambience/amb35.ogg',
									'sound/stalker/ambience/amb36.ogg','sound/stalker/ambience/amb37.ogg',
									'sound/stalker/ambience/amb38.ogg')
	var/list/ambient_environment = null
	var/list/ambient_environment_night = null
	var/list/ambient_background = null
