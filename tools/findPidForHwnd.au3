#include <Array.au3> ; для _ArrayDisplay

; Список только процессов AutoIt3.exe
$aProcessList = ProcessList("OTVET_2018_OKS.exe")
;~ For $i = 1 To $aProcessList[0][0]
;~     MsgBox(4096, $aProcessList[$i][0], $aProcessList[$i][1])
;~ Next
MsgBox(4096, 'Процесс', $aProcessList[2][1])
MsgBox(4096, 'Процесс', $aProcessList[1][1])