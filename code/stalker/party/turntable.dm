/*
/mob/var/datum/hear_music/hear_music
#define NONE_MUSIC 0
#define UPLOADING 1
#define PLAYING 2

/datum/hear_music
	var/mob/target = null
	//var/stalker/sound/sound
	var/status = NONE_MUSIC
	var/stop = 0

	proc/play(stalker/sound/S)
		status = NONE_MUSIC
		if(!target)
			return
		if(!S)
			return
		status = UPLOADING
		target << browse_rsc(S)
		//sound = S
		if(target.hear_music != src)
			qdel(src)
		if(!stop)
			target << S
			status = PLAYING
		else
			qdel(src)

	proc/stop()
		if(!target)
			return
		if(status == PLAYING)
			var/stalker/sound/S = sound(null)
			S.channel = 10
			S.wait = 1
			target << S
			qdel(src)
		else if(status == UPLOADING)
			stop = 1
		target.hear_music = null

*/

/datum/data/turntable_soundtrack
	var/f_name
	var/path
	var/length

/datum/data/turntable_soundtrack/New(f_name, name, path, length)
	src.f_name = f_name
	src.name = name
	src.path = path
	src.length = length

/obj/machinery/party/turntable
	name = "Jukebox"
	desc = "A jukebox is a partially automated music-playing device that will play a patron's selection from self-contained media. This one is modeled after a radio and takes payment."
	icon = 'icons/stalker/lasers2.dmi'
	icon_state = "radio1"
	//var/timer_id = 0
	var/transition = 0
	var/play_song_cost = 500
	var/skip_song_cost = 250
	var/start_time = 0
	var/collected_money = 0
	var/obj/item/disk/music/disk
	var/playing = 1
	var/datum/data/turntable_soundtrack/track = null
	var/datum/data/turntable_soundtrack/next_track = null
	var/volume = 37
	var/list/mob/melomans = list()
	var/list/turntable_soundtracks = list(

		new /datum/data/turntable_soundtrack ("5nizza",				"Ya Soldat",						'sound/stalker/turntable/5nizza_ya_soldat.ogg',						2110),
		new /datum/data/turntable_soundtrack ("Zhaman",				"Brother don't fall asleep",		'sound/stalker/turntable/dontfallasleep.ogg',						2110),
		new /datum/data/turntable_soundtrack ("7B",					"Molodie Vetra",					'sound/stalker/turntable/semb_molodie_vetra.ogg',					2610),
		new /datum/data/turntable_soundtrack ("Addaraya",			"Gurza Dreaming",					'sound/stalker/turntable/gurza_dreaming.ogg',						2420),
		new /datum/data/turntable_soundtrack ("Afganistan",			"Pil Glotayu",						'sound/stalker/turntable/afganistan_pil_glotayu.ogg',				3290),
		new /datum/data/turntable_soundtrack ("Agata Kristi",		"Kak Na Voine",						'sound/stalker/turntable/agata_kristi_na_voine.ogg',				2470),
		new /datum/data/turntable_soundtrack ("Alai Oli",			"Krilya",							'sound/stalker/turntable/alai_oli_krilya.ogg',						2150),
		new /datum/data/turntable_soundtrack ("Ariya",				"Bespechniy Angel",					'sound/stalker/turntable/ariya_bespechniy_angel.ogg',				2380),
		new /datum/data/turntable_soundtrack ("Ariya",				"Potyeraniy Ray",					'sound/stalker/turntable/ariya_poteryaniy_ray.ogg',					3530),
		new /datum/data/turntable_soundtrack ("Ariya",				"Ya Svoboden",						'sound/stalker/turntable/ariya_ya_svoboden.ogg',					3540),
		new /datum/data/turntable_soundtrack ("Bandits",			"Cheeki Breeki",					'sound/stalker/turntable/bandit_radio.ogg',							1110),
		new /datum/data/turntable_soundtrack ("Hoot",				"Pre-Release Moment",				'sound/stalker/turntable/hoot.ogg',									2110),
		new /datum/data/turntable_soundtrack ("Basta",				"Mama",								'sound/stalker/turntable/basta_mama.ogg',							2360),
		new /datum/data/turntable_soundtrack ("Bi2",				"Polkovnik",						'sound/stalker/turntable/bi2_polkovnik.ogg',						2900),
		new /datum/data/turntable_soundtrack ("Bi2",				"Serebro",							'sound/stalker/turntable/bi2_serebro.ogg',							2770),
		new /datum/data/turntable_soundtrack ("Bi2",				"Varvara",							'sound/stalker/turntable/bi2_varvara.ogg',							2990),
		new /datum/data/turntable_soundtrack ("Butirka",			"Butirskaya Turma",					'sound/stalker/turntable/butirka.ogg',								1920),
		new /datum/data/turntable_soundtrack ("Dispetchera",		"2000 Baksov",						'sound/stalker/turntable/2000_baksov.ogg',							2430),
		new /datum/data/turntable_soundtrack ("DDT",				"Osen",								'sound/stalker/turntable/ddt_osen.ogg',								2350),
		new /datum/data/turntable_soundtrack ("Delfin",				"Nadezhda",							'sound/stalker/turntable/delfin_nadezhda.ogg',						2690),
		new /datum/data/turntable_soundtrack ("Delfin",				"Sneg",								'sound/stalker/turntable/delfin_sneg.ogg',							1820),
		new /datum/data/turntable_soundtrack ("Delfin",				"Vesna",							'sound/stalker/turntable/delfin_vesna.ogg',							2910),
		new /datum/data/turntable_soundtrack ("Delfin",				"Ya Lublu Ludey",					'sound/stalker/turntable/delfin_ya_lublu_ludey.ogg',				2120),
		new /datum/data/turntable_soundtrack ("Electroforez",		"Eshafot",							'sound/stalker/turntable/elektroforez_eshafot.ogg',					2090),
		new /datum/data/turntable_soundtrack ("Elizium",			"Stoit Zhit",						'sound/stalker/turntable/elizium_stoit_zhit.ogg',					1800),
		new /datum/data/turntable_soundtrack ("Fleetwood Mac",		"Little Lies",						'sound/stalker/turntable/fleetwood_mac_little_lies.ogg',			2210),
		new /datum/data/turntable_soundtrack ("Firelake",			"Fighting Unknown",					'sound/stalker/turntable/agroprom.ogg',								710),
		new /datum/data/turntable_soundtrack ("Firelake",			"Dirge For The Planet",				'sound/stalker/turntable/dirge_for_the_planet.ogg',					2850),
		new /datum/data/turntable_soundtrack ("Firelake",			"Live To Forget",					'sound/stalker/turntable/live_to_forget.ogg',						2960),
		new /datum/data/turntable_soundtrack ("Freedom",			"Smoke Weed",						'sound/stalker/turntable/freedom_radio.ogg',						1140),
		new /datum/data/turntable_soundtrack ("Gazmanov M",			"Putana",							'sound/stalker/turntable/putana.ogg',								2460),
		new /datum/data/turntable_soundtrack ("Krug M",				"Kolschik",							'sound/stalker/turntable/kolshik.ogg',								2850),
		new /datum/data/turntable_soundtrack ("Kino",				"Gruppa Krovy",						'sound/stalker/turntable/kino_gruppa_krovi.ogg',					2030),
		new /datum/data/turntable_soundtrack ("Kino",				"Pachka Sigarett",					'sound/stalker/turntable/kino_pachka_sigaret.ogg',					2780),
		new /datum/data/turntable_soundtrack ("Kino",				"Zvezda Po Imeni Soltnse",			'sound/stalker/turntable/kino_zvezda_po_imeni_solntse.ogg',			2245),
		new /datum/data/turntable_soundtrack ("Korol I Shut",		"Kukla kolduna",					'sound/stalker/turntable/korol_i_shut_kukila_kolduna.ogg',			2040),
		new /datum/data/turntable_soundtrack ("Korol I Shut",		"Lesnik",							'sound/stalker/turntable/korol_i_shut_lesnik.ogg',					1910),
		new /datum/data/turntable_soundtrack ("Kraski",				"Mama ya polubila bandita",			'sound/stalker/turntable/kraski_ya_polubila_bandita.ogg',			2020),
		new /datum/data/turntable_soundtrack ("Krovostok",			"Kurtec",							'sound/stalker/turntable/krovostok_kurtec.ogg',						2400),
		new /datum/data/turntable_soundtrack ("Leps G",				"Rumka Vodki Na Stole",				'sound/stalker/turntable/rumka.ogg',								2360),
		new /datum/data/turntable_soundtrack ("Leprikonsy",			"Hali-Gali, Paratruper",			'sound/stalker/turntable/leprikonsy_paratruper.ogg',				2060),
		new /datum/data/turntable_soundtrack ("Lumen",				"Sid i Nensi",						'sound/stalker/turntable/lumen_sid_i_nensi.ogg',					2340),
		new /datum/data/turntable_soundtrack ("Malchishnik",		"V poslendiy raz",					'sound/stalker/turntable/malchishnik_posledniy_raz.ogg',			3350),
		new /datum/data/turntable_soundtrack ("Mnogotochie",		"Shemit v dushe toska",				'sound/stalker/turntable/mnogotochie_shemit.ogg',					2310),
		new /datum/data/turntable_soundtrack ("Monokini",			"Adrenalin",						'sound/stalker/turntable/monokini_adrenalin.ogg',					1970),
		new /datum/data/turntable_soundtrack ("Monokini",			"Dotyanusya Do Solntsa",			'sound/stalker/turntable/monokini_dotyanutsya_do_solntsa.ogg',		1600),
		new /datum/data/turntable_soundtrack ("Mucuraev",			"O Allah",							'sound/stalker/turntable/mucuraev_o_allah.ogg',						3970),
		new /datum/data/turntable_soundtrack ("Mumiy Troll",		"Delfiny",							'sound/stalker/turntable/mumiy_troll_delfiny.ogg',					2780),
		new /datum/data/turntable_soundtrack ("Mumiy Troll",		"Utekay",							'sound/stalker/turntable/mumiy_troll_utekay.ogg',					1410),
		new /datum/data/turntable_soundtrack ("Mumiy Troll",		"Vladivostok 2000",					'sound/stalker/turntable/mumiy_troll_vladivostok2000.ogg',			1610),
		new /datum/data/turntable_soundtrack ("Nautilus Pomilius",	"Apostol Andrey",					'sound/stalker/turntable/nautilus_pompilius_apostol_andrey.ogg',	2170),
		new /datum/data/turntable_soundtrack ("Nautilus Pomilius",	"Krylya",							'sound/stalker/turntable/nautilus_pompilius_krylya.ogg',			2080),
		new /datum/data/turntable_soundtrack ("Nautilus Pomilius",	"Skovanie",							'sound/stalker/turntable/nautilus_pompilius_skovanye.ogg',			2530),
		new /datum/data/turntable_soundtrack ("Nautilus Pomilius",	"Ya hochu byt s toboy",				'sound/stalker/turntable/nautilus_pompilius_ya_hochu_byt_s_toboy.ogg',2710),
		new /datum/data/turntable_soundtrack ("Narodnaya Russkaya",	"Kaztosky Kick",					'sound/stalker/turntable/tf2_kazotsky_kic.ogg',						670),
		new /datum/data/turntable_soundtrack ("Noggano",			"Armiya",							'sound/stalker/turntable/noggano_armiya.ogg',						3890),
		new /datum/data/turntable_soundtrack ("Okean Elzi",			"Obime",							'sound/stalker/turntable/okean_elzi_obime.ogg',						2260),
		new /datum/data/turntable_soundtrack ("Okean Elzi",			"Vidpusti",							'sound/stalker/turntable/okean_elzi_vidpusti.ogg',					2300),
		new /datum/data/turntable_soundtrack ("Phil Collins",		"In The Air Tonight",				'sound/stalker/turntable/phil_collins_in_the_air_tonight.ogg',		3300),
		new /datum/data/turntable_soundtrack ("Propaganda",			"Belim Melom",						'sound/stalker/turntable/propaganda_belim_melom.ogg',				1740),
		new /datum/data/turntable_soundtrack ("Ranetki",			"O tebe",							'sound/stalker/turntable/ranetki_o_tebe.ogg',						1650),
		new /datum/data/turntable_soundtrack ("Ranetki",			"Ona odna",							'sound/stalker/turntable/ranetki_ona_odna.ogg',						1640),
		new /datum/data/turntable_soundtrack ("Rick Astley",		"Never Gonna Give You Up",			'sound/stalker/turntable/rick_astley_nggyu.ogg',					2120),
		new /datum/data/turntable_soundtrack ("Rozenbaum A",		"Dagomis",							'sound/stalker/turntable/gopstop.ogg',								2450),
		new /datum/data/turntable_soundtrack ("Shnurov",			"Mobilnik",							'sound/stalker/turntable/shnurov_mobilnik.ogg',						1680),
		new /datum/data/turntable_soundtrack ("Shnurov",			"Privet Morrikone",					'sound/stalker/turntable/shnurov_morikone.ogg',						2230),
		new /datum/data/turntable_soundtrack ("Splin",				"Mi sideli i kurili",				'sound/stalker/turntable/splin_mi_sideli_i_kurili.ogg',				1980),
		new /datum/data/turntable_soundtrack ("Splin",				"Moe Serdce",						'sound/stalker/turntable/splin_moe_serdce.ogg',						2440),
		new /datum/data/turntable_soundtrack ("Splin",				"Romans",							'sound/stalker/turntable/splin_romans.ogg',							2070),
		new /datum/data/turntable_soundtrack ("Splin",				"Vihoda net",						'sound/stalker/turntable/splin_vihoda_net.ogg',						2230),
		new /datum/data/turntable_soundtrack ("Steklovata",			"Noviy God",						'sound/stalker/turntable/steklovata_noviy_god.ogg',					2380),
		new /datum/data/turntable_soundtrack ("Total",				"Byet Po Glazam Adrenalin",			'sound/stalker/turntable/total_byet_po_glazam_adrenalin.ogg',		2530),
		new /datum/data/turntable_soundtrack ("Trubetskoy",			"Kapital",							'sound/stalker/turntable/trubetskoy_kapital.ogg',					2000),
		new /datum/data/turntable_soundtrack ("XS-project",			"Kolotushki",						'sound/stalker/turntable/xsproject_kolotushki.ogg',					1610),
		new /datum/data/turntable_soundtrack ("Zemfira",			"Hochesh?",							'sound/stalker/turntable/zemfira_hochesh.ogg',						1920),
		new /datum/data/turntable_soundtrack ("Zhuki",				"Batareyka",						'sound/stalker/turntable/zhuki_batareyka.ogg',						2240),
		new /datum/data/turntable_soundtrack ("Zemlyane",			"Zemlya V Illuminatore",			'sound/stalker/turntable/zemlyane_zemlya_v_illuminatore.ogg',		2330),
		new /datum/data/turntable_soundtrack ("Blonde Redhead",		"For The Damaged Soda",				'sound/stalker/turntable/blonde.ogg',								2488),
		new /datum/data/turntable_soundtrack ("Yakui The Maid",		"Chloramine",						'sound/stalker/turntable/ytm_chloramine.ogg',						2337),
		new /datum/data/turntable_soundtrack ("Yakui The Maid",		"Calamity",							'sound/stalker/turntable/ytm_calamity.ogg',							2481),
		new /datum/data/turntable_soundtrack ("Yakui The Maid x Ozoi The Maid",		"Unreleased",		'sound/stalker/turntable/ytmxotm_unr.ogg',							2444),
		new /datum/data/turntable_soundtrack ("Vladimir Vasilkov",	"Woodpeckers Dont Get Headaches",	'sound/stalker/turntable/woodpeckersdontgetheadaches.ogg',					1110),
		new /datum/data/turntable_soundtrack ("Soyol Erdene",		"The First Snow",					'sound/stalker/turntable/soyolerdene_thefirstsnow.ogg',						1110),
		new /datum/data/turntable_soundtrack ("Molchat Doma",		"Tancevat",							'sound/stalker/turntable/molchatdoma_tancevat.ogg',							1110),
		new /datum/data/turntable_soundtrack ("England",			"No Other Way",						'sound/stalker/turntable/england_nootherway.ogg',							1110),
		new /datum/data/turntable_soundtrack ("Space",				"Ballad for Space Lovers",			'sound/stalker/turntable/space_balladforspacelovers.ogg',					1110),
		new /datum/data/turntable_soundtrack ("Venetian Snares",	"Black Sabbath",					'sound/stalker/turntable/Snares-BlackSabbath.ogg',							1110),
		new /datum/data/turntable_soundtrack ("Glintshake",			"Steppe is the Place",				'sound/stalker/turntable/Glintshake_SteppeisthePlace.ogg',					1110)
	)
	anchored = 1
	density = 1

