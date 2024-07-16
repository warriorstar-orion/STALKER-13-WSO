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
	var/list/ambient_music = list(	'stalker/sound/ambience/amb01.ogg','stalker/sound/ambience/amb02.ogg',
									'stalker/sound/ambience/amb03.ogg','stalker/sound/ambience/amb04.ogg',
									'stalker/sound/ambience/amb05.ogg','stalker/sound/ambience/amb06.ogg',
									'stalker/sound/ambience/amb07.ogg','stalker/sound/ambience/amb08.ogg',
									'stalker/sound/ambience/amb09.ogg','stalker/sound/ambience/amb10.ogg',
									'stalker/sound/ambience/amb11.ogg','stalker/sound/ambience/amb12.ogg',
									'stalker/sound/ambience/amb13.ogg','stalker/sound/ambience/amb15.ogg',
									'stalker/sound/ambience/amb16.ogg','stalker/sound/ambience/amb17.ogg',
									'stalker/sound/ambience/amb20.ogg','stalker/sound/ambience/amb21.ogg',
									'stalker/sound/ambience/amb22.ogg','stalker/sound/ambience/amb23.ogg',
									'stalker/sound/ambience/amb24.ogg','stalker/sound/ambience/amb25.ogg',
									'stalker/sound/ambience/amb26.ogg','stalker/sound/ambience/amb27.ogg',
									/*'stalker/sound/ambience/amb28.ogg',*/'stalker/sound/ambience/amb29.ogg',
									'stalker/sound/ambience/amb30.ogg','stalker/sound/ambience/amb31.ogg',
									'stalker/sound/ambience/amb32.ogg','stalker/sound/ambience/amb33.ogg',
									'stalker/sound/ambience/amb34.ogg','stalker/sound/ambience/amb35.ogg',
									'stalker/sound/ambience/amb36.ogg','stalker/sound/ambience/amb37.ogg',
									'stalker/sound/ambience/amb38.ogg')
	var/list/ambient_environment = null
	var/list/ambient_environment_night = null
	var/list/ambient_background = null
