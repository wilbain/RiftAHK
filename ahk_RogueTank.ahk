
DoActionOneTank(comboPoints)
{
	if (PlanarSplashActive())
		DoKeyPress("!5", "ALT-5 Cancel Planar Splash")
	
	if (GuardedSteelExpiring() && comboPoints > 0)
		DoKeyPress("!3", "ALT-3 Guarded Steel")
	else if (WrathOfThePlanesExpiring() && comboPoints > 0)
		DoKeyPress(3, "3 Wrath of the Planes")
	else if (comboPoints = 5)
	{
		if (PowerOfThePlanesExpiring())
			DoKeyPress("!2", "ALT-2 Power of the Planes")
		else
			DoKeyPress("!3", "ALT-3 Guarded Steel")
	}
	else
		DoKeyPress(1, "1 Planar/Phantom Strike")
}		

DoActionTwoTank(comboPoints)
{
	if (GuardedSteelExpiring() && comboPoints > 0)
		DoKeyPress("!3", "ALT-3 Guarded Steel")
	else if (WrathOfThePlanesExpiring() && comboPoints > 0)
		DoKeyPress(3, "3 Wrath of the Planes")
	else if (comboPoints = 5)
	{
		if (PowerOfThePlanesExpiring())
			DoKeyPress("!2", "ALT-2 Power of the Planes")
		else
			DoKeyPress(3, "3 Wrath of the Planes")
	}
	else
		DoKeyPress(2, "2 Planar/Phantom Strike")
}

GuardedSteelExpiring()
{
	return IsAlertIconShowing(1177, 43, 0xCEB6AD)
}

PowerOfThePlanesExpiring()
{
	return IsAlertIconShowing(1109, 23, 0x6B605D)
}

PlanarSplashActive()
{
	return IsAlertIconShowing(1237, 20, 0x9C4563)
}

RiftDisturbanceExpiring()
{
	return IsAlertIconShowing(1011, 40, 0xE7E7FF)
}

WrathOfThePlanesExpiring()
{
	return IsAlertIconShowing(1055, 23, 0xE9DBA5)
}