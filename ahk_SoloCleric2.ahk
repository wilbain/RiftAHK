InitializeSoloCleric2()
{	
	OutputDebug, SoloCleric2 initialized
}

DoClearSoloCleric2()
{
}

DoActionOneSoloCleric2()
{
	if (CombinedEffortAvailable() && InMeleeRange())
		DoKeyPress("!3", "Combined Effort")
	else if (SanctionHereticAvailable())
		DoKeyPress("!2", "Sanction Heretic")
	else if (not TargetHasVex())
		DoKeyPress("!4", "Vex")
	else if (Moving())
		DoKeyPress("!5", "Fervent Strike")
	else
		DoKeyPress(1, "Bolt of Judgement")
}

DoActionTwoSoloCleric2()
{
	if (SoulDrainAvailable() && not Moving())
		DoKeyPress(7, "Soul Drain")
	else
		DoKeyPress("!6", "Wild Strike")
}

DoActionThreeSoloCleric2()
{
	DoKeyPress("!5", "Fervent Strike")	
}

DoTriggerSoloCleric2(triggerNum)
{
	global suspendActions

	suspendActions := true
	
	if (triggerNum = 2)
	{		
		While (not ThornsOfIreOnTarget() && HaveTarget())
		{
			DoKeyPress(6, "Thorns of Ire")
			Sleep, 100
		}		
	}
	else if (triggerNum = 3)
	{		
		While (PurgeAvailable())
		{
			DoKeyPress(3, "Purge")
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
		While (FaeStepAvailable() && HaveTarget() && InTeleportRange())
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

; functions - NOTE THERE ARE FUNCTIONS IN SOLOCLERIC.AHK COMMON TO THIS FILE

InMeleeRange()
{
	return IsAlertIconShowing(897, 94, 0x6CB66C)
}

InTeleportRange()
{
	return IsAlertIconShowing(964, 92, 0x72B972)
}

CombinedEffortAvailable()
{
	return IsAlertIconShowing(1284, 16, 0x3F3C2D)
}

SanctionHereticAvailable()
{
	return not IsAlertIconShowing(761, 22, 0x9CB2FA)
}

TargetHasVex()
{
	return IsAlertIconShowing(812, 9, 0x8138A7)
}

SoulDrainAvailable()
{
	return IsAlertIconShowing(1171, 11, 0xAB7619)
}

PurgeAvailable()
{
	return not IsAlertIconShowing(1126, 15, 0xE77942)
}