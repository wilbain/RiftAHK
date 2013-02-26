#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
#NoTrayIcon
#SingleInstance
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

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

actionFunctionOne := ""
actionFunctionTwo := ""
actionFunctionThree := ""
triggerFunction := ""
clearFunction := ""

loopStarted := false

SetTimer, DetermineRole, 5000

SetTimer, CreateGui, 1000


#Include %A_ScriptDir%\Lib\RiftUtils.ahk

#include %A_ScriptDir%\ahk_HarbingerSolo.ahk

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
			SetState2Value("OFF")
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
			SetState2Value("OFF")
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
			SetState2Value("OFF")
	return	

	$f11::
		doAction1 := false
		doAction2 := false
		doAction3 := false
		
		SetState2Value("OFF")
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
	global loopStarted := true
	
	OutputDebug, thread loop started with delay %loopDelay%
	
	Loop
	{
		if (not doAction1 && not doAction2 && not doAction3)
		{
			Sleep, %loopDelay%
			continue
		}
						
		if (doAction1)
			%actionFunctionOne%()
		else if (doAction2)
			%actionFunctionTwo%()
		else if (doAction3)
			%actionFunctionThree%()
		
		Sleep, %loopDelay%
	}
}


; role selection functions

HarbingerSolo()
{
	return IsAlertIconShowing(611, 1115, 0x8C584B)
}

Role2()
{
	
}

Role3()
{
	
}

Role4()
{
	
}

Role5()
{
	
}

Role6()
{
	
}


; timed subroutine to determine the role
DetermineRole:
if (WinActive("RIFT"))
{
	currentRole = %ROLE%
	if (HarbingerSolo())
		ROLE := "HarbingerSolo"
	else if (Role2())
		ROLE := "Role2"
	else if (Role3())
		ROLE := "Role3"
	else if (Role4())
		ROLE := "Role4"
	else if (Role5())
		ROLE := "Role5"
	else if (Role6())
		ROLE := "Role6"
		
	if (currentRole <> ROLE)
	{
		SetState1Name("<state 1 name>")
		SetState1Value("<state 1 value>")
		SetState2Value("OFF")

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

CreateGui:
SetTimer, CreateGui, Off
Gui, Font, S11 CDefault, Times New Roman
Gui, Add, Text, x16 y28 w90 h30 +Right +ReadOnly, Role:
Gui, Add, Edit, vRoleNameTextBox x116 y28 w210 h30 +ReadOnly +ReadOnly, <role name>
Gui, Add, Edit, vState1NameTextBox x16 y108 w160 h30 +Right +ReadOnly, <state 1 name>
Gui, Add, Edit, vState1ValueTextBox x196 y108 w240 h30 +ReadOnly, <state 1 value>
Gui, Add, Edit, vState2NameTextBox x16 y158 w160 h30 +Right +ReadOnly, Ability
Gui, Add, Edit, vState2ValueTextBox x196 y158 w240 h30 +ReadOnly, <state 2 value>
Gui, Add, Edit, vHiddenTextBox x276 y68 w60 h20 +Hidden, Edit
; Generated using SmartGUI Creator 4.0
Gui, Show, x1950 y300 h255 w477, Rift Mage Role
WinActivate, RIFT
Return

GuiClose:
	if (hHook)
		DllCall("UnhookWindowsHookEx", Ptr, hHook)
	if (hMod)
		DllCall("FreeLibrary", Ptr, hMod)
	ExitApp