/obj/machinery/party/turntable/New()
	..()
	spawn(5)
		turntable_soundtracks = sortSoundtrack(turntable_soundtracks)
/*
	turntable_soundtracks = list()
	for(var/i in subtypesof(/datum/turntable_soundtrack/)
		var/datum/turntable_soundtrack/D = new i()
		if(D.path)
			turntable_soundtracks += D
*/

/obj/machinery/party/turntable/attackby(obj/O, mob/user)
	if(istype(O, /obj/item/disk/music) && !disk)
		user.dropItemToGround()
		O.loc = src
		disk = O
		attack_hand(user)


/obj/machinery/party/turntable/attack_paw(user as mob)
	return src.attack_hand(user)

/obj/machinery/party/turntable/attack_hand(mob/living/user as mob)
	if (..())
		return

	if(!ishuman(user))
		return

	var/mob/living/carbon/human/H = user

	interact(H)

/obj/machinery/party/turntable/ui_interact(var/mob/living/carbon/human/H)

	if(!istype(H.wear_id, /obj/item/stalker_pda))
		say("Put on your PDA.")
		return

	var/obj/item/stalker_pda/KPK = H.wear_id

	if(!KPK.profile || !KPK.owner)
		say("Activate your PDA profile.")
		return

	if(KPK.owner != H)
		say("No access.")
		return

	H.set_machine(src)
	//balance = KPK.profile.fields["money"]

	var/dat
	dat +="<div class='statusDisplay'>"
	dat += "Now playing: <b>[track.f_name] - [track.name]</b>"
	//dat += "Balance: [balance] р.<br>"
	dat += "<br>"
	if(KPK.profile.fields["faction_s"] == "Traders")
		dat += "<br><A href='?src=\ref[src];collect_money=\ref[src]'>Collect Money</A>"
		dat += "<br><A href='?src=\ref[src];change_volume=\ref[src]'>Change Volume</A>"
		if(playing)
			dat += "<br><A href='?src\ref[src];turn_off=\ref[src]'>Turn Off</A>"
		else
			dat += "<br><A href='?src\ref[src];turn_on=\ref[src]'>Turn On</A>"
	dat += "<br><A href='?src=\ref[src];skip=\ref[src]'>Skip</A> - <b>[skip_song_cost] RU</b>"
	dat += "<br>Play your song - <b>[play_song_cost] RU</b>"
	dat += "<br>Volume: <b>[volume]%</b>"
	dat += "</div>"
	dat += "<div class='lenta_scroll'>"
	dat += "<br><BR><table border='0' width='400'>"
	for(var/datum/data/turntable_soundtrack/TS in turntable_soundtracks)
		dat += "<tr><td>[TS.f_name]</td><td>[TS.name]</td><td><A href='?src=\ref[src];order=\ref[TS]'>PLAY</A></td></tr>"
	dat += "</table>"
	dat += "</div>"

	var/datum/browser/popup
	if(KPK.profile.fields["faction_s"] != "Traders")
		popup = new(H, "jukebox", "Jukebox", 450, 700)
	else
		popup = new(H, "jukebox", "Jukebox", 460, 760)
	popup.set_content(dat)
	popup.open()
	return

