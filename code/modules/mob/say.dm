//Speech verbs.
/mob/verb/say_typing_indicator()
	set name = "Say"
	set hidden = FALSE
	set category = "IC"
	display_typing_indicator()
	var/message = input(usr, "", "say") as text|null
	// If they don't type anything just drop the message.
	clear_typing_indicator()		// clear it immediately!
	if(!length(message))
		return
	return say_verb(message)

/mob/verb/me_typing_indicator()
	set name = "Me"
	set hidden = FALSE
	set category = "IC"
	display_typing_indicator()
	var/message = input(usr, "", "me") as message|null
	// If they don't type anything just drop the message.
	clear_typing_indicator()		// clear it immediately!
	if(!length(message))
		return
	return me_verb(message)

/mob/verb/say_verb(message as text)
	set name = "say_noindicator"
	set hidden = TRUE
	set category = "IC"
	if(!length(message))
		return
	if(GLOB.say_disabled)	//This is here to try to identify lag problems
		to_chat(usr, "<span class='danger'>Speech is currently admin-disabled.</span>")
		return
	//SKYRAT EDIT
	set_typing_indicator(FALSE)
	//END OF SKYRAT EDIT
	if(message)
		say(message)

	clear_typing_indicator()


/mob/verb/whisper_verb(message as text)
	set name = "Whisper"
	set category = "IC"
	if(GLOB.say_disabled)	//This is here to try to identify lag problems
		to_chat(usr, "<span class='danger'>Speech is currently admin-disabled.</span>")
		return
	whisper(message)

/mob/proc/whisper(message, datum/language/language=null)
	say(message, language) //only living mobs actually whisper, everything else just talks

/mob/verb/me_verb(message as text) //Moving from message to text because single-line input boxes are more user-friendly
	set name = "me_noindicator"
	set hidden = TRUE
	set category = "IC"
	if(GLOB.say_disabled)	//This is here to try to identify lag problem
		to_chat(usr, "<span class='danger'>Speech is currently admin-disabled.</span>")
		return

	message = trim(copytext(sanitize(message), 1, MAX_MESSAGE_LEN))

	usr.emote("me",1,message,TRUE)

/mob/proc/say_dead(var/message)
	var/name = real_name
	var/alt_name = ""

	if(GLOB.say_disabled)	//This is here to try to identify lag problems
		to_chat(usr, "<span class='danger'>Speech is currently admin-disabled.</span>")
		return

	var/jb = jobban_isbanned(src, "OOC")
	if(QDELETED(src))
		return

	if(jb)
		to_chat(src, "<span class='danger'>You have been banned from deadchat.</span>")
		return

	if (src.client)
		if(src.client.prefs.muted & MUTE_DEADCHAT)
			to_chat(src, "<span class='danger'>You cannot talk in deadchat (muted).</span>")
			return

	if(!GLOB.dsay_allowed)
		to_chat(src, "<span class='danger'>Deadchat is globally muted.</span>")
		return

	if(src.client.handle_spam_prevention(message,MUTE_DEADCHAT))
		return

	var/mob/dead/observer/O = src
	if(isobserver(src) && O.deadchat_name)
		name = "[O.deadchat_name]"
	else
		if(mind && mind.name)
			name = "[mind.name]"
		else
			name = real_name
		if(name != real_name)
			alt_name = " (died as [real_name])"

	var/K

	if(key)
		K = src.key

	message = src.say_quote(message, get_spans())
	var/rendered = "<span class='game deadsay'><span class='prefix'>DEAD:</span> <span class='name'>[name]</span>[alt_name] <span class='message'>[message]</span></span>"
	log_message("DEAD: [message]", INDIVIDUAL_SAY_LOG)
	deadchat_broadcast(rendered, follow_target = src, speaker_key = K)

/proc/toggle_dsay(toggle = null)
	if(toggle != null)
		if(toggle != GLOB.dsay_allowed)
			GLOB.dsay_allowed = toggle
		else
			return
	else //otherwise just toggle it
		GLOB.dsay_allowed = !GLOB.dsay_allowed
	to_chat(world, "<B>Deadchat has been globally [GLOB.dsay_allowed ? "enabled" : "disabled"].</B>")

/mob/proc/check_emote(message)
	if(copytext(message, 1, 2) == "*")
		emote(copytext(message, 2), intentional = TRUE)
		return 1

/mob/proc/hivecheck()
	return 0

/mob/proc/lingcheck()
	return LINGHIVE_NONE

/mob/proc/get_message_mode(message)
	var/key = copytext(message, 1, 2)
	if(key == "#")
		return MODE_WHISPER
	else if(key == ";")
		return MODE_HEADSET
	else if(length(message) > 2 && (key in GLOB.department_radio_prefixes))
		var/key_symbol = lowertext(copytext(message, 2, 3))
		return GLOB.department_radio_keys[key_symbol]
