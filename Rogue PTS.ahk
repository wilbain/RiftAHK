#NoEnv
#NoTrayIcon
#SingleInstance
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
Thread, interrupt, 0  ; make all threads always interruptible


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

loopDelay := 200
doAction1 := false
doAction2 := false
doAction3 := false
suspendActions := false

actionFunctionOne := ""
actionFunctionTwo := ""
actionFunctionThree := ""
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
		doAction1 := not doAction1
		if (doAction1)
		{
			doAction2 := false
			doAction3 := false
		}
		if (not loopStarted)
			ActionLoop()
		
		if (not doAction1 && not doAction2 && not doAction3)
			SetState3Value("OFF")
	return


	#MaxThreadsPerHotkey 2
	$f9::
		doAction2 := not doAction2
		if (doAction2)
		{
			doAction1 := false
			doAction3 := false
		}
		if (not loopStarted)
			ActionLoop()
		
		if (not doAction1 && not doAction2 && not doAction3)
			SetState3Value("OFF")
	return
		
		
	#MaxThreadsPerHotkey 2
	$f10::
		doAction3 := not doAction3
		if (doAction3)
		{
			doAction1 := false
			doAction2 := false
		}
		if (not loopStarted)
			ActionLoop()
		
		if (not doAction1 && not doAction2 && not doAction3)
			SetState3Value("OFF")
	return	

	$f11::
		doAction1 := false
		doAction2 := false
		doAction3 := false
		
		SetState4Value("OFF")
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
		OutputDebug, doing Cleanse Soul
		
		currentDoAction1 := doAction1
		currentDoAction2 := doAction2
		currentDoAction3 := doAction3
		
		doAction1 := false
		doAction2 := false
		doAction3 := false
		
		while (CleanseSoulAvailable())
		{
			DoThrottledKeyPress("!=", "cleanse soul")
			Sleep, %loopDelay%
		}
		
		doAction1 := currentDoAction1
		doAction2 := currentDoAction2
		doAction3 := currentDoAction3
	return
	
	#MaxThreadsPerHotkey 2
	$^7::
		%triggerFunction%(7)
	return	
	
	#MaxThreadsPerHotkey 2
	$^8::
		%triggerFunction%(8)
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
	global actionFunctionOne
	global actionFunctionTwo
	global actionFunctionthree
	global suspendActions
	global loopStarted := true
	
	OutputDebug, thread loop started with delay %loopDelay%
	
	Loop
	{
		if (suspendActions || not WinActive("RIFT") ||ChatBoxOpen())
		{
			Sleep, -1
			Sleep, 100
			continue
		}
				
		comboPoints := GetComboPoints()
				
		if (doAction1)
			%actionFunctionOne%(comboPoints)
		else if (doAction2)
			%actionFunctionTwo%(comboPoints)
		else if (doAction3)
			%actionFunctionThree%(comboPoints)
		
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
	return IsAlertIconShowing(616, 1117, 0xC8943B)
}

Marksman()
{
	return IsAlertIconShowing(616, 1128, 0xB4DEEE)
}

RangerSab()
{
	return IsAlertIconShowing(608, 1128, 0x984A31)
}

Bard()
{
	return IsAlertIconShowing(620, 1128, 0x516A77)
}

TacticianDps()
{
	return IsAlertIconShowing(622, 1126, 0xE07956)
}

Assassin()
{
	return IsAlertIconShowing(620, 1126, 0x252537)
}


; timed subroutine to determine the role
DetermineRole:
if (WinActive("RIFT"))
{
	currentRole = %ROLE%
	if (Assassin())
		ROLE := "Assassin"
	else if (TacticianDps())
		ROLE := "TacticianDps"
	else if (Marksman())
		ROLE := "Marksman"
	else if (RangerSab())
		ROLE := "RangerSab"
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
Gui, Show, x1950 y300 h300 w500, Maintenance Console
WinActivate, RIFT
Return


GuiClose:
	if (hHook)
		DllCall("UnhookWindowsHookEx", Ptr, hHook)
	if (hMod)
		DllCall("FreeLibrary", Ptr, hMod)
	ExitApp