/obj/machinery/party/turntable/power_change()
	return ..()


/obj/machinery/party/turntable/Topic(href, href_list)
	if(..())
		return

	var/mob/living/carbon/human/H = usr

	if(!istype(H.wear_id, /obj/item/stalker_pda))
		say("Put on your PDA.")
		updateUsrDialog()
		return

	var/obj/item/stalker_pda/KPK = H.wear_id

	if(href_list["collect_money"])
		switch(alert("Do you want to transfer [collected_money]RU to your account?", "Turntable", "Yes", "No"))
			if("Yes")
				KPK.profile.fields["money"] += collected_money
				collected_money = 0
			if("No")
				return

	if(href_list["change_volume"])
		set_volume(input("Choose new volume.", "Turntable", src.volume) as num)
		return

	if(href_list["order"])
		var/datum/data/turntable_soundtrack/TS = locate(href_list["order"])

		if(!playing)
			say("Jukebox is turned off.")
			return

		if(transition)
			return

		if(alert("Do you want to play [TS.name] for [play_song_cost] RU?", "Turntable", "Yes", "No") == "No")
			return

		if(next_track)
			say("Next song is already picked: [next_track.f_name] - [next_track.name]")
			return

		if (!TS)
			updateUsrDialog()
			return

		if(play_song_cost > KPK.profile.fields["money"])
			say("You don't have enough money to order a song.")
			updateUsrDialog()
			return

		//deltimer(timer_id)
		//skip_song(TS)

		next_track = TS
		say("Playing next: [next_track.f_name] - [next_track.name]")

		KPK.profile.fields["money"] -= play_song_cost
		collected_money += play_song_cost
		return

	if(href_list["skip"])

		if(!playing)
			say("Jukebox is turned off.")
			return

		if(skip_song_cost > KPK.profile.fields["money"])
			say("You don't have enough money to skip a song.")
			updateUsrDialog()
			return

		if(alert("Skip [track.name] for [skip_song_cost] RU?", "Turntable", "Yes", "No") == "No")
			return

		//deltimer(timer_id)
		skip_song(next_track)

		KPK.profile.fields["money"] -= skip_song_cost
		collected_money += skip_song_cost
		return

	if(href_list["set_volume"])
		set_volume(text2num(href_list["set_volume"]))
		return

	if(href_list["turn_off"])
		turn_off()
		return

	if(href_list["turn_on"])
		turn_on()
		return
