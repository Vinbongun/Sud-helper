#include <ButtonConstants.au3>
#include <GUIConstantsEx.au3>
#include <StaticConstants.au3>
#include <WindowsConstants.au3>
#include <MsgBoxConstants.au3>
#include <Date.au3>
#pragma compile(FileDescription, Приложение помогает в работе с системой СПО Суды)
#pragma compile(ProductName, Помощник суды)
#pragma compile(LegalCopyright, Илюхин Богдан)
#pragma compile(CompanyName, 'ГБУ Центр имущественных платежей и жилищного страхования')
#pragma compile(Icon, C:\Users\9\Desktop\Autoit\ico\Chanut-Role-Playing-King.ico)
#pragma compile(FileVersion, 2.5.0)
#pragma compile(ProductVersion, 2.5)

#NoTrayIcon

;~ отключает остановку скрипта по нажатию на иконку в трее
Opt("TrayAutoPause", 0)

; Проверка на запуск одного экземпляра приложения
$p = ProcessList(StringReplace(@ScriptName,".au3",".exe"))
If $p[0][0] > 1 Then
    MsgBox(0,"Внимание", "Приложение уже запущенно", 3)
    Exit
EndIf

;~ --------------- Модуль сохранения настроек приложения ----------------

;~ При закрытии приложения сохранить расположение окна
OnAutoItExitRegister("saveSettings")

$sPathToIni = 'C:\СПО\sud-helper\config.ini'

$X = IniRead($sPathToIni, 'POS', 'X', -1)
$Y = IniRead($sPathToIni, 'POS', 'Y', -1)
$isChecked = IniRead($sPathToIni, 'Settings', 'setOnTop', -1)

