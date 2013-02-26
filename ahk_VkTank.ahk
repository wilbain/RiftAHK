
InitializeVkTank()
{
	global doCleanse := false
	global doInterrupt := false
	global doShieldThrow := false
	global doRiftSummon := false
	global doAirburst := false
	global doSpellSunder := false
	global doTouchOfLife := false

	OutputDebug, VkTank Initialized
}

DoClearVkTank()
{
	global doCleanse := false
}

DoActionOneVkTank(comboPoints)
{
	global doCleanse
	global doInterrupt
	global doShieldThrow
	global doRiftSummon
	global doAirburst
	global doSpellSunder
	global doTouchOfLife
	
	if (SpellbreakerOnCD())
		doCleanse := false
	
	if (FuriousRageOnCD())
		doInterrupt := false
	
	if (ShieldThrowOnCD())
		doShieldThrow := false
	
	if (RiftSummonOnCD())
		doRiftSummon := false
	
	if (AirburstOnCD())
		doAirburst := false
	
	if (SpellSunderOnCD())
		doSpellSunder := false
	
	if (TouchOfLifeOnCD())
		doTouchOfLife := false
	
	if (doInterrupt)
	{
		DoKeyPress(4, "Furious Rage")
		return
	}
	
	if (doCleanse)
	{
		DoKeyPress(5, "Spellbreaker")
		return
	}
	
	if (doShieldThrow)
	{
		DoKeyPress(7, "Shield throw")
		return
	}
	
	if (doRiftSummon)
	{
		DoKeyPress(6, "Rift Summon")
		return
	}
	
	if (doAirburst)
	{
		DoKeyPress(8, "Airburst")
		return
	}
	
	if (doSpellSunder)
	{
		DoKeyPress(9, "Spell Sunder")
		return
	}
	
	if (doTouchOfLife)
	{
		DoKeyPress(0, "Touch of Life")
		return
	}
	
	if (RetaliationUp())
		DoKeyPress("!-", "Retaliation")
	
	if (comboPoints = 3)
		DoKeyPress(3, "Devouring Blow")
	else if (NeedAggresiveBlock())
		DoKeyPress("!2", "Aggressive Block")
	else if (NeedPacifyingStrike())
		DoKeyPress("!3", "Pacifying Strike")
	else if (HaveAtLeast3Pacts() && VoidStormAvailable())
		DoKeyPress("!8", "Void Storm")
	else if (HaveAtLeast3Pacts() && DischargeAvailable())
		DoKeyPress("!4", "Discharge")
	else if (RagestormAvailable())
		DoKeyPress("!5", "Ragestorm")
	else
		DoKeyPress(1, "Ravaging Strike")
}

DoActionTwoVkTank(comboPoints)
{
	global doCleanse
	global doInterrupt
	global doShieldThrow
	global doRiftSummon
	global doAirburst
	global doSpellSunder
	global doTouchOfLife
	
	if (SpellbreakerOnCD())
		doCleanse := false
	
	if (FuriousRageOnCD())
		doInterrupt := false
	
	if (ShieldThrowOnCD())
		doShieldThrow := false
	
	if (RiftSummonOnCD())
		doRiftSummon := false
	
	if (AirburstOnCD())
		doAirburst := false
	
	if (SpellSunderOnCD())
		doSpellSunder := false
	
	if (TouchOfLifeOnCD())
		doTouchOfLife := false
	
	if (doInterrupt)
	{
		DoKeyPress(4, "Furious Rage")
		return
	}
	
	if (doSpellSunder)
	{
		DoKeyPress(9, "Spell Sunder")
		return
	}
	
	if (doTouchOfLife)
	{
		DoKeyPress(0, "Touch of Life")
		return
	}
	
	if (doCleanse)
	{
		DoKeyPress(5, "Spellbreaker")
		return
	}
	
	if (doShieldThrow)
	{
		DoKeyPress(7, "Shield throw")
		return
	}
	
	if (doRiftSummon)
	{
		DoKeyPress(6, "Rift Summon")
		return
	}
	
	if (doAirburst)
	{
		DoKeyPress(8, "Airburst")
		return
	}
	
	if (RetaliationUp())
		DoKeyPress("!-", "Retaliation")
	
	if (TempestAvailable())
		DoKeyPress("!6", "Tempest")
	else if (RagestormAvailable())
		DoKeyPress("!5", "Ragestorm")
	else if (HaveAtLeast3Pacts() && VoidStormAvailable())
		DoKeyPress("!8", "Void Storm")
}

DoTriggerVkTank(triggerNum)
{
	global doCleanse
	global doInterrupt
	global doShieldThrow
	global doRiftSummon
	global doAirburst
	global doSpellSunder
	global doTouchOfLife
	
	if (triggerNum = 1)
	{
		doInterrupt := true
		DoKeyPress(4, "Furious Rage")
	}
	else if (triggerNum = 2)
	{
		doCleanse := true
		DoKeyPress(5, "Spellbreaker")
	}
	else if (triggerNum = 3)
	{
		doShieldThrow := true
		DoKeyPress(7, "Shield Throw")
	}
	else if (triggerNum = 4)
	{
		doRiftSummon := true
		DoKeyPress(6, "Rift Summon")
	}
	else if (triggerNum = 5)
	{
		doAirburst := true
		DoKeyPress(8, "Airburst")
	}
	else if (triggerNum = 6)
	{
		doSpellSunder := true
		DoKeyPress(9, "Spell Sunder")
	}
	else if (triggerNum = 7)
	{
		doTouchOfLife := true
		DoKeyPress(0, "Touch of Life")
	}
}
	
; functions

RetaliationUp()
{
	return IsAlertIconShowing(1179, 7, 0x1E6979)
}

SpellbreakerOnCD()
{
	return IsAlertIconShowing(548, 10, 0xBD5D18)
}

FuriousRageOnCD()
{
	return IsAlertIconShowing(580, 26, 0xC3A45A)
}

ShieldThrowOnCD()
{
	return IsAlertIconShowing(621, 11, 0x3F6894)
}

RiftSummonOnCD()
{
	return IsAlertIconShowing(669, 10, 0xEF65CE)
}

AirburstOnCD()
{
	return IsAlertIconShowing(730, 5, 0xDC29B2)
}

SpellSunderOnCD()
{
	return IsAlertIconShowing(465, 7, 0x844942)
}

TouchOfLifeOnCD()
{
	return IsAlertIconShowing(428, 28, 0x898C79)
}

NeedAggresiveBlock()
{
	return IsAlertIconShowing(1021, 21, 0x103884)
}

NeedPacifyingStrike()
{
	return IsAlertIconShowing(1091, 29, 0x0055CE)
}

HaveAtLeast3Pacts()
{
	return IsAlertIconShowing(1125, 22, 0xD63042)
}

VoidStormAvailable()
{
	return not IsAlertIconShowing(786, 10, 0xC67994)
}

DischargeAvailable()
{
	return not IsAlertIconShowing(827, 19, 0x213F65)
}

RagestormAvailable()
{
	return not IsAlertIconShowing(878, 10, 0x9C105A)
}

TempestAvailable()
{
	return not IsAlertIconShowing(944, 17, 0x635552)
}