/*
	if(href_list["eject"])
		if(disk)
			disk.loc = src.loc
			if(disk.data && track == disk.data)
				turn_off()
				track = null
			disk = null
		return
*/
/obj/machinery/party/turntable/process()
	if(playing)
		update_sound()

/obj/machinery/party/turntable/proc/skip_song(var/datum/data/turntable_soundtrack/TS = pick(turntable_soundtracks - track))
	next_track = null
	var/area/A = get_area(src)
	transition = 1
	for(var/client/C in melomans)
		if(!C || !(C.mob))
			continue

		if(!playing || (get_area(C.mob) != A))
			continue

		C.music_juke.status = SOUND_STREAM
		C.music_juke.file = null
		C.mob << C.music_juke
		sleep(0)
		C.music_juke.status = SOUND_STREAM
		C.music_juke.file = 'sound/stalker/objects/radio_noise.ogg'
		C.music_juke.volume = volume
		C.mob << C.music_juke
	sleep(40)
	transition = 0
	//timer_id = addtimer(src, "skip_song", TS.length - 10)
	track = TS
	say("Now playing: [track.f_name] - [track.name]")
	start_time = world.timeofday
	//update_sound()

/obj/machinery/party/turntable/proc/turn_on(var/datum/data/turntable_soundtrack/selected)
	if(playing)
		return

	playing = 1

	if(selected)
		skip_song(selected)
	else
		skip_song()

	//MusicSwitch()
	var/area/A = get_area(src)
	for(var/obj/machinery/party/lasermachine/L in A)
		L.turnon(L.dir)

