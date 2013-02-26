InitializeTard()
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
	OutputDebug, Tard Initialized
}

DoClearTard()
{
	global doingMotifs := false
}

DoActionOneTard(comboPoints)
{
	; healing
	
	global doJeopardy
	global doBattleRemote

	if (not RestorativeEngineActive())
		DoKeyPress(6, "Restorative Engine")
	else if (comboPoints = 5)
	{
		if (doJeopardy && JeopardyExpiring_Tard())
			DoKeyPress("!5", "Coda of Jeopardy")
		else if (doPhysicalDebuff && CowardiceExpiring_Tard())
			DoKeyPress("!6", "Coda of Cowardice")
		else if (doMagicalDebuff && DistressExpiring_Tard())
			DoKeyPress("!7", "Coda of Distress")
		else if (CurativeBlastExpiring() && MotifOfBraveryUp_Tard())
			DoKeyPress(4, "Curative Blast")
		else
			DoKeyPress(3, "Coda of Restoration")
	}
	else
		DoKeyPress(1, "Empyrean Bolt")
}

DoActionTwoTard(comboPoints)
{
	DoDps(comboPoints, false)
}

DoActionThreeTard(comboPoints)
{
	DoDps(comboPoints, true)
}

DoDps(comboPoints, doAE)
{
	; st and ae dps
	
	global doPhysicalDebuff
	global doMagicalDebuff
	global doJeopardy

	if (comboPoints = 5)
	{
		if (doJeopardy && not doAE && JeopardyExpiring_Tard())
			DoKeyPress("!5", "Coda of Jeopardy")
		else if (doPhysicalDebuff && CowardiceExpiring_Tard())
			DoKeyPress("!6", "Coda of Cowardice")
		else if (doMagicalDebuff && DistressExpiring_Tard())
			DoKeyPress("!7", "Coda of Distress")
		else
		{
			if (doAE)
				DoKeyPress(8, "Coda of Fury")
			else
				DoKeyPress("!8", "Coda of Wrath")
		}
	}
	else
		DoKeyPress(1, "Empyrean Bolt")
}

DoTriggerTard(triggerNum)
{
	global doPhysicalDebuff
	global doMagicalDebuff
	global doJeopardy
	global suspendActions
	
	suspendActions := true
	
	if (triggerNum = 1)
	{				
		While (not MotifOfBraveryUp_Tard())
		{
			DoKeyPress("!9", "Motif of Bravery")
			Sleep, 100
		}
		While (not MotifOfTenacityUp_Tard())
		{
			DoKeyPress("!0", "Motif of Tenacity")
			Sleep, 100
		}
		While (not MotifOfRegenUp_Tard())
		{
			DoKeyPress("!-", "Motif of Regen")
			Sleep, 100
		}		
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
		while (PowerCoreAvailable_Tard())
		{
			DoKeyPress("-", "Power Core")
			Sleep, 50
		}
	}
	else if (triggerNum = 6)
	{
		while (BattleRemoteAvailable_Tard())
		{
			DoKeyPress("!3", "Battle Remote")
			Sleep, 50
		}
	}
		
	else if (triggerNum = 7)
	{
		while (CurativeCoreAvailable_Tard())
		{
			DoKeyPress(9, "Curative Core")
			Sleep, 100
		}
	}
	else if (triggerNum = 8)
	{
		while (CurativeRemoteAvailable() && HaveTarget())
		{
			DoKeyPress("!4", "Curative Remote")
			Sleep, 100
		}
	}
	
	suspendActions := false
}

RestorativeEngineActive()
{
	return IsAlertIconShowing(1206, 14, 0x639694)
}

NecroticEngineActive_Tard()
{
	return IsAlertIconShowing(1155, 39, 0x212829)
}

CurativeBlastExpiring()
{
	return IsAlertIconShowing(850, 15, 0x294B52)
}

CowardiceExpiring_Tard()
{
	return IsAlertIconShowing(750, 8, 0xDC9394)
}

BattleRemoteAvailable_Tard()
{
	return not IsAlertIconShowing(555, 36, 0x42444A)
}

PowerCoreAvailable_Tard()
{
	return not IsAlertIconShowing(615, 29, 0x7ECDC3)
}

PowerCoreActive_Tard()
{
	return IsAlertIconShowing(1260, 28, 0x184D4A)
}

CurativeRemoteAvailable()
{
	return not IsAlertIconShowing(452, 20, 0x4AD07F)
}

CurativeRemoteExpiring()
{
	return IsAlertIconShowing(919, 12, 0x32BD59)
}

DistressExpiring_Tard()
{
	return IsAlertIconShowing(692, 25, 0x6BCBFF)
}

JeopardyExpiring_Tard()
{
	return IsAlertIconShowing(799, 29, 0xB57908)
}

CurativeCoreAvailable_Tard()
{
	return not IsAlertIconShowing(502, 38, 0x527984)
}

MotifOfBraveryUp_Tard()
{
	return not IsAlertIconShowing(1109, 17, 0x76C3FF)
}

MotifOfRegenUp_Tard()
{
	return not IsAlertIconShowing(987, 17, 0x29BE7B)
}

MotifOfTenacityUp_Tard()
{
	return not IsAlertIconShowing(1057, 15, 0x10DFF7)
}