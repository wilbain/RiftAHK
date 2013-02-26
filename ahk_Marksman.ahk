InitializeMarksman()
{
	global doBarbedShot := false
	global doDecoy := false
	SetState1Name("Decoy")
	SetState1Value("OFF")
	
	OutputDebug, Marksman initialized
}

DoClearMarksman()
{
	global doBarbedShot := false
}

DoActionOneMarksman(comboPoints)
{
	global doBarbedShot
	global doDecoy
	
	if (ChannelingStrafe() && comboPoints < 5)
		return
	
	if (doDecoy)
	{				
		if (not DecoyOnCD() && TargetHas3StacksOfSTM() && SafeToDoDecoy())
			DoKeyPress("!9", "decoy")
	}
		
	if (TargetHasBarbedShot())
		doBarbedShot := false
				
	if (comboPoints = 5)
	{
		if (not FreeRecoilOnCD())
			DoKeyPress("!5", "free recoil")
		
		if (RapidFireShotAvailable())
			DoKeyPress("!3", "rapid fire shot")
		else
			DoKeyPress(3, "hasted shot")
	}
	else if (doBarbedShot)
		DoKeyPress(4, "barbed shot")
	else if (LockNLoadActive())
	{
		if (not BullsEyeActive())
			DoKeyPress("!0", "bull's eye")

		DoKeyPress("!2", "empowered shot")
	}
	else if (comboPoints = 2 && StrafeAvailable() && TargetHas3StacksOfSTM() && ShootToKillActive())
	{
		   DoKeyPress("!6", "strafe")
		   return
	}
	else
		DoKeyPress(1, "swift shot")
				
	; determine if we should use Quick Reload
	if (QuickReloadAvailable() && not StrafeAvailable() && DecoyOnCD() && not BullsEyeAvailable())
		DoKeyPress("!-", "quick reload")
}

DoActionTwoMarksman(comboPoints)
{
	global doBarbedShot
	global doDecoy
		
	if (TargetHasBarbedShot())
		doBarbedShot := false
	
	if (LightningFuryAvailable())
		DoKeyPress("!7", "Lightning Fury")
	else
		DoKeyPress(7, "Fan Out")
}

DoTriggerMarksman(triggerNum)
{
	global doAction1
	global doAction2
	global suppressActions
	global doBarbedShot
	global doDecoy
	
	suppressActions := true	
	
	if (triggerNum = 1)
	{
		while (not DeadenOnCD() && HaveTarget())
		{
			DoKeyPress(2, "Deaden")
			Sleep, 50
		}
	}
	else if (triggerNum = 2)
	{
		if (doAction1 or doAction2)
			doBarbedShot := true
		else
			DoKeyPress(4, "barbed shot")
	}
	else if (triggerNum = 3)
	{		
		while (not OnTheDoubleOnCD())
		{
			DoKeyPress(9, "on the double")
			Sleep, 50
		}		
	}
	else if (triggerNum = 4)
	{		
		while (not EradicateOnCD())
		{
			DoKeyPress(8, "eradicate")
			Sleep, 50
		}		
	}
	else if (triggerNum = 5)
	{
		doDecoy := not doDecoy
		if (doDecoy)
			SetState1Value("ON")
		else
			SetState1Value("OFF")
	}
			
	suppressActions := false
}

; functions

ShootToKillActive()
{
	return IsAlertIconShowing(1291, 31, 0xAC8630)
}

LightningFuryAvailable()
{
	return not IsAlertIconShowing(465, 27, 0xC65939)
}

SafeToDoDecoy()
{
	; there is no buff shown for Decoy so we use a timer for Quick Reload
	return IsAlertIconShowing(1086, 10, 0x63E3FF)
}

ChannelingChainDestruction()
{
	return IsAlertIconShowing(985, 14, 0x1560C4)
}

TargetHas3StacksOfSTM()
{
	return IsAlertIconShowing(1154, 30, 0xEFF308)
}

BullsEyeActive()
{
	return IsAlertIconShowing(1192, 45, 0x428294)
}

ChannelingStrafe()
{
	return IsAlertIconShowing(1039, 19, 0x345A79)
}

LockNLoadActive()
{
	return IsAlertIconShowing(1352, 22, 0x295591)
}

RapidFireShotAvailable()
{
	return not IsAlertIconShowing(575, 17, 0xDECB84)
}

EradicateOnCD()
{
	return IsAlertIconShowing(932, 7, 0x7B782F)
}

DeadenOnCD()
{
	return IsAlertIconShowing(820, 14, 0xCE75EF)
}

DecoyOnCD()
{
	return IsAlertIconShowing(869, 28, 0x45C8F6)
}

FreeRecoilOnCD()
{
	return IsAlertIconShowing(535, 24, 0x7CD9D3)
}

OnTheDoubleOnCD()
{
	return IsAlertIconShowing(682, 22, 0x294563)
}

StrafeAvailable()
{
	return not IsAlertIconShowing(625, 16, 0x3F7D90)
}

BullsEyeAvailable()
{
	return not IsAlertIconShowing(778, 40, 0x478AA2)
}

TargetHasBarbedShot()
{
	return IsAlertIconShowing(1236, 28, 0x7B8E9B)
}

QuickReloadAvailable()
{
	return not IsAlertIconShowing(728, 8, 0x28B9F6)
}