/obj/machinery/party/turntable/proc/turn_off()
	if(!playing)
		return

	//deltimer(timer_id)
	//timer_id = 0

	for(var/client/C in melomans)
		//C.jukeboxplaying = 0
		if(C.mob)
			C.mob << sound(null, channel = CHANNEL_JUKEBOX, wait = 0)
		melomans.Remove(C)

	playing = 0

	var/area/A = get_area(src)
	for(var/obj/machinery/party/lasermachine/L in A)
		L.turnoff()

/obj/machinery/party/turntable/proc/set_volume(var/new_volume)
	volume = max(0, min(100, new_volume))
	//if(playing)
	//	update_sound()

/obj/machinery/party/turntable/proc/update_sound()
	if(transition)
		return

	var/area/A = get_area(src)

	if(!track || (start_time + track.length < world.timeofday + SSobj.wait))
		skip_song()

	for(var/client/C in GLOB.clients)

		if(!C || !C.mob)
			continue

		if(get_area(C.mob) != A)
			continue

		//if(!C.mob.client.jukeboxplaying)
		if(!(C.mob.client in melomans))
			//create_sound(C.mob)
			//C.mob.music.volume = volume
			//C.mob << C.mob.music
			//C.jukeboxplaying = 1
			melomans.Add(C)

	for (var/client/C in melomans)
		//var/inRange = (get_area(C.mob) in A.related)

		if(!C)
			melomans -= C
			continue

		if(!(C.mob))
			C << sound(null, channel = CHANNEL_JUKEBOX, wait = 0)
			melomans.Remove(C)
			continue

		if(!playing || (get_area(C.mob) != A))
			if(C.music_juke)
				C.music_juke.status = SOUND_STREAM | SOUND_UPDATE
				C.music_juke.volume = 0
				C.mob << C.music_juke
				C.music_juke.status = SOUND_STREAM
			else
				C.mob << sound(null, channel = CHANNEL_JUKEBOX, wait = 0)
			//C.jukeboxplaying = 0
			melomans.Remove(C)
			continue

		if(!C.music_juke)
			create_sound(C)
			continue

		if(!C.music_juke.transition && C.music_juke.file != track.path)
			C.music_juke.file = track.path
		//	C.mob.music.status = SOUND_STREAM
		else
			C.music_juke.status = SOUND_STREAM | SOUND_UPDATE

		C.music_juke.volume = volume
		C.mob << C.music_juke
		C.music_juke.status = SOUND_STREAM

