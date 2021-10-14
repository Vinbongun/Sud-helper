
;~ ----- Поиск окна по заголовку -----
Func getTypeOfWindow()
$typeOfWindow = 'nope'

If WinActive(WinGetTitle("Рыночные отчеты")) Then
	$typeOfWindow = '1'
EndIf

If WinActive(WinGetTitle("Экспертные заключения")) Then
	$typeOfWindow = '2'
EndIf

If WinActive(WinGetTitle("Судебные решения")) Then
	$typeOfWindow = '3'
EndIf

If WinActive(ControlGetText("Редактирование", "", "[CLASS:WindowsForms10.STATIC.app.0.378734a; INSTANCE:5]")) = "Отчет об оценке" Then
	$typeOfWindow = '7'
EndIf

If WinActive(ControlGetText("Редактирование", "", "[CLASS:WindowsForms10.STATIC.app.0.378734a; INSTANCE:8]")) = "Номер отчета" Then
	$typeOfWindow = '8'
EndIf

If WinActive(WinGetTitle("Организация")) Then
	$typeOfWindow = '4'
EndIf

If WinActive(WinGetTitle("Фамилия Имя Отчество")) Then
	$typeOfWindow = '5'
EndIf
$header = WinGetTitle("Наименование СРО")
If WinActive(WinGetTitle("Наименование СРО")) Then
	$typeOfWindow = '6'
EndIf

;~ If $textOfLabel = "" Then
;~ 	$typeOfWindow = '9'
;~ EndIf

;~ If $textOfLabel = "" Then
;~ 	$typeOfWindow = '10'
;~ EndIf

;~ If $textOfLabel = "" Then
;~ 	$typeOfWindow = '11'
;~ EndIf

;~ If $textOfLabel = "" Then
;~ 	$typeOfWindow = '12'
;~ EndIf
ConsoleWrite ( 'Header: ' & $header & @CRLF)
Return $typeOfWindow

EndFunc

ConsoleWrite ( 'Номер окна: ' & getTypeOfWindow() & @CRLF)

;~ ----- //// Поиск окна по заголовку -----