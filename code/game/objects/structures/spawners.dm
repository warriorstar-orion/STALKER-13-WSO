// STALKER Variants
/*
/obj/structure/spawner/stalker/rat
	name = "rat den"
	desc = "A hole dug into the ground, harboring all kinds of monsters found within the Zone."
	icon_state = "hole"
	max_mobs = 4
	spawn_time = 900
	icon = 'icons/mob/nest.dmi'
	spawn_text = "scurries out of"
	mob_types = list(/mob/living/simple_animal/hostile/mutant/rat)
	faction = list("stalker_mutants1", "monolith_forces")

/obj/structure/spawner/stalker/rat/swarm
	name = "rat den"
	desc = "A hole dug into the ground, harboring all kinds of monsters found within the Zone."
	icon_state = "hole"
	max_mobs = 6
	spawn_time = 900
	icon = 'icons/mob/nest.dmi'
	spawn_text = "scurries out of"
	mob_types = list(/mob/living/simple_animal/hostile/mutant/rat)
	faction = list("stalker_mutants1", "monolith_forces")
*/
/obj/structure/spawner/stalker/flesh
	name = "flesh den"
	desc = "A hole dug into the ground, harboring all kinds of monsters found within the Zone."
	icon_state = "hole"
	max_mobs = 4
	spawn_time = 900
	icon = 'icons/mob/simple/lavaland/nest.dmi'
	spawn_text = "crawls out of"
	mob_types = list(/mob/living/simple_animal/hostile/mutant/flesh)
	faction = list("stalker_mutants1", "monolith_forces")

/obj/structure/spawner/stalker/boar
	name = "boar den"
	desc = "A hole dug into the ground, harboring all kinds of monsters found within the Zone."
	icon_state = "hole"
	max_mobs = 3
	spawn_time = 900
	icon = 'icons/mob/simple/lavaland/nest.dmi'
	spawn_text = "crawls out of"
	mob_types = list(/mob/living/simple_animal/hostile/mutant/boar)
	faction = list("stalker_mutants1", "monolith_forces")

/obj/structure/spawner/stalker/snork
	name = "snork den"
	desc = "A hole dug into the ground, harboring all kinds of monsters found within the Zone."
	icon_state = "hole"
	max_mobs = 3
	spawn_time = 900
	icon = 'icons/mob/simple/lavaland/nest.dmi'
	spawn_text = "crawls out of"
	mob_types = list(/mob/living/simple_animal/hostile/mutant/snork)
	faction = list("stalker_mutants1", "monolith_forces")

/obj/structure/spawner/stalker/dog
	name = "dog den"
	desc = "A hole dug into the ground, harboring all kinds of monsters found within the Zone."
	icon_state = "hole"
	max_mobs = 4
	spawn_time = 900
	icon = 'icons/mob/simple/lavaland/nest.dmi'
	spawn_text = "crawls out of"
	mob_types = list(/mob/living/simple_animal/hostile/mutant/dog)
	faction = list("stalker_mutants1", "monolith_forces")

/obj/structure/spawner/stalker/pseudo
	name = "pseudo den"
	desc = "A hole dug into the ground, harboring all kinds of monsters found within the Zone."
	icon_state = "hole"
	max_mobs = 2
	spawn_time = 900
	icon = 'icons/mob/simple/lavaland/nest.dmi'
	spawn_text = "crawls out of"
	mob_types = list(/mob/living/simple_animal/hostile/mutant/pseudog)
	faction = list("stalker_mutants1", "monolith_forces")

/obj/structure/spawner/stalker/bloodsucker
	name = "bloodsucker den"
	desc = "A hole dug into the ground, harboring all kinds of monsters found within the Zone."
	icon_state = "hole"
	max_mobs = 2
	spawn_time = 900
	icon = 'icons/mob/simple/lavaland/nest.dmi'
	spawn_text = "crawls out of"
	mob_types = list(/mob/living/simple_animal/hostile/mutant/bloodsucker)
	faction = list("stalker_mutants1", "monolith_forces")

/obj/structure/spawner/stalker/controller
	name = "controller den"
	desc = "A hole dug into the ground, harboring all kinds of monsters found within the Zone."
	icon_state = "hole"
	max_mobs = 1
	spawn_time = 900
	icon = 'icons/mob/simple/lavaland/nest.dmi'
	spawn_text = "crawls out of"
	mob_types = list(/mob/living/simple_animal/hostile/mutant/controller)
	faction = list("stalker_mutants1", "monolith_forces")

/obj/structure/spawner/stalker/zombiesimp
	name = "zombie den"
	desc = "A hole dug into the ground, harboring all kinds of monsters found within the Zone."
	icon_state = "hole"
	max_mobs = 5
	spawn_time = 900
	icon = 'icons/mob/simple/lavaland/nest.dmi'
	spawn_text = "crawls out of"
	mob_types = list(/mob/living/simple_animal/hostile/mutant/zombiesimp,/mob/living/simple_animal/hostile/mutant/zombiesimp/ranged)
	faction = list("stalker_mutants1", "monolith_forces")

/obj/structure/spawner/stalker/allmutants
	name = "mutant den"
	desc = "A hole dug into the ground, harboring all kinds of monsters found within the Zone."
	icon_state = "hole"
	max_mobs = 4
	spawn_time = 900
	icon = 'icons/mob/simple/lavaland/nest.dmi'
	spawn_text = "crawls out of"
	mob_types = list(/mob/living/simple_animal/hostile/mutant/zombiesimp,/mob/living/simple_animal/hostile/mutant/zombiesimp/ranged,/mob/living/simple_animal/hostile/mutant/rat,/mob/living/simple_animal/hostile/mutant/flesh,/mob/living/simple_animal/hostile/mutant/boar,/mob/living/simple_animal/hostile/mutant/snork,/mob/living/simple_animal/hostile/mutant/bloodsucker)
	faction = list("stalker_mutants1", "monolith_forces")
