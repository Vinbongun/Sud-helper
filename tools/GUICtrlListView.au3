#include <GUIConstantsEx.au3>
#include <MsgBoxConstants.au3>
#include <WindowsConstants.au3>
#include <GuiListView.au3>

Example()

Func Example()
    GUICreate("listview items", 300, 300, -1, -1)

    Local $idListview = GUICtrlCreateListView("col1", 10, 10, 200, 150) ;,$LVS_SORTDESCENDING)
    Local $idButton = GUICtrlCreateButton("ID_of_Xitem?", 75, 170, 70, 20)
    Local $idItem1 = GUICtrlCreateListViewItem("Aitem", $idListview)
    Local $idItem2 = GUICtrlCreateListViewItem("Xitem", $idListview)
    Local $idItem3 = GUICtrlCreateListViewItem("Zitem", $idListview)

    GUISetState(@SW_SHOW)

    ; Loop until the user exits.
    While 1
        Switch GUIGetMsg()
            Case $GUI_EVENT_CLOSE
                ExitLoop

            Case $idButton
                $nID = _GUICtrlListView_FindText($idListview, "Zitem")
                MsgBox(0, "", "ID of Zitem is " & $nID)
                _GUICtrlListView_ClickItem($idListview, $nID)
        EndSwitch
    WEnd
EndFunc   ;==>Example