/obj/machinery/party/turntable/proc/create_sound(client/C)
	var/area/A = get_area(src)
	if(!C.music_juke || C.music_juke.file != track.path)
		var/sound/S = new/sound/ambient(track.path)
		S.repeat = 0
		S.channel = CHANNEL_JUKEBOX
		S.falloff = 2
		S.wait = 0
		S.volume = 0
		S.status = SOUND_STREAM //SOUND_STREAM
		S.environment = A.environment
		C.music_juke = S
		C.mob << S
		//SEND_SOUND(C.mob, S)
	else
		C.music_juke.status = SOUND_STREAM | SOUND_UPDATE
		C.music_juke.volume = volume
		C.mob << C.music_juke
		C.music_juke.status = SOUND_STREAM

/obj/machinery/party/mixer
	name = "mixer"
	desc = "A mixing board for mixing music"
	icon = 'icons/stalker/lasers2.dmi'
	icon_state = "mixer"
	density = 0
	anchored = 1

/obj/machinery/party/lasermachine
	name = "laser machine"
	desc = "A laser machine that shoots lasers."
	icon = 'icons/stalker/lasers2.dmi'
	icon_state = "lasermachine"
	dir = 4
	anchored = 1
	var/mirrored = 0

/obj/effect/laser2
	name = "laser"
	desc = "A laser..."
	icon = 'icons/stalker/lasers2.dmi'
	icon_state = "laserred1"
	anchored = 1
	layer = 4

