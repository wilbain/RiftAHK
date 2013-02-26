InitializeRangerSab()
{
	global useBombDet := true
	SetState1Name("Bomb Det")
	SetState1Value("ON")
}

DoActionOneRangerSab(comboPoints)
{
	global useBombDet
		
	if (not InCombat())
	{
		if (ShadowFireAvailable())
		{
			While (ShadowFireAvailable() && HaveTarget())
			{
				DoKeyPress("!2", "ALT-2 Shadow Fire")
				Sleep, 200
			}
		}
		
		comboPoints := GetComboPoints()
		While (comboPoints > 0 && HaveTarget())
		{
			DoKeyPress("!5", "ALT-5 Head Shot")
			Sleep, 200
			comboPoints := GetComboPoints()
		}
		
		return
	}
		
	have5Loaded := Have5ChargesLoaded()
	
	if (comboPoints = 5)
		DoKeyPress("!5", "ALT-5 Head Shot")
	else if (comboPoints = 0 && SplinterShotExpiring())
		DoKeyPress("!3", "Splinter Shot")
	else if (not have5Loaded)
		DoKeyPress(1, "1 Spike Charge")	
	else if (SpikeBleedExpiringInUnder1())
	{
		if (useBombDet)
			DoKeyPress(2, "2 Frag Bomb")
		else
			DoKeyPress(3, "3 Detonate")
	}
	else if (ShadowFireAvailable())
		DoKeyPress("!2", "ALT-2 Shadow Fire")
	else
		DoKeyPress("!4", "ALT-4 Quick Shot")
}

DoActionTwoRangerSab(comboPoints)
{
	;~ if (CastingRain())
		;~ return
	
	if (FragBombAvailable())
		DoKeyPress(2, "2 Frag Bomb")
	else if (ChemBombAvailable())
		DoKeyPress("!8", "ALT-8 Chem Bomb")
	else
	{
		DoKeyPress(7, "7 Rain of Arrows")
		Sleep, 300
	}
}

DoTriggerRangerSab(triggerNum)
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

CastingRain()
{
	return IsAlertIconShowing(664, 24, 0xEFE784)
}

BleedFinisherWarning()
{
	return IsAlertIconShowing(722, 14, 0xCBBBAD)
}

Have5ChargesLoaded()
{
	return IsAlertIconShowing(986, 924, 0x6E82BB)
}

SpikeBleedExpiringInUnder5()
{
	return IsAlertIconShowing(849, 15, 0xCBBBAD)
}

SpikeBleedExpiringInUnder1()
{
	return IsAlertIconShowing(786, 17, 0xCBBBAD)
}

ShadowFireAvailable()
{
	return not IsAlertIconShowing(1029, 12, 0xBD9A5A)
}

FragBombAvailable()
{
	return not IsAlertIconShowing(1065, 10, 0x0855DE)
}

ChemBombAvailable()
{
	return not IsAlertIconShowing(1129, 27, 0x08BEBD)
}

SplinterShotExpiring()
{
	return IsAlertIconShowing(968, 21, 0x184163)
}

BestialFuryMissing()
{
	return IsAlertIconShowing(910, 15, 0x5AAFDC)
}