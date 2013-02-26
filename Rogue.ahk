#NoEnv
#NoTrayIcon
#SingleInstance
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
Thread, interrupt, 0  ; make all threads always interruptible

SetNumLockState, AlwaysOn


OnExit, GuiClose

hMod := DllCall("LoadLibrary", Str, "hyde64.dll", Ptr) ;for x64
if (hMod)
{
	hHook := DllCall("SetWindowsHookEx", Int, 5, Ptr, DllCall("GetProcAddress", Ptr, hMod, AStr, "CBProc", ptr), Ptr, hMod, Ptr, 0, Ptr)
	if (!hHook)
	{
		MsgBox, SetWindowsHookEx failed
		ExitApp
	}
}
else
{
	MsgBox, LoadLibrary failed
	ExitApp
}


ROLE := "UNKNOWN"

loopDelay := 300
doAction1 := false
doAction2 := false
doAction3 := false
doAction4 := false
suspendActions := false

actionFunctionOne := ""
actionFunctionTwo := ""
actionFunctionThree := ""
actionFunctionFour := ""
triggerFunction := ""
clearFunction := ""

loopStarted := false

doCleanseSoul := false

SetTimer, DetermineRole, 2000
SetTimer, CreateGui, 1000


#Include %A_ScriptDir%\Lib\RiftUtils.ahk

#include %A_ScriptDir%\ahk_TacticianDps.ahk
#include %A_ScriptDir%\ahk_Marksman.ahk
#include %A_ScriptDir%\ahk_Nightblade.ahk
#include %A_ScriptDir%\ahk_Bard.ahk
#include %A_ScriptDir%\ahk_RogueTank.ahk
#include %A_ScriptDir%\ahk_Tard.ahk

#ifWinActive RIFT
{
	#MaxThreadsPerHotkey 2
	$f8::
		doAction2 := false
		doAction3 := false
		doAction4 := false
		doAction1 := not doAction1
		
		if (not doAction1)
			SetState4Value("NONE")
		else
			SetState4Value("Action 1")
		
		if (not loopStarted)
			ActionLoop()
		
	return


	#MaxThreadsPerHotkey 2
	$f9::
		doAction1 := false
		doAction3 := false
		doAction4 := false
		doAction2 := not doAction2
		
		if (not doAction2)
			SetState4Value("NONE")
		else
			SetState4Value("Action 2")
		
		if (not loopStarted)
			ActionLoop()
	return
		
		
	#MaxThreadsPerHotkey 2
	$f10::
		doAction1 := false
		doAction2 := false
		doAction4 := false
		doAction3 := not doAction3
		
		if (not doAction3)
			SetState4Value("NONE")
		else
			SetState4Value("Action 3")
		
		if (not loopStarted)
			ActionLoop()
	return
	
	#MaxThreadsPerHotkey 2
	$Numpad3::
		doAction1 := false
		doAction2 := false
		doAction3 := false
		doAction4 := not doAction4
		
		if (not doAction4)
			SetState4Value("NONE")
		else
			SetState4Value("Action 4")
		
		if (not loopStarted)
			ActionLoop()
	return


	#MaxThreadsPerHotkey 2
	$f11::
		doAction1 := false
		doAction2 := false
		doAction3 := false
		doAction4 := false
		
		SetState4Value("NONE")
		%clearFunction%()
	return

	#MaxThreadsPerHotkey 2
	$^1::
		%triggerFunction%(1)
	return

	#MaxThreadsPerHotkey 2
	$^2::
		%triggerFunction%(2)
	return

	#MaxThreadsPerHotkey 2
	$^3::
		%triggerFunction%(3)
	return

	#MaxThreadsPerHotkey 2
	$^4::
		%triggerFunction%(4)
	return

	#MaxThreadsPerHotkey 2
	$^5::
		%triggerFunction%(5)
	return
	
	#MaxThreadsPerHotkey 2
	$^6::
		%triggerFunction%(6)
	return
	
	#MaxThreadsPerHotkey 2
	$^7::
		%triggerFunction%(7)
	return	
	
	#MaxThreadsPerHotkey 2
	$^8::
		%triggerFunction%(8)
	return
	
	#MaxThreadsPerHotkey 2
	$^9::
		OutputDebug, doing Cleanse Soul
		
		suspendActions := true
		
		while (CleanseSoulAvailable())
		{
			DoKeyPress("!=", "Cleanse Soul")
			Sleep, 100
		}
		
		suspendActions := false
	return
	
	$Numpad1::
		comboPoints := GetComboPoints()
		%actionFunctionOne%(comboPoints)
	return
	
	$Numpad2::
		comboPoints := GetComboPoints()
		%actionFunctionTwo%(comboPoints)
	return
}

