#include <MsgBoxConstants.au3>
#include <Array.au3>
;~ 77:01:0002026:2396 - Нежилое помещение
;~ 77:10:0003009:7 - зу
;~ 77:10:0005006:1014 - здание
;~ 77:06:0004011:4929 - не определенно
;~ 77:04:0002007:12462 - жилое помещение
;~ MsgBox($MB_SYSTEMMODAL, "", getText(52))

$aProcessList = ProcessList("OTVET_2018_OKS.exe")
;~ MsgBox(4096, 'Процесс', $aProcessList[2][1])
;~ MsgBox(4096, 'Процесс', $aProcessList[1][1])

;~ Получение информации
Func getText($INSTANCE)
    Return ControlGetText("[CLASS:WindowsForms10.Window.8.app.0.13965fa_r9_ad1]", "", "[CLASS:WindowsForms10.STATIC.app.0.13965fa_r9_ad1; INSTANCE:"& $INSTANCE &"]")
EndFunc

;~ Нажатие на кнопку выбора типа объекта
Func chooseType($Param)
    ControlClick('Редактирование', '', '[CLASS:WindowsForms10.Window.8.app.0.378734a; INSTANCE:12]', "main")
    WinActivate('Справочник')
    ControlClick('Справочник', '', '[CLASS:WindowsForms10.Window.8.app.0.378734a; INSTANCE:2]', "main")
    For $i = 1 To $Param
        Send("{DOWN}")
    Next
    ControlClick('Справочник', '', '[CLASS:WindowsForms10.BUTTON.app.0.378734a; INSTANCE:2]', "main")
EndFunc

;~ Проверка на тип назначения и копирования информации в переменные

if getText(51) = "Нежилое помещение" Then
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
        $squareOks = getText(66)
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
    Else
        MsgBox($MB_SYSTEMMODAL, "", 'Ничего не вставленно')
        Exit
	EndIf


;~ MsgBox($MB_SYSTEMMODAL, "", $kadNameOks)

;~ Заполнение информации в спо суды
ControlSetText("Редактирование", "", "[CLASS:WindowsForms10.EDIT.app.0.378734a; INSTANCE:9]", $kadNameOks)
ControlSetText("Редактирование", "", "[CLASS:WindowsForms10.EDIT.app.0.378734a; INSTANCE:7]", $squareOks)
ControlSetText("Редактирование", "", "[CLASS:WindowsForms10.EDIT.app.0.378734a; INSTANCE:6]", $cadastralValueOks)
ControlSetText("Редактирование", "", "[CLASS:WindowsForms10.EDIT.app.0.378734a; INSTANCE:4]", $adressOks)
ControlSetText("Редактирование", "", "[CLASS:WindowsForms10.EDIT.app.0.378734a; INSTANCE:8]", '01.01.201')
  ControlClick("Редактирование", "", "[CLASS:WindowsForms10.EDIT.app.0.378734a; INSTANCE:8]", 'main')
