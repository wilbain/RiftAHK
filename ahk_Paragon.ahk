
InitializeParagon()
{
	OutputDebug, Paragon Initialized
}

DoActionOneParagon(comboPoints)
{	
	if (comboPoints = 2)
	{
		; do nothing while we wait for Weapon Master to generate the free point unless the follow-up is up
		; which means somehow we didn't use the follow-up in time and it expired
		if (FinalBlessingUp())
			DoKeyPress("!9", "Final Blessing")
		else if (RisingWaterfallUp())
			DoKeyPress("!2", "Rising Waterfall")
	}
	else if (comboPoints = 3)
		DoKeyPress(3, "Single Target Finisher")
	else if (comboPoints = 1)
	{
		if (FinalBlessingUp())
			DoKeyPress("!9", "Final Blessing")
		else if (RisingWaterfallUp())
			DoKeyPress("!2", "Rising Waterfall")
		else
			DoKeyPress(1, "Swift Strike")
	}
	else if (comboPoints = 0)
	{
		if (NeedFlamespear() && FlamespearAvailable())
			DoKeyPress("!3", "Flamespear")
		else if (NeedSettingMoon())
			DoKeyPress("!4", "Setting Moon")
		else if (DeathTouchAvailable())
			DoKeyPress("!5", "Death Touch")
		else if (SoulSicknessAvailable())
			DoKeyPress("!6", "Soul Sickness")
		else
			DoKeyPress(1, "Swift Strike")
	}
}

DoActionTwoParagon(comboPoints)
{
	if (comboPoints = 2)
	{
		; do nothing while we wait for Weapon Master to generate the free point unless the follow-up is up
		; which means somehow we didn't use the follow-up in time and it expired
		if (FinalBlessingUp())
			DoKeyPress("!9", "Final Blessing")
		else if (RisingWaterfallUp())
			DoKeyPress("!2", "Rising Waterfall")
	}
	else if (comboPoints = 3)
	{
		if (NeedSweepingBlades())
			DoKeyPress("!8", "Sweeping Blades")
		else
			DoKeyPress(2, "Multi Target Finisher")
	}
	else if (comboPoints = 1)
	{
		if (FinalBlessingUp())
			DoKeyPress("!9", "Final Blessing")
		else if (RisingWaterfallUp())
			DoKeyPress("!2", "Rising Waterfall")
		else
			DoKeyPress(1, "Swift Strike")
	}
	else if (comboPoints = 0)
	{
		if (NeedSettingMoon())
			DoKeyPress("!4", "Setting Moon")
		else if (DeathTouchAvailable())
			DoKeyPress("!5", "Death Touch")
		else
			DoKeyPress(1, "Swift Strike")
	}	
}

DoActionThreeParagon(comboPoints)
{
	if (comboPoints < 3)
		DoKeyPress(1, "Swift Strike")
	else
		DoKeyPress(3, "Single Target Finisher")
}

DoTriggerParagon(triggerNum)
{
}
	
; functions

RisingWaterfallUp()
{
	return IsAlertIconShowing(718, 22, 0xC3C7C0)
}

FinalBlessingUp()
{
	return IsAlertIconShowing(680, 24, 0x3C5D58)
}

NeedSweepingBlades()
{
	return IsAlertIconShowing(1135, 14, 0xCEDF84)
}

NeedFlamespear()
{
	return IsAlertIconShowing(1041, 15, 0x378EC8)
}

NeedSettingMoon()
{
	return IsAlertIconShowing(1094, 14, 0xE7756B)
}

DeathTouchAvailable()
{
	return not IsAlertIconShowing(829, 22, 0x4A75C6)
}

NeedDeathTouch()
{
	return IsAlertIconShowing(1133, 23, 0x4A75C6)
}

FlamespearAvailable()
{
	return not IsAlertIconShowing(773, 19, 0x182CF7)
}

SoulSicknessAvailable()
{
	return not IsAlertIconShowing(880, 31, 0x52929C)
}