Func saveSettings()
	$aWinPos = WinGetPos($Form1)
	If Not FileExists('C:\СПО\sud-helper\') Then ; если нет папки с настройками, то создается
		DirCreate('C:\СПО\sud-helper\')
	EndIf
	IniWrite($sPathToIni, 'POS', 'X', $aWinPos[0])
	IniWrite($sPathToIni, 'POS', 'Y', $aWinPos[1])
	IniWrite($sPathToIni, 'Settings', 'setOnTop', GUICtrlRead($nCheckBox))
	Exit
EndFunc

;~ -------///////// Модуль сохранения настроек приложения ----------------

;~ ------------------ Модуль обновления ----------------
$lastCheckUpdate = IniRead($sPathToIni, 'Settings', 'lastCheckUpdate', -1);последняя дата проверки новой версии приложения
ConsoleWrite('Дата последней проверки: ' & $lastCheckUpdate & @CRLF)
$iDateCalc = _DateDiff( 'n',$lastCheckUpdate,_NowCalc());считает разницу между времени между последней датой проверки и текущей

If $iDateCalc > 60 Then ;если файл создан больше 60 минут или в настройках не создана строка последнего обновления
	checkUpdate()
Else
	ConsoleWrite("Меньше 60 минут. Всего прошло: " & $iDateCalc & @CRLF )
EndIf

Func checkUpdate()
	ConsoleWrite('Поиск нового обновления'& @CRLF)
	DirCreate('C:\СПО\sud-helper\update')

	InetGet("http://vinbongun.com/sud-helper/version.ini", "C:\СПО\sud-helper\update\version.ini", 1) ;скачивает версионный файл с сервера

	$oldAppVersion = IniRead('C:\СПО\sud-helper\version.ini', 'Version', 'ver', -1)
	$newAppVersion = IniRead('C:\СПО\sud-helper\update\version.ini', 'Version', 'ver', -1)

	If $oldAppVersion < $newAppVersion Then ;если на сервере новая версия приложения
		MsgBox(0,"Внимание", "Начата проверка новой версии", 3)
		FileMove ("C:\СПО\sud-helper\update\version.ini", "C:\СПО\sud-helper\version.ini", 1) ;заменяет версионный файл новым
		InetGet("http://vinbongun.com/sud-helper/%D0%9F%D0%BE%D0%BC%D0%BE%D1%89%D0%BD%D0%B8%D0%BA%20%D1%81%D1%83%D0%B4%D1%8B.exe", "C:\СПО\sud-helper\update\Помощник суды.exe", 1) ;скачивает новую версию приложения
		While ProcessExists("Помощник суды.exe") ;пока процесс существует
			ProcessClose("Помощник суды.exe") ;пытается его закрыть
			MsgBox(0,"Внимание", "Пытаюсь закрыть приложение", 3)
			ExitLoop
		WEnd
		MsgBox(0,"Внимание", "Идет проверка", 3)
		FileMove ("C:\СПО\sud-helper\update\Помощник суды.exe", "C:\СПО\sud-helper\Помощник суды.exe", 1) ;заменяет старый контрольный файл новым
		Sleep(2000)
;~ 		Run("C:\СПО\sud-helper\Помощник суды.exe") ;запускает ПО
		FileCreateShortcut("C:\СПО\sud-helper\Помощник суды.exe", @DesktopDir & "\Помощник суды.lnk"); Создаёт ярлык
		ConsoleWrite('Приложение обновленно до последней версии'& @CRLF)
	Else
		ConsoleWrite('Нет новой версии'& @CRLF)
	EndIf
;~ 	DirRemove('C:\СПО\sud-helper\update', 1);удаляет папку с обновлением
	IniWrite($sPathToIni, 'Settings', 'lastCheckUpdate', _NowCalc());добавляет дату последней проверки обновления
EndFunc

;~ ------------- ////////// Модуль обновления ----------------

Global $semafore = False

#Region ### START Koda GUI section ### Form=
$Form1 = GUICreate("Помощник Суды", 149, 170, $X, $Y, $GUI_SS_DEFAULT_GUI - $WS_MINIMIZEBOX)
$Label1 = GUICtrlCreateLabel("Помощник Суды", 25, 10, 110, 30)
GUICtrlSetColor(-1, 0x6e5773)
GUICtrlSetFont(-1, 8, 800, 0, "MS Sans Serif")
;~ $labelVersion = GUICtrlCreateLabel("версия " & IniRead("C:\СПО\sud-helper\version.ini", 'Version', 'ver', -1), 45, 28, 110, 30)
$labelVersion = GUICtrlCreateLabel("версия " & FileGetVersion("Помощник суды.exe", $FV_PRODUCTVERSION), 45, 28, 110, 30)
GUICtrlSetColor(-1, 0x6e5773)
GUICtrlSetFont(-1, 8, 800, 0, "MS Sans Serif")
$StartStop = GUICtrlCreateButton("Включить", 35, 72, 85, 25)
GUICtrlSetColor(-1, 0x6e5773)
GUICtrlSetFont(-1, 8, 800, 0, "MS Sans Serif")
$sendData = GUICtrlCreateButton("Заполнить", 35, 105, 85, 25)
GUICtrlSetColor(-1, 0x6e5773)
GUICtrlSetFont(-1, 8, 800, 0, "MS Sans Serif")
$Label2 = GUICtrlCreateLabel("Статус:", 40, 48, 41, 17)
GUICtrlSetColor(-1, 0x6e5773)
GUICtrlSetFont(-1, 8, 800, 0, "MS Sans Serif")
$nCheckBox = GUICtrlCreateCheckbox('Поверх окон', 30, 140, 100, 20)
GUICtrlSetColor(-1, 0x6e5773)
GUICtrlSetFont(-1, 8, 800, 0, "MS Sans Serif")
GUISetBkColor(0xfffdf9, $Form1)
$Status = GUICtrlCreateLabel("выкл", 88, 48, 30, 17)
GUICtrlSetState($nCheckBox,$isChecked)
GUISetState(@SW_SHOW)
#EndRegion ### END Koda GUI section ###

While 1
	$nMsg = GUIGetMsg()
	Switch $nMsg
		Case $GUI_EVENT_CLOSE
			Exit
		Case $StartStop
			If $semafore = True Then
				$semafore = False
				GUICtrlSetData($StartStop,'Включить')
				GUICtrlSetColor(-1, 0xFF0000)
			Else
				$semafore = True
				GUICtrlSetData($StartStop,'Выключить')
				GUICtrlSetColor(-1, 0xd45079)
			EndIf
		Case $sendData
					;~ Проверка на тип назначения и копирования информации в переменные
					If getText(51) = "Нежилое помещение" Then
							$kadNameOks = getText(68)
							$squareOks = getText(64)
							$cadastralValueOks = getText(60)
							$adressOks = getText(49)
							chooseType(3)
						ElseIf getText(53) = "Нежилое помещение" Then
							$kadNameOks = getText(70)
							$squareOks = getText(66)
							$cadastralValueOks = getText(62)
							$adressOks = getText(51)
							chooseType(3)
						ElseIf getText(47) = "Нежилое помещение" Then
							$kadNameOks = getText(64)
							$squareOks = getText(60)
							$cadastralValueOks = getText(56)
							$adressOks = getText(45)
							chooseType(3)
						ElseIf getText(45) = "Нежилое помещение" Then
							$kadNameOks = getText(62)
							$squareOks = getText(58)
							$cadastralValueOks = getText(54)
							$adressOks = getText(43)
							chooseType(3)
						ElseIf getText(39) = "Нежилое помещение" Then
							$kadNameOks = getText(56)
							$squareOks = getText(52)
							$cadastralValueOks = getText(48)
							$adressOks = getText(37)
							chooseType(3)
						ElseIf getText(35) = "Нежилое помещение" Then
							$kadNameOks = getText(52)
							$squareOks = getText(48)
							$cadastralValueOks = getText(44)
							$adressOks = getText(33)
							chooseType(3)
						ElseIf getText(47) = "Нежилое здание" Then
							$kadNameOks = getText(64)
							$squareOks = getText(60)
							$cadastralValueOks = getText(56)
							$adressOks = getText(45)
							chooseType(2)
						ElseIf getText(51) = "Нежилое здание" Then
							$kadNameOks = getText(68)
							$squareOks = getText(64)
							$cadastralValueOks = getText(60)
							$adressOks = getText(49)
							chooseType(2)
						ElseIf getText(53) = "Нежилое здание" Then
							$kadNameOks = getText(70)
							Global $squareOks = getText(66)
							$cadastralValueOks = getText(62)
							$adressOks = getText(51)
							chooseType(2)
						ElseIf getText(49) = "Нежилое здание" Then
							$kadNameOks = getText(66)
							$squareOks = getText(62)
							$cadastralValueOks = getText(58)
							$adressOks = getText(47)
							chooseType(2)
						ElseIf getText(35) = "Не определено" Then
							$kadNameOks = getText(52)
							$squareOks = getText(48)
							$cadastralValueOks = getText(44)
							$adressOks = getText(33)
							chooseType(0)
						ElseIf getText(47) = "Жилое помещение" Then
							$kadNameOks = getText(64)
							$squareOks = getText(60)
							$cadastralValueOks = getText(56)
							$adressOks = getText(45)
							chooseType(3)
						ElseIf getText(41) = "Жилое помещение" Then
							$kadNameOks = getText(58)
							$squareOks = getText(54)
							$cadastralValueOks = getText(50)
							$adressOks = getText(39)
							chooseType(3)
						ElseIf getText(51) = "Землепользование" Then
							$kadNameOks = getText(66)
							$squareOks = getText(62)
							$cadastralValueOks = getText(58)
							$adressOks = getText(47)
							chooseType(1)
						ElseIf getText(49) = "Землепользование" Then
							$kadNameOks = getText(64)
							$squareOks = getText(60)
							$cadastralValueOks = getText(56)
							$adressOks = getText(45)
							chooseType(1)
						ElseIf getText(45) = "Землепользование" Then
							$kadNameOks = getText(60)
							$squareOks = getText(56)
							$cadastralValueOks = getText(52)
							$adressOks = getText(41)
							chooseType(1)
						ElseIf getText(47) = "Землепользование" Then
							$kadNameOks = getText(62)
							$squareOks = getText(58)
							$cadastralValueOks = getText(54)
							$adressOks = getText(43)
							chooseType(1)
						ElseIf getText(37) = "Землепользование" Then
							$kadNameOks = getText(52)
							$squareOks = getText(48)
							$cadastralValueOks = getText(44)
							$adressOks = getText(33)
							chooseType(1)
						ElseIf getText(35) = "Нежилое здание" Then
							$kadNameOks = getText(52)
							$squareOks = getText(48)
							$cadastralValueOks = getText(44)
							$adressOks = getText(33)
							chooseType(2)
						ElseIf getText(35) = "Жилой дом" Then
							$kadNameOks = getText(52)
							$squareOks = getText(48)
							$cadastralValueOks = getText(44)
							$adressOks = getText(33)
							chooseType(2)
						ElseIf getText(37) = "Комплекс АЗС" Then
							$kadNameOks = getText(52)
							$squareOks = StringRegExpReplace(getText(13), '[^0-9,.]', '')
							$cadastralValueOks = getText(44)
							$adressOks = getText(33)
							chooseType(4)
						Else
							MsgBox($MB_SYSTEMMODAL, "", 'Ничего не вставленно')
;~ 							Exit
						EndIf

					;~ Заполнение информации в спо суды
					ControlSetText("Редактирование", "", "[CLASS:WindowsForms10.EDIT.app.0.378734a; INSTANCE:9]", $kadNameOks)
					ControlSetText("Редактирование", "", "[CLASS:WindowsForms10.EDIT.app.0.378734a; INSTANCE:7]", $squareOks)
					ControlSetText("Редактирование", "", "[CLASS:WindowsForms10.EDIT.app.0.378734a; INSTANCE:6]", $cadastralValueOks)
					ControlSetText("Редактирование", "", "[CLASS:WindowsForms10.EDIT.app.0.378734a; INSTANCE:4]", $adressOks)
					ControlSetText("Редактирование", "", "[CLASS:WindowsForms10.EDIT.app.0.378734a; INSTANCE:8]", '01.01.201')
					ControlClick("Редактирование", "", "[CLASS:WindowsForms10.EDIT.app.0.378734a; INSTANCE:8]", 'main')

		;~Поверх всех окон
		Case $nCheckBox or $isChecked = 1
			WinSetOnTop($Form1, '', BitAND(GUICtrlRead($nCheckBox), $GUI_CHECKED))
		EndSwitch

		If $semafore Then

		;~ 	Фоновая помощь в судах
				$edit = ControlGetText("Редактирование", "", "[CLASS:WindowsForms10.EDIT.app.0.378734a; INSTANCE:1]")
				$resultEdit = StringRegExpReplace($edit, '[[:punct:]«»]', '')
			If $edit <> $resultEdit Then
				ControlSetText("Редактирование", "", "[CLASS:WindowsForms10.EDIT.app.0.378734a; INSTANCE:1]", $resultEdit)
				ConsoleWrite ( 'Input ' & $edit & @CRLF)
				ConsoleWrite ( 'Result' & $resultEdit & @CRLF)
			EndIf

			If ControlGetText("Помощник Суды", "", $Status)  <> 'вкл.' Then
				GUICtrlSetData($Status,'вкл.')
				GUICtrlSetColor($Status, 0x008000)
				ConsoleWrite ( 'On' & @CRLF)
			EndIf

		Else
			If ControlGetText("Помощник Суды", "", $Status)  <> 'выкл.' Then
				GUICtrlSetData($Status,'выкл.')
				GUICtrlSetColor(-1, 0xd45079)
				ConsoleWrite ( 'Off' & @CRLF)
			EndIf
		EndIf
WEnd

;~ Получение информации
Func getText($INSTANCE)
	Return ControlGetText("[CLASS:WindowsForms10.Window.8.app.0.13965fa_r9_ad1]", "", "[CLASS:WindowsForms10.STATIC.app.0.13965fa_r9_ad1; INSTANCE:"& $INSTANCE &"]")
EndFunc

;~ Нажатие на кнопку выбора типа объекта
Func chooseType($Param)
	Do
	If ControlGetText("Редактирование", "", "[CLASS:WindowsForms10.EDIT.app.0.378734a; INSTANCE:5]") = "Данные отсутствуют" or ControlGetText("Редактирование", "", "[CLASS:WindowsForms10.EDIT.app.0.378734a; INSTANCE:5]") = "" Then  ;проверка на правильное заполнение
		ControlClick('Редактирование', '', '[CLASS:WindowsForms10.Window.8.app.0.378734a; INSTANCE:12]', "main")
		WinActivate('Справочник')
		ControlClick('Справочник', '', '[CLASS:WindowsForms10.Window.8.app.0.378734a; INSTANCE:2]', "main")
		For $i = 1 To $Param
			Send("{DOWN}")
		Next
		ControlClick('Справочник', '', '[CLASS:WindowsForms10.BUTTON.app.0.378734a; INSTANCE:2]', "main")
	EndIf
	Until ControlGetText("Редактирование", "", "[CLASS:WindowsForms10.EDIT.app.0.378734a; INSTANCE:5]") <> "Данные отсутствуют"
EndFunc

