InitializeBard()
{
	global doJeopardy := false
	global doPhysicalDebuff := false
	global doMagicalDebuff := false
	SetState1Name("Jeopardy")
	SetState1Value("OFF")
	SetState2Name("Physical Debuff")
	SetState2Value("OFF")
	SetState3Name("Magic Debuff")
	SetState3Value("OFF")
	OutputDebug, Bard Initialized
}

DoClearBard()
{
}

DoActionOneBard(comboPoints)
{
	DoHealing(comboPoints, false)
}

DoActionTwoBard(comboPoints)
{
	DoDamage(comboPoints, false)
}

DoActionThreeBard(comboPoints)
{
	DoDamage(comboPoints, true)
}

DoActionFourBard(comboPoints)
{
	DoHealing(comboPoints, true)
}

DoHealing(comboPoints, doAE)
{
	global doPhysicalDebuff
	global doMagicalDebuff
	global doJeopardy

	if (not doAE && MultipleOscillationsActive())
		DoKeyPress("!8", "Cancel Multiple Osc")
	
	if (comboPoints = 5)
	{
		if (doJeopardy && JeopardyExpiring())
			DoKeyPress("!3", "Coda of Jeopardy")
		else if (doPhysicalDebuff && CowardiceExpiring())
			DoKeyPress("!4", "Coda of Cowardice")
		else if (doMagicalDebuff && DistressExpiring())
			DoKeyPress("!5", "Coda of Distress")
		else
			DoKeyPress(3, "Coda of Restoration")
	}
	else if (comboPoints = 0 && RiffAvailable())
		DoKeyPress(6, "Riff")
	else if (comboPoints > 1)
	{
		if (doJeopardy && JeopardyMissing())
		{
			DoKeyPress("!3", "Coda of Jeopardy")
			return
		}
		else if (doPhysicalDebuff && CowardiceMissing())
		{
			DoKeyPress("!4", "Coda of Cowardice")
			return
		}
		else if (doMagicalDebuff && DistressMissing())
		{
			DoKeyPress("!5", "Coda of Distress")
			return
		}
	}	
	
	if (doAE && not MultipleOscillationsActive())
		DoKeyPress(7, "Multiple Oscillations")
	else if (comboPoints = 0 && PowerChordInUnder2())
		DoKeyPress(2, "Power Chord")
	else if (not CastingCadence())
	{
		DoKeyPress(1, "Cadence")
		Sleep, 350
	}
}

DoDamage(comboPoints, doAE)
{
	global doPhysicalDebuff
	global doMagicalDebuff
	global doJeopardy

	if (not doAE && MultipleOscillationsActive())
		DoKeyPress("!8", "Cancel Multiple Osc")

	if (comboPoints = 5)
	{
		if (doJeopardy && JeopardyExpiring())
			DoKeyPress("!3", "Coda of Jeopardy")
		else if (doPhysicalDebuff && CowardiceExpiring())
			DoKeyPress("!4", "Coda of Cowardice")
		else if (doMagicalDebuff && DistressExpiring())
			DoKeyPress("!5", "Coda of Distress")
		else if (doAE)
			DoKeyPress("!6", "Coda of Fury")
		else
			DoKeyPress("!7", "Coda of Wrath")
	}
	else if (comboPoints = 0 && RiffAvailable())
		DoKeyPress(6, "Riff")
	else if (comboPoints > 1)
	{
		if (doJeopardy && JeopardyMissing())
		{
			DoKeyPress("!3", "Coda of Jeopardy")
			return
		}
		else if (doPhysicalDebuff && CowardiceMissing())
		{
			DoKeyPress("!4", "Coda of Cowardice")
			return
		}
		else if (doMagicalDebuff && DistressMissing())
		{
			DoKeyPress("!5", "Coda of Distress")
			return
		}
	}	
	
	if (doAE && not MultipleOscillationsActive())
		DoKeyPress(7, "Multiple Oscillations")
	else if (not doAE && VerseOfAgonyAvailable() && not CastingCadenza())
		DoKeyPress("-", "Verse of Agony")
	else if (comboPoints = 0 && PowerChordInUnder2())
		DoKeyPress(2, "Power Chord")
	else if (not CastingCadenza())
	{
		DoKeyPress("!2", "Cadenza")
		Sleep, 350
	}
}

