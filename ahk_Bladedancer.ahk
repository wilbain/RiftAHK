InitializeBladedancer()
{
	global doNextSingleTargetRhythmic := false
	global doNextMultiTargetRhythmic := false
	global doChanneledAE := false
	global doFlash := false
	global doSprint := false
}

DoClearBladedancer()
{
	global doNextSingleTargetRhythmic := false
	global doNextMultiTargetRhythmic := false
	global doChanneledAE := false
	global doFlash := false
	global doSprint := false
}

DoActionOneBladedancer(comboPoints)
{		
	global doNextSingleTargetRhythmic
	global doFlash
	global doSprint
	
	if (not FlashOfSteelAvailable())
		doFlash := false
	if (not SprintAvailable())
		doSprint := false
	
	if (ExposeWeaknessExpiring())
		DoKeyPress("!2", "Expose Weakness")

	if (doNextSingleTargetRhythmic)
		DoNextSingleTargetRhythmic()
		
	if (doFlash && FlashOfSteelAvailable())
		DoKeyPress(8, "Flash of Steel")
	else if (doSprint && SprintAvailable())
		DoKeyPress(9, "Sprint")
	else if (comboPoints = 5)
		DoKeyPress(3, "Double Strike")
	else if (DualismActive())
	{
		if (comboPoints = 1)
			DoKeyPress("!3", "Precision Strike (Dualism)", comboPoints)
		else
			DoKeyPress(1, "Quick Strike (Dualism)", comboPoints)		
	}
	else
	{
		if (comboPoints = 2)
			DoKeyPress("!3", "Precision Strike", comboPoints)
		else
			DoKeyPress(1, "Quick Strike", comboPoints)
	}
}

DoActionTwoBladedancer(comboPoints)
{
	global doNextMultiTargetRhythmic
	global doChanneledAE
	global doFlash
	global doSprint
		
	if (not FlashOfSteelAvailable())
		doFlash := false
	if (not SprintAvailable())
		doSprint := false
	
	if (HundredBladesActive() || DancingSteelActive())
		return
	
	if (doNextMultiTargetRhythmic)
		DoNextMultiTargetRhythmic()
	
	if (doChanneledAE)
		DoChanneledAE()
		
	if (doFlash && FlashOfSteelAvailable())
		DoKeyPress(8, "Flash of Steel")
	else if (doSprint && SprintAvailable())
		DoKeyPress(9, "Sprint")
	else if (comboPoints > 2)
		DoKeyPress("!9", "Compound Attack")
	else
		DoKeyPress(7, "Twin Strike")
}

DoTriggerBladedancer(triggerNum)
{
	global doNextSingleTargetRhythmic
	global doNextMultiTargetRhythmic
	global doChanneledAE
	global doFlash
	global doSprint
	global doAction1
	global doAction2
	
	if (triggerNum = 1)
		doNextSingleTargetRhythmic := true
	else if (triggerNum = 2)
		doNextMultiTargetRhythmic := true
	else if (triggerNum = 3)
		doChanneledAE := true
	else if (triggerNum = 4)
	{
		if (doAction1 || doAction2)
			doFlash := true
		else
			DoKeyPress(8, "Flash of Steel")
	}
	else if (triggerNum = 5)
	{
		if (doAction1 || doAction2)
			doSprint := true
		else
			DoKeyPress(9, "Sprint")
	}
}

; functions

DoNextSingleTargetRhythmic()
{
	global doNextSingleTargetRhythmic
	
	if (BladeAndSoulAvailable())
	{
		while (BladeAndSoulAvailable() && HaveTarget())
		{
			DoKeyPress("!5", "Blade and Soul Parity")
			Sleep, 100
		}
	}
	;~ else if (FatedBladesAvailable())
	;~ {
		;~ while (FatedBladesAvailable() && HaveTarget())
		;~ {
			;~ DoKeyPress("!4", "Fated Blades")
			;~ Sleep, 100
		;~ }
	;~ }
	else if (DualismAvailable())
	{
		while (DualismAvailable() && HaveTarget())
		{
			DoKeyPress("!6", "Dualism")
			Sleep, 100
		}
	}
	else if (DoubleCoupAvailable())
	{
		while (DoubleCoupAvailable() && HaveTarget())
		{
			DoKeyPress("!7", "double Coup")
			Sleep, 100
		}
	}
	else if (BladeTempoAvailable())
	{
		while (BladeTempoAvailable() && HaveTarget())
		{
			DoKeyPress("!8", "Blade Tempo")
			Sleep, 100
		}
	}
	
	doNextSingleTargetRhythmic := false
}

DoNextMultiTargetRhythmic()
{
	global doNextMultiTargetRhythmic
	
	if (BladeAndSoulAvailable())
	{
		while (BladeAndSoulAvailable() && HaveTarget())
		{
			DoKeyPress("!5", "Blade and Soul Parity")
			Sleep, 100
		}
	}
	;~ else if (FatedBladesAvailable())
	;~ {
		;~ while (FatedBladesAvailable() && HaveTarget())
		;~ {
			;~ DoKeyPress("!4", "Fated Blades")
			;~ Sleep, 100
		;~ }
	;~ }
	else if (BladeTempoAvailable())
	{
		while (BladeTempoAvailable() && HaveTarget())
		{
			DoKeyPress("!8", "Blade Tempo")
			Sleep, 100
		}
	}
	else if (DoubleCoupAvailable())
	{
		while (DoubleCoupAvailable() && HaveTarget())
		{
			DoKeyPress("!7", "double Coup")
			Sleep, 100
		}
	}
	
	doNextMultiTargetRhythmic := false
}

DoChanneledAE()
{
	global doChanneledAE
	
	if (HundredBladesAvailable())
	{
		while (HundredBladesAvailable() && HaveTarget())
		{
			DoKeyPress("!0", "Hundred Blades")
			Sleep, 100
		}
	}
	else if (DancingSteelAvailable())
	{
		while (DancingSteelAvailable() && HaveTarget())
		{
			DoKeyPress("!-", "Dancing Steel")
			Sleep, 100
		}
	}
	
	doChanneledAE := false
}

ExposeWeaknessExpiring()
{
	return IsAlertIconShowing(1286, 28, 0x8D7E7C)
}

SprintAvailable()
{
	return not IsAlertIconShowing(1247, 19, 0x2A2B2D)
}

FlashOfSteelAvailable()
{
	return not IsAlertIconShowing(1208, 23, 0xEFBC31)
}

DancingSteelActive()
{
	return IsAlertIconShowing(936, 30, 0xDDD4BE)
}

DancingSteelAvailable()
{
	return not IsAlertIconShowing(585, 28, 0xE5DBBB)
}

HundredBladesActive()
{
	return IsAlertIconShowing(993, 25, 0xB27958)
}

HundredBladesAvailable()
{
	return not IsAlertIconShowing(545, 26, 0xD6927B)
}

;~ FatedBladesAvailable()
;~ {
	;~ return not IsAlertIconShowing(485, 3, 0x55421E)
;~ }

BladeAndSoulAvailable()
{
	return not IsAlertIconShowing(642, 25, 0x5D75E4)
}

DualismAvailable()
{
	return not IsAlertIconShowing(703, 32, 0x474946)
}

DoubleCoupAvailable()
{
	return not IsAlertIconShowing(746, 39, 0x95423F)
}

BladeTempoAvailable()
{
	return not IsAlertIconShowing(791, 19, 0xB88FC3)
}

RhythmicActive()
{
	return IsAlertIconShowing(880, 18, 0x0000FF)
}

DualismActive()
{
	return IsAlertIconShowing(1053, 32, 0xB2AE95)
}