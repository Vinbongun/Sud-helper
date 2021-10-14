Local $hWnd = WinGetHandle("[CLASS:WindowsForms10.Window.8.app.0.378734a]", "")
;~ Local $square = ControlGetText($hWnd, "", "[CLASS:WindowsForms10.EDIT.app.0.378734a7; INSTANCE:7]")
Local $square = ControlGetText($hWnd, "", "[ID:854278]")



WinSetTitle ( "", "2018 Карточка объекта", "newtitle" )
MsgBox(4096, "Заголовок", $hWnd)
MsgBox(4096, "$nID", ControlFocus($hWnd, "", "[NAME:01.01.2018]"))