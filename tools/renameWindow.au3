#include <MsgBoxConstants.au3>
#include <Array.au3>

;~ 
Global $hWnd = WinGetHandle("2018 Карточка объекта")
$i = 1

While $i < 2
    $firstTitle = "2018 Карточка объекта " & $i
    WinSetTitle($hWnd, "", $firstTitle)
    Sleep(500)
    $hWnd = WinGetHandle("2018 Карточка объекта")
    $i = $i + 1
WEnd 

MsgBox($MB_SYSTEMMODAL, "2018 Карточка объекта", WinGetHandle("2018 Карточка объекта"))
MsgBox($MB_SYSTEMMODAL, "2018 Карточка объекта 1", WinGetHandle("2018 Карточка объекта 1"))