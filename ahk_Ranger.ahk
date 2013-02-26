InitializeRanger()
{
	global doDeaden := false
	global doOntheDouble := false
	global doShadowShift := false
}

DoActionOneRanger(comboPoints)
{
	global doDeaden
	global doOntheDouble
	global doShadowShift
	
	if (DeadenOnCD_Rng())
		doDeaden := false
	
	if (OnTheDoubleOnCD_Rng())
		doOnTheDouble := false
	
	if (ShadowShiftOnCD())
		doShadowShift := false

	if (doDeaden)
	{
		DoKeyPress(2, "deaden")
		return
	}
	
	if (doOnTheDouble)
	{
		DoKeyPress(9, "On the Double")
		return
	}
	
	if (doShadowShift)
	{
		DoKeyPress(8, "Shadow Shift")
		return
	}
	
	if (IceShieldUp())
		return
	
	if (FlickeringFireUp())
		return
	
	if (not InCombat() && BestialFuryRequired())
	{
		if (comboPoints > 0)
		{
			DoKeyPress("!5", "Head Shot")
			return
		}
		
		if (ShadowFireAvailable())
		{
			while (ShadowFireAvailable() && HaveTarget())
			{
				DoKeyPress("!3", "Shadow Fire")
				Sleep, 100
			}
		}
		else if (LockNLoadUp_Rng())
		{
			while (LockNLoadUp_Rng() && HaveTarget())
			{
				DoKeyPress("!2", "Empowered Shot")
				Sleep, 100
			}
		}
		else
		{
			while (TargetNeedsSplinterShot() && HaveTarget())
			{
				DoKeyPress("!4", "Splinter Shot")
				Sleep, 100
			}
		}
		
		comboPoints := GetComboPoints()
		while (comboPoints != 0)
		{
			DoKeyPress("!5", "Head Shot")
			Sleep, 100
			comboPoints := GetComboPoints()
		}
	}
			
	if (comboPoints = 5)
	{
		if (BestialFuryRequired())
			DoKeyPress("!5", "Head Shot")
		else
			DoKeyPress(3, "Rapid Fire Shot / Hasted Shot")
	}
	else if (LockNLoadUp_Rng())
		DoKeyPress("!2", "Empowered Shot")
	else if (comboPoints < 4 && ShadowFireAvailable())
		DoKeyPress("!3", "Shadow Fire")
	else if (TargetNeedsSplinterShot())
		DoKeyPress("!4", "Splinter Shot")
	else
		DoKeyPress(1, "Swift Shot")
}

DoActionTwoRanger(comboPoints)
{	
	global doDeaden
	global doOntheDouble
	global doShadowShift
	
	if (IceShieldUp())
		return
	
	if (ChannelingRainOfArrows())
		return

	DoKeyPress(7, "Rain of Arrows")
}

DoTriggerRanger(triggerNum)
{
	global doDeaden
	global doOntheDouble
	global doShadowShift
	
	if (triggerNum = 1)
	{
		doDeaden := true
		DoKeyPress(2, "Deaden")
	}
	else if (triggerNum = 2)
	{
		doOnTheDouble := true
		DoKeyPress(9, "On the Double")
	}
	else if (triggerNum = 3)
	{
		doShadowShift := true
		DoKeyPress(8, "Shadow Shift")
	}
}

; functions

DeadenOnCD_Rng()
{
	return IsAlertIconShowing(755, 6, 0x5A307B)
}

OnTheDoubleOnCD_Rng()
{
	return IsAlertIconShowing(715, 22, 0xADBEDE)
}

ShadowShiftOnCD()
{
	return IsAlertIconShowing(658, 19, 0x9A2C6E)
}

ChannelingRainOfArrows()
{
	return IsAlertIconShowing(917, 15, 0xE7DF73)
}

LockNLoadUp_Rng()
{
	return IsAlertIconShowing(1027, 22, 0x295591)
}

BestialFuryRequired()
{
	return IsAlertIconShowing(961, 8, 0x31556B)
}

ShadowFireAvailable()
{
	return not IsAlertIconShowing(811, 9, 0x52442C)
}

TargetNeedsSplinterShot()
{
	return IsAlertIconShowing(1066, 19, 0x29516E)
}