/obj/machinery/party/lasermachine/proc/turnon(laser_dir)
	var/wall = 0
	var/cycle = 1
	var/area/A = get_area(src)
	var/X = 1
	var/Y = 0
	if(mirrored == 0)
		while(wall == 0)
			if(cycle == 1)
				var/obj/effect/laser2/F = new/obj/effect/laser2(src)
				F.x = src.x+X
				F.y = src.y+Y
				F.z = src.z
				F.dir = laser_dir
				F.icon_state = "laserred1"
				var/area/AA = get_area(F)
				var/turf/T = get_turf(F)
				if(T.density == 1 || AA.name != A.name)
					qdel(F)
					return
				cycle++
				if(cycle > 3)
					cycle = 1
				X++
			if(cycle == 2)
				var/obj/effect/laser2/F = new/obj/effect/laser2(src)
				F.x = src.x+X
				F.y = src.y+Y
				F.z = src.z
				F.dir = laser_dir
				F.icon_state = "laserred2"
				var/area/AA = get_area(F)
				var/turf/T = get_turf(F)
				if(T.density == 1 || AA.name != A.name)
					qdel(F)
					return
				cycle++
				if(cycle > 3)
					cycle = 1
				Y++
			if(cycle == 3)
				var/obj/effect/laser2/F = new/obj/effect/laser2(src)
				F.x = src.x+X
				F.y = src.y+Y
				F.z = src.z
				F.dir = laser_dir
				F.icon_state = "laserred3"
				var/area/AA = get_area(F)
				var/turf/T = get_turf(F)
				if(T.density == 1 || AA.name != A.name)
					qdel(F)
					return
				cycle++
				if(cycle > 3)
					cycle = 1
				X++
	if(mirrored == 1)
		while(wall == 0)
			if(cycle == 1)
				var/obj/effect/laser2/F = new/obj/effect/laser2(src)
				F.x = src.x+X
				F.y = src.y-Y
				F.z = src.z
				F.icon_state = "laserred1m"
				var/area/AA = get_area(F)
				var/turf/T = get_turf(F)
				if(T.density == 1 || AA.name != A.name)
					qdel(F)
					return
				cycle++
				if(cycle > 3)
					cycle = 1
				Y++
			if(cycle == 2)
				var/obj/effect/laser2/F = new/obj/effect/laser2(src)
				F.x = src.x+X
				F.y = src.y-Y
				F.z = src.z
				F.icon_state = "laserred2m"
				var/area/AA = get_area(F)
				var/turf/T = get_turf(F)
				if(T.density == 1 || AA.name != A.name)
					qdel(F)
					return
				cycle++
				if(cycle > 3)
					cycle = 1
				X++
			if(cycle == 3)
				var/obj/effect/laser2/F = new/obj/effect/laser2(src)
				F.x = src.x+X
				F.y = src.y-Y
				F.z = src.z
				F.icon_state = "laserred3m"
				var/area/AA = get_area(F)
				var/turf/T = get_turf(F)
				if(T.density == 1 || AA.name != A.name)
					qdel(F)
					return
				cycle++
				if(cycle > 3)
					cycle = 1
				X++



/obj/machinery/party/lasermachine/proc/turnoff()
	var/area/A = src.loc.loc
	for(var/area/RA in A.related)
		for(var/obj/effect/laser2/F in RA)
			qdel(F)

/obj/machinery/party/lasermachine/Move()
	..()
	turnon(src.dir)
