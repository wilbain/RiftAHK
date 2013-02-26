InitializeSoloCleric()
{	
	OutputDebug, SoloCleric initialized
}

DoClearSoloCleric()
{
}

DoActionOneSoloCleric()
{
	if (EruptionOfLifeMissing())
		DoKeyPress("!2", "Eruption of Life")
	else if (TargetNeedsLightning() && CombinedEffortActive())
		DoKeyPress("!3", "Lightning Hammer")
	else
		DoKeyPress(1, "ST Sspam")
}

DoActionTwoSoloCleric()
{
	DoKeyPress(7, "AE Spam")
}

DoTriggerSoloCleric(triggerNum)
{
	global suspendActions

	suspendActions := true
	
	if (triggerNum = 1)
	{		
		While (not NaturalDedicationActive())
		{
			DoKeyPress(2, "Natural dedication")
			Sleep, 100
		}		
	}
	else if (triggerNum = 2)
	{		
		While (not ThornsOfIreOnTarget() && HaveTarget())
		{
			DoKeyPress(6, "Thorns of Ire")
			Sleep, 100
		}		
	}
	else if (triggerNum = 3)
	{		
		While (StrengthOfTheFaeAvailable())
		{
			DoKeyPress(3, "Strength of the Fae")
			Sleep, 50
		}		
	}
	else if (triggerNum = 4)
	{		
		While (GrimSilenceAvailable() && HaveTarget())
		{
			DoKeyPress(4, "Grim Silence")
			Sleep, 50
		}		
	}
	else if (triggerNum = 5)
	{
		While (FaeStepAvailable() && HaveTarget())
		{
			DoKeyPress(8, "Fae Step")
			Sleep, 100
		}		
	}
	else if (triggerNum = 6)
	{		
		While (HiddenPathAvailable())
		{
			DoKeyPress(9, "Hidden Path")
			Sleep, 100
		}		
	}
	else if (triggerNum = 7)
	{		
		While (ShieldOfOakAvailable())
		{
			DoKeyPress(0, "Shield of Oak")
			Sleep, 50
		}
	}
	
	suspendActions := false
}

; functions

CombinedEffortActive()
{
	return IsAlertIconShowing(827, 16, 0x3F3D2E)
}

TargetNeedsLightning()
{
	return IsAlertIconShowing(1325, 20, 0x735942)
}

NaturalDedicationActive()
{
	return IsAlertIconShowing(1286, 16, 0x1683D6)
}

ThornsOfIreOnTarget()
{
	return IsAlertIconShowing(1231, 41, 0x132B34)
}

StrengthOfTheFaeAvailable()
{
	return not IsAlertIconShowing(970, 11, 0x269A65)
}

GrimSilenceAvailable()
{
	return not IsAlertIconShowing(1021, 41, 0x8C616B)
}

FaeStepAvailable()
{
	return not IsAlertIconShowing(1074, 38, 0x317518)
}

HiddenPathAvailable()
{
	return not IsAlertIconShowing(858, 9, 0x18D9AD)
}

ShieldOfOakAvailable()
{
	return not IsAlertIconShowing(920, 27, 0x18FB6B)
}

EruptionOfLifeMissing()
{
	return IsAlertIconShowing(1122, 24, 0x2E6F63)
}

CrushingForceExpiring()
{
	return IsAlertIconShowing(1182, 20, 0x58A5D1)
}