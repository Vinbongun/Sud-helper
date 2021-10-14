#include <GuiconstantsEx.au3>
#include <WindowsConstants.au3>

HotKeySet("{ESC}", "On_Exit")
Func On_Exit()
    Exit
EndFunc

$hGUI = GUICreate("X", 50, 50, -1, -1, BitOR($WS_POPUP, $WS_BORDER), $WS_EX_TOPMOST)
GUISetBkColor(0x1eb2a6, $hGUI)
GUISetState()

While 1
    Sleep(10)
WEnd