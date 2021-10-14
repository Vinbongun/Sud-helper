#include <MsgBoxConstants.au3>

Func getText()
    Return ControlGetText("Редактирование", "", "[CLASS:WindowsForms10.EDIT.app.0.378734a; INSTANCE:1]")
EndFunc

if getText() <> '' Then
    $get = ControlGetText("Редактирование", "", "[CLASS:WindowsForms10.EDIT.app.0.378734a; INSTANCE:1]")
    $sText = StringReplace($get, "«", "")
    $sText = StringReplace($sText, "»", "")
    $sText = StringReplace($sText, """", "")

    ControlSetText("Редактирование", "", "[CLASS:WindowsForms10.EDIT.app.0.378734a; INSTANCE:1]", $sText)
Else
    MsgBox(4096, 'Процесс', 'Не пустая строка')
EndIf