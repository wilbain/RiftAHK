#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.



SendPixelValuesToClipboard()
{
	MouseGetPos x, y
	MouseMove 0, 0
	Sleep 100
	PixelGetColor, col, %x%, %y%
	Sleep 100
	MouseMove %x%, %y%
	
	Clipboard = %x%, %y%, %col%
}
