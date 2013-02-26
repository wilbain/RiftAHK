InitializeNightblade()
{
	OutputDebug, Nightblade Initialized
}

DoActionOneNightblade(comboPoints)
{
	DoKeyPress("!8", "Expose Weakness")
	
	if (InMeleeRange())
	{
		;OutputDebug, in melee range
		
		if (not Have3StacksOfFiery())
		{
			if (not FierySpikeExpiring() && comboPoints = 5)
				DoKeyPress(3, "Blazing Strike")
			else
				DoKeyPress("!2", "Fiery Spike")
		}
		else if (comboPoints = 5)
		{
			if (HeatRetentionActive() && ScourgeAvailable())
				DoKeyPress("!5", "Scourge of Darkness")
			else
				DoKeyPress(3, "Blazing Strike")
		}
		else if (FierySpikeExpiring())
			DoKeyPress("!2", "Fiery Spike")
		else if (DuskToDawnAvailable())
			DoKeyPress("!4", "Dusk to Dawn")
		else if (comboPoints < 2 && not Have5StacksOfFiery())
			DoKeyPress("!2", "Fiery Spike")
		else if (CanBackstab())
			DoKeyPress(0, "Backstab")
		else if (PunctureExpiring())
			DoKeyPress(2, "Puncture")
		else if (EbonFuryActive() || VerseOfJoyActive() || EmptinessMissing())
			DoKeyPress("!3", "Dusk Strike")
		else
			DoKeyPress(1, "Savage Strike")		
	}
	else if (InFierySpikeRange())
	{
		;OutputDebug, in fiery spike range
		
		if (not Have3StacksOfFiery())
		{
			if (not FierySpikeExpiring() && comboPoints = 5)
				DoKeyPress("!6", "Flame Thrust")
			else
				DoKeyPress("!2", "Fiery Spike")
		}
		else if (comboPoints = 5)
		{
			if (HeatRetentionActive() && ScourgeAvailable())
				DoKeyPress("!5", "Scourge of Darkness")
			else
				DoKeyPress("!6", "Flame Thrust")
		}
		else if (FierySpikeExpiring())
			DoKeyPress("!2", "Fiery Spike")
		else if (DuskToDawnAvailable())
			DoKeyPress("!4", "Dusk to Dawn")
		else if (comboPoints < 2 && not Have5StacksOfFiery())
			DoKeyPress("!2", "Fiery Spike")
		else
			DoKeyPress("!9", "Range Builder")	
	}
	else
	{
		;OutputDebug, out of fiery spike range
		
		if (comboPoints = 5 && HeatRetentionActive() && ScourgeAvailable())
			DoKeyPress("!5", "Scourge of Darkness")
		else
			DoKeyPress("!9", "Range Builder")
	}
}

DoActionTwoNightblade(comboPoints)
{
	global doDarkDescent
		
	if (FierySpikeExpiring())
		DoKeyPress("!2", "Fiery Spike")
			
	if (comboPoints = 5)
	{
		if (ScourgeAvailable() && HeatRetentionActive())
			DoKeyPress("!5", "scourge of darkness")
		else
			DoKeyPress("!7", "flame blitz")
	}
	else
		DoKeyPress(7, "weapon flare/fiery chains")
}

DoTriggerNightblade(triggerNum)
{
	global suspendActions
	
	suspendActions := true
		
	if (triggerNum = 1)
	{
		while (EbonFuryAvailable())
		{
			DoKeyPress(6, "ebon fury")
			Sleep, 100
		}
	}
	else if (triggerNum = 2)
	{
		While (TwilightTransAvailable())
		{
			DoKeyPress(4, "twilight transcendance")
			Sleep, 50
		}		
	}
	else if (triggerNum = 3)
	{
		while (OnTheDoubleAvailable_NB())
		{
			DoKeyPress(8, "On the Double")
			Sleep, 50
		}		
	}	
	
	suspendActions := false
}

InMeleeRange()
{
	return IsAlertIconShowing(941, 96, 0x67B467)
}

CanBackstab()
{
	return (IsAlertIconShowing(870, 95, 0x66B366) && not IsAlertIconShowing(776, 39, 0x733C94))
}

InFierySpikeRange()
{
	return IsAlertIconShowing(1007, 94, 0x64B264)
}

OnTheDoubleAvailable_NB()
{
	return not IsAlertIconShowing(680, 16, 0x425579)
}

TwilightTransAvailable()
{
	return not IsAlertIconShowing(700, 14, 0xE87E3A)
}

FierySpikeExpiring()
{
	return IsAlertIconShowing(866, 11, 0x0B2F93)
}

Have3StacksOfFiery()
{
	return IsAlertIconShowing(1284, 11, 0x08288C)
}

Have5StacksOfFiery()
{
	return IsAlertIconShowing(1235, 13, 0x319AEF)
}

EbonFuryActive()
{
	return IsAlertIconShowing(1196, 38, 0x8C485A)
}

VerseOfJoyActive()
{
	return IsAlertIconShowing(1120, 34, 0xEFF3EF)
}

HeatRetentionActive()
{
	return IsAlertIconShowing(1363, 40, 0x00C400)
}

ScourgeAvailable()
{
	return not IsAlertIconShowing(921, 13, 0x863F6A)
}

EbonFuryAvailable()
{
	return not IsAlertIconShowing(828, 36, 0xA05971)
}

DuskToDawnAvailable()
{
	return not IsAlertIconShowing(952, 29, 0xE7B6C1)
}

PunctureExpiring()
{
	return IsAlertIconShowing(1071, 15, 0x000000)
}

EmptinessMissing()
{
	return IsAlertIconShowing(1010, 17, 0xC93A90)
}