; main loop
ActionLoop()
{
	global ROLE
	global loopDelay
	global doAction1
	global doAction2
	global doAction3
	global doAction4
	global actionFunctionOne
	global actionFunctionTwo
	global actionFunctionThree
	global actionFunctionFour
	global suspendActions
	global loopStarted := true
	
	OutputDebug, thread loop started with delay %loopDelay%
	
	Loop
	{
		if (suspendActions || not WinActive("RIFT") || ChatBoxOpen())
		{
			Sleep, -1
			Sleep, %loopDelay%
			continue
		}
						
		comboPoints := GetComboPoints()
				
		if (doAction1)
			%actionFunctionOne%(comboPoints)
		else if (doAction2)
			%actionFunctionTwo%(comboPoints)
		else if (doAction3)
			%actionFunctionThree%(comboPoints)
		else if (doAction4)
			%actionFunctionFour%(comboPoints)
						
		Sleep, -1
		Sleep, %loopDelay%
	}
}


; role selection functions

CleanseSoulAvailable()
{
	return IsAlertIconShowing(546, 1058, 0x9C8C6B)
}

Tard()
{
	return IsAlertIconShowing(646, 1108, 0xD3A652)
}

Marksman()
{
	return IsAlertIconShowing(646, 1108, 0xEFFBFF)
}

Nightblade()
{
	return IsAlertIconShowing(646, 1107, 0x3F4231)
}

Bard()
{
	return IsAlertIconShowing(649, 1108, 0x6A8F9E)
}

TacticianDps()
{
	return IsAlertIconShowing(642, 1104, 0xD6D594)
}

Tank()
{
	return IsAlertIconShowing(643, 1105, 0xC4C5C4)
}


; timed subroutine to determine the role
DetermineRole:
if (WinActive("RIFT"))
{
	currentRole = %ROLE%
	if (Tank())
		ROLE := "Tank"
	else if (TacticianDps())
		ROLE := "TacticianDps"
	else if (Marksman())
		ROLE := "Marksman"
	else if (Nightblade())
		ROLE := "Nightblade"
	else if (Tard())
		ROLE := "Tard"
	else if (Bard())
		ROLE := "Bard"
		
	if (currentRole <> ROLE)
	{
		SetState1Name("<state 1 name>")
		SetState1Value("<state 1 value>")
		SetState2Name("<state 2 name>")
		SetState2Value("<state 2 value>")
		SetState3Name("<state 3 name>")
		SetState3Value("<state 3 value>")

		f = Initialize%ROLE%
		%f%()
	}
		
	actionFunctionOne = DoActionOne%ROLE%
	actionFunctionTwo = DoActionTwo%ROLE%
	actionFunctionThree = DoActionThree%ROLE%
	actionFunctionFour = DoActionFour%ROLE%
	triggerFunction = DoTrigger%ROLE%
	clearFunction = DoClear%ROLE%
	
	SetRoleName(ROLE)
}
return

SetRoleName(roleName)
{
	GuiControl, , RoleNameTextBox, %roleName%
}

SetState1Name(name)
{
	GuiControl, , State1NameTextBox, %name%
}

SetState1Value(value)
{
	GuiControl, , State1ValueTextBox, %value%
}

SetState2Name(name)
{
	GuiControl, , State2NameTextBox, %name%
}

SetState2Value(value)
{
	GuiControl, , State2ValueTextBox, %value%
}

SetState3Name(name)
{
	GuiControl, , State3NameTextBox, %name%
}

SetState3Value(value)
{
	GuiControl, , State3ValueTextBox, %value%
}

SetState4Name(name)
{
	GuiControl, , State4NameTextBox, %name%
}

SetState4Value(value)
{
	GuiControl, , State4ValueTextBox, %value%
}

CreateGui:
SetTimer, CreateGui, Off
Gui, Font, S11 CDefault, Times New Roman
Gui, Add, Text, x16 y28 w90 h30 +Right +ReadOnly, Role:
Gui, Add, Edit, vRoleNameTextBox x116 y28 w210 h30 +ReadOnly +ReadOnly, <role name>
Gui, Add, Edit, vState1NameTextBox x16 y108 w160 h30 +Right +ReadOnly, <state 1 name>
Gui, Add, Edit, vState1ValueTextBox x196 y108 w240 h30 +ReadOnly, <state 1 value>

Gui, Add, Edit, vState2NameTextBox x16 y148 w160 h30 +Right +ReadOnly, <state 2 name>
Gui, Add, Edit, vState2ValueTextBox x196 y148 w240 h30 +ReadOnly, <state 2 value>

Gui, Add, Edit, vState3NameTextBox x16 y188 w160 h30 +Right +ReadOnly, <state 3 name>
Gui, Add, Edit, vState3ValueTextBox x196 y188 w240 h30 +ReadOnly, <state 3 value>

Gui, Add, Edit, vState4NameTextBox x16 y243 w160 h30 +Right +ReadOnly, Ability
Gui, Add, Edit, vState4ValueTextBox x196 y243 w240 h30 +ReadOnly, <ability value>
Gui, Add, Edit, vHiddenTextBox x276 y68 w60 h20 +Hidden, Edit
; Generated using SmartGUI Creator 4.0
Gui, Show, x1950 y300 h300 w500, Rogue
WinActivate, RIFT
Return


GuiClose:
	SetNumLockState, On
	if (hHook)
		DllCall("UnhookWindowsHookEx", Ptr, hHook)
	if (hMod)
		DllCall("FreeLibrary", Ptr, hMod)
	ExitApp