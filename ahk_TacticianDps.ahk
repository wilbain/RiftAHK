InitializeTacticianDps()
{
	global nextTorrentCast := "GLACIAL"
	global doSub30 := true
	SetState1Name("Sub 30% Torrents")
	SetState1Value("ON")	
}

DoActionOneTacticianDps(comboPoints)
{
	DoAction(comboPoints, false)
}

DoActionTwoTacticianDps(comboPoints)
{
	DoAction(comboPoints, true)
}

DoActionThreeTacticianDps(comboPoints)
{	
	if (not HaveTarget())
		return
	
	if (not NecroticEngineActive())
		DoKeyPress("!0", "Necrotic Engine")
		
	if (ExpandedTorrentsMissing() && BattleRemoteAvailable())
		DoKeyPress("!9", "Battle Remote")
	
	DoKeyPress(8, "Necrotic Bolt")
}

DoAction(comboPoints, doAreaOfEffect)
{
	global nextTorrentCast
	global doSub30
	
	if (not HaveTarget())
		return
	
	if (NecroticEngineActive())
		DoKeyPress("-", "Cancel Necrotic Engine")		
		
	if (ExpandedTorrentsMissing() && BattleRemoteAvailable())
		DoKeyPress("!9", "Battle Remote")
	
	if (Have4StacksOfExpandedTorrents())
	{
		if (CastingAnyTorrent())
		{
			Sleep, 600
			DoKeyPress(6, "Stop Casting")
			Sleep, 200
			return
		}
		DoKeyPress("!2", "Empyrean Bolt")
	}
	else if (comboPoints = 5)
	{
		if (doAreaOfEffect || TorrentPrimerExpiring())
			DoKeyPress("!3", "Torrent Primer")
		else
		{
			if (Moving())
				DoKeyPress("!3", "Torrent Primer")
			else
				DoKeyPress(3, "Empyrean Ray")
		}
	}
	else if (not doAreaOfEffect && NecroticBoltAvailable())
		DoKeyPress(8, "Necrotic Bolt")
	else if (CastingInfernalTorrent())
	{
		if (doSub30 && TargetUnder30())
			nextTorrentCast := "NECROTIC"
		else
			nextTorrentCast := "GLACIAL"
		DoNextTorrentCast()
	}
	else if (CastingGlacialTorrent())
	{
		nextTorrentCast := "INFERNAL"
		DoNextTorrentCast()
	}
	else if (CastingNecroticTorrent())
	{
		nextTorrentCast := "INFERNAL"
		DoNextTorrentCast()
	}
	else
	{
		nextTorrentCast := "GLACIAL"
		DoNextTorrentCast()
	}	
}

DoTriggerTacticianDps(triggerNum)
{
	global doSub30
	global suspendActions
	
	suspendActions := true
	
	if (triggerNum = 1)
	{
		While (DeadenAvailable() && HaveTarget())
		{
			DoKeyPress(2, "Deaden")
			Sleep, 50
		}
	}
	else if (triggerNum = 2)
	{
		doSub30 := not doSub30
		if (doSub30)
			SetState1Value("ON")
		else
			SetState1Value("OFF")
	}
	else if (triggerNum = 3)
	{
		while (NecroticCoreAvailable())
		{
			DoKeyPress("!6", "Necrotic Core")
			Sleep, 100
		}		
	}
	else if (triggerNum = 4)
	{
		suspendActions := true

		while (PowerCoreAvailable())
		{
			DoKeyPress("!8", "Power Core")
			Sleep, 100
		}		
	}
	else if (triggerNum = 5)
	{
		while (CurativeCoreAvailable())
		{
			DoKeyPress("!5", "Curative Core")
			Sleep, 100
		}		
	}
	else if (triggerNum = 6)
	{
		while (OnTheDoubleAvailable())
		{
			DoKeyPress(9, "On the Double")
			Sleep, 50
		}		
	}
	
	suspendActions := false
}

; functions

DeadenAvailable()
{
	return not IsAlertIconShowing(488, 11, 0x7B41C6)
}

DoNextTorrentCast()
{
	global nextTorrentCast
	global doSub30
	
	if (ExpandedTorrentsMissing())
	{
		if (doSub30 && TargetUnder30())
			DoKeyPress(0, "Necrotic Torrent")
		else if (HaveStacksOfGlacialChill())
			DoKeyPress(7, "Infernal Torrent")
		else
			DoKeyPress(1, "Glacial Torrent")
	}
	else if (nextTorrentCast = "GLACIAL")
		DoKeyPress(1, "Glacial Torrent")
	else if (nextTorrentCast = "INFERNAL")
		DoKeyPress(7, "Infernal Torrent")
	else if (nextTorrentCast = "NECROTIC")
		DoKeyPress(0, "Necrotic Torrent")
	else
		SetState3Value("unknown torrent")
}

OnTheDoubleAvailable()
{
	return not IsAlertIconShowing(444, 28, 0x3C5473)
}

NecroticBoltAvailable()
{
	return not IsAlertIconShowing(624, 11, 0xDE84B5)
}

NecroticEngineActive()
{
	return IsAlertIconShowing(986, 39, 0x253132)
}

TargetUnder30()
{
	return IsAlertIconShowing(556, 14, 0x0000FF)
}

PowerCoreActive()
{
	return IsAlertIconShowing(1088, 28, 0x184D4A)
}

ExpandedTorrentsMissing()
{
	return IsAlertIconShowing(874, 20, 0xC877F2)
}

HaveStacksOfGlacialChill()
{
	return IsAlertIconShowing(1149, 39, 0x443516)
}

IncreasedFirePowerActive()
{
	return IsAlertIconShowing(1048, 24, 0x1693D6)
}

BattleRemoteAvailable()
{
	return not IsAlertIconShowing(769, 35, 0x636A6B)
}

NecroticCoreAvailable()
{
	return not IsAlertIconShowing(665, 27, 0x69B2C9)
}

PowerCoreAvailable()
{
	return not IsAlertIconShowing(830, 28, 0x1E5350)
}

CurativeCoreAvailable()
{
	return not IsAlertIconShowing(721, 35, 0x73A6B5)
}

Have4StacksOfExpandedTorrents()
{
	return IsAlertIconShowing(1188, 25, 0xBB5CE9)
}

CastingAnyTorrent()
{
	return CastingInfernalTorrent() || CastingGlacialTorrent() || CastingNecroticTorrent()
}

CastingInfernalTorrent()
{
	return IsAlertIconShowing(1302, 26, 0x1372EC)
}

CastingGlacialTorrent()
{
	return IsAlertIconShowing(1354, 21, 0xFFFBEF)
}

CastingNecroticTorrent()
{
	return IsAlertIconShowing(1248, 24, 0x310C10)
}

TorrentPrimerExpiring()
{
	return IsAlertIconShowing(932, 32, 0xF7B2AD)
}