DoTriggerBard(triggerNum)
{
	global doPhysicalDebuff
	global doMagicalDebuff
	global doJeopardy
	global doAction1
	global doAction2
	global doAction3
	global suspendActions
	
	suspendActions := true
	
	if (triggerNum = 1)
	{				
		While (not MotifOfBraveryUp())
		{
			DoKeyPress("!9", "Motif of Bravery")
			Sleep, 100
		}
		While (not MotifOfTenacityUp())
		{
			DoKeyPress("!0", "Motif of Tenacity")
			Sleep, 100
		}
		While (not MotifOfRegenUp())
		{
			DoKeyPress("!-", "Motif of Regen")
			Sleep, 100
		}
		
		suspendActions := false
	}
	else if (triggerNum = 2)
	{
		doJeopardy := not doJeopardy
		if (doJeopardy)
			SetState1Value("ON")
		else
			SetState1Value("OFF")
	}
	else if (triggerNum = 3)
	{
		doPhysicalDebuff := not doPhysicalDebuff
		if (doPhysicalDebuff)
			SetState2Value("ON")
		else
			SetState2Value("OFF")
	}
	else if (triggerNum = 4)
	{
		doMagicalDebuff := not doMagicalDebuff
		if (doMagicalDebuff)
			SetState3Value("ON")
		else
			SetState3Value("OFF")
	}
	else if (triggerNum = 5)
	{		
		while (VerseOfVitalityAvailable())
		{
			DoKeyPress(4, "Verse of Vitality")
			Sleep, 100
		}		
	}
	else if (triggerNum = 6)
	{
		while (OnTheDoubleAvailable_Bard())
		{
			DoKeyPress(9, "On the Double")
			Sleep, 50
		}		
	}
	else if (triggerNum = 8)
	{
		while (VerseOfOcclusionAvailable())
		{
			DoKeyPress(8, "Verse of Occlusion")
			Sleep, 100
		}
	}
	
	suspendActions := false
}

VerseOfOcclusionAvailable()
{
	return not IsAlertIconShowing(330, 18, 0xC6CBCE)
}

OnTheDoubleAvailable_Bard()
{
	return not IsAlertIconShowing(403, 18, 0x6379A2)
}

PowerChordInUnder2()
{
	return IsAlertIconShowing(1350, 11, 0xFFF08C)
}

JeopardyMissing()
{
	return IsAlertIconShowing(553, 18, 0xE4A252)
}

CowardiceMissing()
{
	return IsAlertIconShowing(493, 25, 0xE48A94)
}

DistressMissing()
{
	return IsAlertIconShowing(442, 26, 0x6BCFFF)
}

CastingCadence()
{
	return IsAlertIconShowing(919, 9, 0xCE5D6B)
}

CastingCadenza()
{
	return IsAlertIconShowing(880, 13, 0xF2BC00)
}

CowardiceExpiring()
{
	return IsAlertIconShowing(1187, 22, 0xDE8A8C)
}

DistressExpiring()
{
	return IsAlertIconShowing(1243, 26, 0x6BCFFF)
}

JeopardyExpiring()
{
	return IsAlertIconShowing(1124, 11, 0xBD9652)
}

MultipleOscillationsActive()
{
	return IsAlertIconShowing(1287, 14, 0xE4915D)
}

PowerChordAvailable()
{
	return not IsAlertIconShowing(763, 13, 0xFFCF00)
}

RiffAvailable()
{
	return not IsAlertIconShowing(598, 13, 0x94D5AC)
}

VerseOfAgonyAvailable()
{
	return not IsAlertIconShowing(801, 24, 0x3786B0)
}

VerseOfVitalityAvailable()
{
	return not IsAlertIconShowing(709, 25, 0x39CBD6)
}

MotifOfBraveryUp()
{
	return not IsAlertIconShowing(977, 21, 0x3C6FD9)
}

MotifOfRegenUp()
{
	return not IsAlertIconShowing(1038, 17, 0x1DB967)
}

MotifOfTenacityUp()
{
	return not IsAlertIconShowing(1087, 20, 0x08C7DE)
}