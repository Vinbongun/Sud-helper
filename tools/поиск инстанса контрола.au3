#include <WinAPI.au3>

_Main()

Func _Main()
    Local $button
    GUICreate("Тест")
    $button = GUICtrlCreateButton("Тестирование", 0, 0)
    MsgBox(262144, "ID", "Идентификатор элемента: " & _WinAPI_GetDlgCtrlID(GUICtrlGetHandle($button)))
EndFunc   ;==>_Main