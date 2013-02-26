InitializeAssassin()
{
	global doPoisonMalice := false
	global doThreadOfDeath := false
	global doSlipAway := false
	SetState1Name("Thread of Death")
	SetState1Value("OFF")
	OutputDebug, Assassin Initialized
}

DoActionOneAssassin(comboPoints)
{
	global doPoisonMalice
	global doThreadOfDeath
	global doSlipAway

	if (PoisonMaliceUp())
		doPoisonMalice := false
	
	if (not SlipAwayAvailable())
		doSlipAway := false
	
	if (doPoisonMalice)
		DoKeyPress(6, "6 Poison Malice")
		
	if (doThreadOfDeath && ThreadOfDeathAvailable() && not JaggedStrikeOnTarget() && not Stealthed_Ass())
		DoKeyPress(7, "7 Thread of Death")
	
	if (Stealthed_Ass())
	{
		doSlipAway := false
		DoKeyPress(2, "2 Expose Weakness (from stealth)")
		DoKeyPress(1, "1 Jagged Strike (from stealth)")
		return
	}
		
	if (doSlipAway && comboPoints < 3 && SlipAwayAvailable())
	{
		DoKeyPress(8, "8 Slip Away")
		return
	}
	
	if (comboPoints = 5)
	{
		if (ImpaleDroppingOrMissing())
			DoKeyPress("!4", "ALT-4 Impale")
		else
			DoKeyPress(3, "3 Final Blow")
	}
	else
	{
		if (ThreadOfDeathUp() && comboPoints < 4)
			DoKeyPress("!5", "ALT-5 Jagged Strike")
		else if (BackstabAvailable())
			DoKeyPress(1, "1 Backstab")
		else if (SerpentPoseUp() && SerpentStrikeAvailable() && comboPoints < 4)
			DoKeyPress("!3", "ALT-3 Serpent Strike")
		else if (PunctureDroppingOrMissing())
			DoKeyPress("!2", "ALT-2 Puncture")
		else
			DoKeyPress(1, "1 Savage Strike")
	}
}

DoTriggerAssassin(triggerNum)
{
	global doPoisonMalice
	global doThreadOfDeath
	global doSlipAway
	global doAction1
	
	if (triggerNum = 1)
		doPoisonMalice := true
	else if (triggerNum = 2)
	{
		doThreadOfDeath := not doThreadOfDeath
		if (doThreadOfDeath)
			SetState1Value("ON")
		else
			SetState1Value("OFF")

	}
	else if (triggerNum = 3)
	{
		if (doAction1)
			doSlipAway := true
		else
			DoKeyPress(8, "slip away")
	}
}
	
; functions

SlipAwayAvailable()
{
	return not IsAlertIconShowing(719, 13, 0x767A8C)
}

BackstabAvailable()
{
	return not IsAlertIconShowing(785, 11, 0x7E44B8) && not IsAlertIconShowing(657, 1169, 0x4E377C)
}

JaggedStrikeOnTarget()
{
	return IsAlertIconShowing(965, 33, 0x526EF2)
}

PoisonMaliceUp()
{
	return IsAlertIconShowing(1071, 18, 0x8FCB7B)
}

ThreadOfDeathUp()
{
	return IsAlertIconShowing(1014, 6, 0xCE4584)
}

Stealthed_Ass()
{
	return IsAlertIconShowing(1262, 7, 0x8C94B5)
}

ImpaleDroppingOrMissing()
{
	return IsAlertIconShowing(1220, 25, 0x8F8DA2)
}

PunctureDroppingOrMissing()
{
	return IsAlertIconShowing(1174, 31, 0xADAA73)
}

ThreadOfDeathAvailable()
{
	return not IsAlertIconShowing(820, 9, 0xAA3865)
}

SerpentStrikeAvailable()
{
	return not IsAlertIconShowing(870, 12, 0x16A994)
}

SerpentPoseUp()
{
	return IsAlertIconShowing(1117, 18, 0x009ADE)
}