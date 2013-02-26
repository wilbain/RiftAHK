InitializeHarbingerSolo()
{
	global lastProc := 0
	global doSpores := false
	global doInterrupt := false
	OutputDebug, HarbingerSolo Initialized
}

DoClearHarbingerSolo()
{
}

DoActionOneHarbingerSolo()
{
	global lastProc
	global doSpores
	global doInterrupt
	
	if (RadiantSporesOnCD())
		doSpores := false
	
	if (DistractingSlashOnCD())
		doInterrupt := false
	
	if (doInterrupt)
		DoKeyPress(4, "Distracting Slash")
	
	if (doSpores)
	{
		DoKeyPress(3, "Radiant Spores")
		return
	}

	if (EldritchProc())
	{
		interval := A_TickCount - lastProc
		OutputDebug, interval = %interval%
		if (interval > 3000)
		{
			while (EldritchProc())
			{
				DoKeyPress("!3", "Eldritch Proc")
				Sleep, 800
			}
			lastProc := A_TickCount
			return
		}
	}
	
	if (PiercingBeamExpiring())
		DoKeyPress("!2", "Piercing Beam")
	else
		DoKeyPress(1, "ST Spam")
}

DoActionTwoHarbingerSolo()
{
	global doSpores
	global doInterrupt
	
	if (RadiantSporesOnCD())
		doSpores := false
	
	if (DistractingSlashOnCD())
		doInterrupt := false
	
	if (doInterrupt)
		DoKeyPress(4, "Distracting Slash")
	
	if (doSpores)
	{
		DoKeyPress(3, "Radiant Spores")
		return
	}
	
	DoKeyPress(7, "AE Spam")
}

DoTriggerHarbingerSolo(triggerNum)
{
	global doSpores
	global doActionOne
	global doActionTwo
	global doInterrupt
	
	if (triggerNum = 1)
	{
		if (doActionOne || doActionTwo)
			doSpores := true
		else
			DoKeyPress(3, "Radiant Spores")
	}
	if (triggerNum = 2)
	{
		if (doActionOne || doActionTwo)
			doInterrupt := true
		else
			DoKeyPress(4, "Distracting Slash")
	}
}

PiercingBeamExpiring()
{
	return IsAlertIconShowing(753, 10, 0x087DD6)
}

EldritchProc()
{
	return IsAlertIconShowing(801, 36, 0x4F747B)
}

RadiantSporesOnCD()
{
	return IsAlertIconShowing(840, 21, 0x845508)
}

DistractingSlashOnCD()
{
	return IsAlertIconShowing(892, 31, 0xFFE3BD)
}