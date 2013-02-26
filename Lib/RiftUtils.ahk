#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

;#Include %A_ScriptDir%\Utils.ahk

lastThrottledKeyPress := 0


#ifWinActive RIFT
{
	f12::
		GetAlertIconLineForCursor()
		return		
		
	^+1::
		GetComboPointDetails(1)
		return
	^+2::
		GetComboPointDetails(2)
		return
	^+3::
		GetComboPointDetails(3)
		return
	^+4::
		GetComboPointDetails(4)
		return
	^+5::
		GetComboPointDetails(5)
		return
}

DoKeyPress(key, comment="", cp="")
{	
	Send %key%
	OutputDebug [%key% %comment%] [cp=%cp%]
}

ChatBoxOpen()
{
	return IsAlertIconShowing(470, 1177, 0x3E3E3E)
}

GetComboPoints()
{
	PixelGetColor pCol, 708, 903
	if (pCol = 0xFAEDDC)
		return 5
	PixelGetColor pCol, 677, 902
	if (pCol = 0xFFFBEE)
		return 4
	PixelGetColor pCol, 644, 902
	if (pCol = 0xFFFDF5)
		return 3
	PixelGetColor pCol, 615, 902
	if (pCol = 0xFFFAED)
		return 2
	PixelGetColor pCol, 583, 903
	if (pCol = 0xFCF3E0)
		return 1
	
	return 0
}

GetPowerPoints()
{
	PixelGetColor pCol, 984, 21
	if (pCol = 0x0000FF)
		return 3
	PixelGetColor pCol, 919, 21
	if (pCol = 0x0000FF)
		return 2
	PixelGetColor pCol, 857, 24
	if (pCol = 0x0000FF)
		return 1
	return 0
}

Moving()
{
	GetKeyState, leftMouse, LButton
	GetKeyState, rightMouse, RButton
	GetKeyState, qKey, q
	GetKeyState, eKey, e
	GetKeyState, sKey, s
	GetKeyState, wKey, w
	moving := (leftMouse = "D" && rightMouse = "D") || (qKey = "D" || eKey = "D" || sKey = "D" || wKey = "D")
	return moving
}

GetAlertIconLineForCursor()
{
	MouseGetPos x, y
	MouseMove 0, 0
	Sleep 100
	PixelGetColor, col, %x%, %y%
	Sleep 100
	MouseMove %x%, %y%
	
	Clipboard = return IsAlertIconShowing(%x%, %y%, %col%)
}

GetComboPointDetails(point)
{
	MouseGetPos x, y
	MouseMove 0, 0
	Sleep 100
	PixelGetColor, col, %x%, %y%
	Sleep 100
	MouseMove %x%, %y%
	
	Clipboard = PixelGetColor pCol, %x%, %y%`n`tif (pCol = %col%)`n`t`treturn %point%
}

IsAlertIconShowing(x, y, col)
{
	PixelGetColor pCol, x, y
	return (pCol = col)
}

InCombat()
{
	return IsAlertIconShowing(499, 1002, 0x4AE5FF)
}

HaveTarget()
{
	return IsAlertIconShowing(508, 1066, 0xAAA68F)
}

IceShieldUp()
{
	return IsAlertIconShowing(971, 93, 0xBE8F32)
}