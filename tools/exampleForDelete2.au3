Global $PID2 = ""
$Amow = 100
$hWnd2 = ""
$aPID = Run("Notepad.exe")
Sleep($Amow)
$theWinlist = Winlist()
    Do
        For $i = 1 To $theWinlist[0][0]
            If $theWinlist[$i][0] <> "" Then
                $iPID2 = WinGetProcess($theWinlist[$i][1])
                If $iPID2 = $aPID Then
                    $hWnd2 = $theWinlist[$i][1]
                    ExitLoop
                EndIf
            EndIf
        Next
    Until $hWnd2 <> 0
    MsgBox(0, "Handle is", $hWnd2)
WinClose($hWnd2)