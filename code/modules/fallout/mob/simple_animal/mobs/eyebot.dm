//Fallout 13 eyebot directory

/mob/living/simple_animal/hostile/eyebot
	name = "eyebot"
	desc = "A hovering, propaganda-spewing reconnaissance and surveillance robot with radio antennas pointing out its back and loudspeakers blaring out the front."
	icon = 'icons/fallout/mobs/animal.dmi'
	icon_state = "eyebot"
	icon_living = "eyebot"
	icon_dead = "eyebot_d"
	icon_gib = "eyebot_d"
	speak_chance = 0
	turns_per_move = 6
	environment_smash = 0
	response_help = "touches"
	response_disarm = "shoves"
	response_harm = "hits"
	move_to_delay = 3
	stat_attack = 1
	robust_searching = 1
	maxHealth = 70
	health = 70
//	self_weight = 50
	healable = 0

	faction = list("hostile", "enclave", "wastebot", "ghoul", "cazador", "supermutant", "bighorner")

//	ambient_sound = 'sound/f13npc/eyebot_loop.ogg'

//	sound_speak_chance = 5
//	sound_speak = list('sound/machines/buzz-sigh.ogg','sound/misc/interference.ogg')

//	aggro_sound_chance = 50
//	aggro_sound = 'sound/misc/interference.ogg'

	death_sound = 'sound/f13npc/robot_death.ogg'

	harm_intent_damage = 10
	melee_damage_lower = 2
	melee_damage_upper = 3
	minimum_distance = 6
	retreat_distance = 14
	attacktext = "punches"
	attack_sound = "punch"
	a_intent = "harm"
	atmos_requirements = list("min_oxy" = 0, "max_oxy" = 0, "min_tox" = 0, "max_tox" = 0, "min_co2" = 0, "max_co2" = 0, "min_n2" = 0, "max_n2" = 0)
	unsuitable_atmos_damage = 15
	status_flags = CANPUSH
	vision_range = 13
	aggro_vision_range = 4
//	idle_vision_range = 12
	ranged = 1
	projectiletype = /obj/item/projectile/beam/laser/lasgun
	projectilesound = 'sound/weapons/resonator_fire.ogg'

/mob/living/simple_animal/hostile/eyebot/New()
	..()
	name = "ED-[rand(1,999)]"

/mob/living/simple_animal/hostile/eyebot/floatingeye
	name = "floating eyebot"
	desc = "A quick-observation robot commonly found in pre-War military installations.<br>The floating eyebot uses a powerful taser to keep intruders in line."
	icon_state = "floatingeye"
	icon_living = "floatingeye"
	icon_dead = "floatingeye_d"
	icon_gib = "floatingeye_d"

	retreat_distance = 4
	faction = list("hostile", "bs")

	projectiletype = /obj/item/projectile/energy/electrode
	projectilesound = 'sound/weapons/resonator_blast.ogg'

/mob/living/simple_animal/hostile/eyebot/floatingeye/New()
	..()
	name = "FEB-[rand(1,99)]"

/mob/living/simple_animal/hostile/eyebot/floatingeye/warden
	name = "warden"
	desc = "A quick-observation robot commonly found in pre-War military installations.<br>The floating eyebot uses a powerful taser to keep prisoners in line."
	faction = list("hostile", "bs", "enclave", "wastebot", "ghoul")//Ghoul, because pre-war IDs.

/mob/living/simple_animal/hostile/eyebot/floatingeye/warden/New()
	..()
	name = "WRD-[rand(1,99)]"

/mob/living/simple_animal/pet/dog/eyebot //It's a propaganda eyebot, not a dog, but...
	name = "propaganda eyebot"
	desc = "This eyebot's weapons module has been removed and replaced with a loudspeaker. It appears to be shouting Pre-War propaganda."
	icon = 'icons/fallout/mobs/animal.dmi'
	icon_state = "eyebot"
	icon_living = "eyebot"
	icon_dead = "eyebot_d"
	icon_gib = "eyebot_d"
	maxHealth = 60
	health = 60
	speak_chance = 8
	gender = NEUTER
	mob_biotypes = list(MOB_ROBOTIC)
	faction = list("hostile", "enclave", "wastebot", "ghoul", "cazador", "supermutant", "bighorner")
	speak = list("America will never fall to communist invasion.", "Democracy is truth. Communism is death.", "Communism is the very definition of failure!", "Freedom is always worth fighting for.", "Memorial site recognized. Patriotism subroutines engaged. Honoring the fallen is the duty of every red blooded American.", "Cultural database accessed. Quoting New England poet Robert Frost: 'Freedom lies in being bold.'", "Defending Life, Liberty, and the pursuit of Happiness.")
	speak_emote = list()
	emote_hear = list()
	emote_see = list()
	response_help  = "shakes the radio of"
	response_disarm = "pushes"
	response_harm   = "punches"
	attack_sound = 'sound/voice/liveagain.ogg'
	butcher_results = list(/obj/effect/gibspawner/robot = 1)