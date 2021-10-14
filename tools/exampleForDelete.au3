#Include <WinAPIEx.au3>
#Include <Array.au3>
$pid = WinGetProcess("[CLASS:WindowsForms10.Window.8.app.0.378734a]")
Global $Data = _WinAPI_EnumProcessWindows($pid)
If IsArray($Data) Then
	_ArrayDisplay($Data)
EndIf

ConsoleWrite ( 'Номер окна: ' & _WinGetByPID(0x00030488) & @CRLF)


;0 will return 1 base array; leaving it 1 will return the first visible window it finds
Func _WinGetByPID($iPID, $nArray = 1)
    If IsString($iPID) Then $iPID = ProcessExists($iPID)
    Local $aWList = WinList(), $sHold

    For $iCC = 1 To $aWList[0][0]
        If WinGetProcess($aWList[$iCC][1]) = $iPID And _
            BitAND(WinGetState($aWList[$iCC][1]), 2) = 0 Then
            If $nArray Then Return $aWList[$iCC][0]
            $sHold &= $aWList[$iCC][0] & Chr(1)
        EndIf
    Next

    If $sHold Then Return StringSplit(StringTrimRight($sHold, 1), Chr(1))
    Return SetError(1, 0, 0)
EndFunc