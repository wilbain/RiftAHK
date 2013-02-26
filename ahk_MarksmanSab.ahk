InitializeMarksmanSab()
{
	global useBombDet := true
	SetState1Name("Bomb Det")
	SetState1Value("ON")
}

DoActionOneMarksmanSab(comboPoints)
{
	global useBombDet
				
	have5Loaded := Have5ChargesLoaded()
	
	if (comboPoints = 5)
		DoKeyPress("!5", "ALT-5 Rapid Fire Shot/Hasted Shot")
	else if (not have5Loaded)
		DoKeyPress(1, "1 Spike Charge")	
	else if (SpikeBleedExpiringInUnder1())
	{
		if (useBombDet)
			DoKeyPress(2, "2 Frag Bomb")
		else
			DoKeyPress(3, "3 Detonate")
	}
	else if (LockNLoadActive_MMSab())
		DoKeyPress("!3", "ALT-3 Empowered Shot")
	else
		DoKeyPress("!2", "ALT-2 Swift Shot")
}

DoActionTwoMarksmanSab(comboPoints)
{	
	if (FragBombAvailable())
		DoKeyPress(2, "2 Frag Bomb")
	else if (ChemBombAvailable())
		DoKeyPress("!8", "ALT-8 Chem Bomb")
	else
	{
		DoKeyPress(7, "7 MM AE")
		Sleep, 300
	}
}

DoTriggerMarksmanSab(triggerNum)
{
	global useBombDet
	
	if (triggerNum = 2)
		DoKeyPress(4, "pet attack")
	else if (triggerNum = 5)
	{
		useBombDet := not useBombDet
		if (useBombDet)
			SetState1Value("ON")
		else
			SetState1Value("OFF")
	}
}

; functions

LockNLoadActive_MMSab()
{
	return IsAlertIconShowing(856, 23, 0x7BBFE1)
}

Have5ChargesLoaded()
{
	return IsAlertIconShowing(985, 924, 0x697FB1)
}

SpikeBleedExpiringInUnder1()
{
	return IsAlertIconShowing(786, 17, 0xCBBBAD)
}

FragBombAvailable()
{
	return not IsAlertIconShowing(1065, 10, 0x0855DE)
}

ChemBombAvailable()
{
	return not IsAlertIconShowing(1129, 27, 0x08BEBD)
}