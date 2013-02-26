InitializeMarksmanRanger()
{
	global doOnTheDouble := false
	global doDeaden := false
	global doShadowShift := false
	
	OutputDebug, MarksmanRanger initialized
}

DoClearMarksmanRanger()
{
	global doOnTheDouble := false
	global doDeaden := false
}

DoActionOneMarksmanRanger(comboPoints)
{
	global doOnTheDouble
	global doDeaden
	global doShadowShift

	if (OnTheDoubleOnCD_Rng())
		doOnTheDouble := false
	
	if (DeadenOnCD_Rng())
		doDeaden := false
	
	if (not ShadowShiftAvailable())
		doShadowShift := false
			
	if (doDeaden)
	{
		DoKeyPress(2, "deaden")
		return
	}
	
	if (doShadowShift)
	{
		DoKeyPress(8, "shadow shift")
		return
	}
		
	if (doOnTheDouble)
	{
		DoKeyPress(9, "on the double")
		return
	}			
	
	;~ if (ChannelingStrafe_Rng() && comboPoints < 5)
		;~ return	
				
	if (comboPoints = 5)
	{		
		if (LockNLoadActive_Rng())
			DoKeyPress("!2", "empowered shot")
		else if (BestialFuryMissing())
			DoKeyPress("!5", "head shot")
		else
			DoKeyPress(3, "rapid fire shot / hasted shot")
	}
	else if (LockNLoadActive_Rng())
		DoKeyPress("!2", "empowered shot")
	else if (SplinterShotMissing())
		DoKeyPress("!3", "splintered shot")
	;~ else if (comboPoints < 4 && StrafeAvailable_Rng() && ShootToKillActive_Rng())
	;~ {
		   ;~ DoKeyPress("!6", "strafe")
		   ;~ return
	;~ }
	else if (comboPoints < 4 && ShadowFireAvailable())
		DoKeyPress("!4", "shadow fire")
	else
		DoKeyPress(1, "swift shot")
				
	; determine if we should use Quick Reload
	if (QuickReloadAvailable_Rng() && not RapidFireShotAvailable_Rng())
		DoKeyPress("!-", "quick reload")
}

DoActionTwoMarksmanRanger(comboPoints)
{
	global doOnTheDouble
	global doDeaden
	global doShadowShift
	
	if (OnTheDoubleOnCD_Rng())
		doOnTheDouble := false
	
	if (DeadenOnCD_Rng())
		doDeaden := false
	
	if (not ShadowShiftAvailable())
		doShadowShift := false
	
	if (doDeaden)
	{
		DoKeyPress(2, "deaden")
		return
	}
			
	if (doShadowShift)
	{
		DoKeyPress(8, "shadow shift")
		return
	}
	
	if (doOnTheDouble)
	{
		DoKeyPress(9, "on the double")
		return
	}	

	if (LightningFuryAvailable_Rng() && not ChannelingRainOfArrows())
		DoKeyPress("!7", "lightning fury")
	else
		DoKeyPress(7, "rain of arrows")
}

DoTriggerMarksmanRanger(triggerNum)
{
	global doOnTheDouble
	global doDeaden
	global doShadowShift
	global doAction1
	global doAction2
	
	if (triggerNum = 1)
	{
		if (doAction1 || doAction2)
			doDeaden := true
		else
			DoKeyPress(2, "deaden")
	}
	else if (triggerNum = 2)
		DoKeyPress(4, "pet attack")
	else if (triggerNum = 3)
	{
		if (doAction1 || doAction2)
			doOnTheDouble := true
		else
			DoKeyPress(9, "on the double")
	}
	else if (triggerNum = 4)
	{
		if (doAction1 || doAction2)
			doShadowShift := true
		else
			DoKeyPress(8, "shadow shift")
	}
}

; functions

ShadowShiftAvailable()
{
	return not IsAlertIconShowing(458, 26, 0xB559F7)
}

ChannelingRainOfArrows()
{
	return IsAlertIconShowing(882, 14, 0x8F7539)
}

BestialFuryMissing()
{
	return IsAlertIconShowing(998, 9, 0x2C81B0)
}

ShadowFireAvailable()
{
	return not IsAlertIconShowing(727, 14, 0xC8B489)
}

SplinterShotMissing()
{
	return IsAlertIconShowing(1040, 25, 0x2C5E89)
}

ShootToKillActive_Rng()
{
	return IsAlertIconShowing(929, 29, 0x816426)
}

LightningFuryAvailable_Rng()
{
	return not IsAlertIconShowing(419, 25, 0xAD6118)
}

ChannelingChainDestruction_Rng()
{
	return IsAlertIconShowing(1167, 10, 0x296DAD)
}

ChannelingStrafe_Rng()
{
	return IsAlertIconShowing(1173, 16, 0x1B4791)
}

LockNLoadActive_Rng()
{
	return IsAlertIconShowing(1108, 9, 0x18209C)
}

RapidFireShotAvailable_Rng()
{
	return not IsAlertIconShowing(521, 20, 0xFFFFC6)
}

DeadenOnCD_Rng()
{
	return IsAlertIconShowing(820, 14, 0x9F5BD9)
}

OnTheDoubleOnCD_Rng()
{
	return IsAlertIconShowing(631, 20, 0x29496B)
}

StrafeAvailable_Rng()
{
	return not IsAlertIconShowing(571, 13, 0x106D9C)
}

QuickReloadAvailable_Rng()
{
	return not IsAlertIconShowing(676, 8, 0x2CBFF7)
}