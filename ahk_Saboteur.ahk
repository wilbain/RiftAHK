#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

#Include %A_ScriptDir%\Lib\RiftUtils.ahk

InitializeSaboteur()
{
	global doChemicalBomb := true
	SetState1Name("Do Chemical Bomb")
	SetState1Value("ON")
	OutputDebug, Saboteur Initialized
}

DoActionOneSaboteur(comboPoints)
{
	global doChemicalBomb
	
	if (RapidSetupAvailable() && not SpikeChargesLoaded())
		DoKeyPress("!8", "Rapid Setup")
	else if (RapidSetupUp())
		DoKeyPress("!2", "Spike Charge")
	else if (comboPoints = 5)
		DoKeyPress(3, "Detonate")
	else if (doChemicalBomb && ChemicalBombAvailable() && not CarpetBombingUp())
		DoKeyPress("!6", "Chemical Bomb")
	else
		DoKeyPress(1, "ST Spam Macro")
}

DoActionTwoSaboteur(comboPoints)
{
	global doChemicalBomb
	
	if (RapidSetupAvailable() && not CaltropChargesLoaded())
		DoKeyPress("!8", "Rapid Setup")
	else if (RapidSetupUp())
		DoKeyPress("!3", "Caltrop Charge")
	else if (comboPoints = 5)
		DoKeyPress(3, "Detonate")
	else if (doChemicalBomb && ChemicalBombAvailable() && not CarpetBombingUp())
		DoKeyPress("!6", "Chemical Bomb")
	else
		DoKeyPress(2, "AE Spam Macro")
}

DoActionThreeSaboteur(comboPoints)
{
}

DoTriggerSaboteur(triggerNum)
{
	global doChemicalBomb
	
	if (triggerNum = 1)
	{
		doChemicalBomb := not doChemicalBomb
		if (doChemicalBomb)
			SetState1Value("ON")
		else
			SetState1Value("OFF")
	}
}

; functions

SpikeChargesLoaded()
{
	return IsAlertIconShowing(1120, 15, 0xE1DED6)
}

CaltropChargesLoaded()
{
	return IsAlertIconShowing(1180, 13, 0x9A9184)
}

RapidSetupUp()
{
	return IsAlertIconShowing(1019, 7, 0x2374E9)
}

CarpetBombingUp()
{
	return IsAlertIconShowing(1077, 11, 0x764065)
}

RapidSetupAvailable()
{
	return not IsAlertIconShowing(816, 18, 0x348DFA)
}

ChemicalBombAvailable()
{
	return not IsAlertIconShowing(470, 26, 0x088070)
}
