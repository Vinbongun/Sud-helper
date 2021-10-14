#include <Date.au3>
$sPathToIni = 'C:\СПО\sud-helper\config.ini'

;~ ------------------ Модуль обновления ----------------
If IniRead($sPathToIni, 'Settings', 'lastCheckUpdate', -1) = 0 Then
	IniWrite($sPathToIni, 'Settings', 'lastCheckUpdate', _NowCalc());добавляет дату последней проверки обновления
EndIf

$lastCheckUpdate = IniRead($sPathToIni, 'Settings', 'lastCheckUpdate', -1);последняя дата проверки новой версии приложения
ConsoleWrite('Дата последней проверки: ' & $lastCheckUpdate & @CRLF)
$iDateCalc = _DateDiff( 'n',$lastCheckUpdate,_NowCalc());считает разницу между времени между последней датой проверки и текущей



If $iDateCalc > 60 or $lastCheckUpdate = '-1' Then ;если файл создан больше 60 минут или в настройках не создана строка последнего обновления
	ConsoleWrite('Поиск нового обновления'& @CRLF)
	DirCreate('C:\СПО\sud-helper\update')

	InetGet("http://vinbongun.com/sud-helper/version.ini", "C:\СПО\sud-helper\update\version.ini", 1) ;скачивает версионный файл с сервера

	$oldAppVersion = IniRead('C:\СПО\sud-helper\version.ini', 'Version', 'ver', -1)
	$newAppVersion = IniRead('C:\СПО\sud-helper\update\version.ini', 'Version', 'ver', -1)

	If $oldAppVersion < $newAppVersion Then ;если на сервере новая версия приложения
		FileMove ("C:\СПО\sud-helper\update\version.ini", "C:\СПО\sud-helper\version.ini", 1) ;заменяет версионный файл новым
		;скачиваем новые файлы обновляемого ПО, при необходимости разархивируем и пр.
		InetGet("http://vinbongun.com/sud-helper/%D0%9F%D0%BE%D0%BC%D0%BE%D1%89%D0%BD%D0%B8%D0%BA%20%D1%81%D1%83%D0%B4%D1%8B.exe", "C:\СПО\sud-helper\update\Помощник суды.exe", 1) ;скачивает новую версию приложения
		While ProcessExists("Помощник суды.exe") ;пока процесс существует
			ProcessClose("Помощник суды.exe") ;пытается его закрыть
			Sleep(10000)
		WEnd
		FileMove ("C:\СПО\sud-helper\update\Помощник суды.exe", "C:\СПО\sud-helper\Помощник суды.exe", 1) ;заменяет старый контрольный файл новым
		Run("C:\СПО\sud-helper\Помощник суды.exe") ;запускаем ПО
		FileCreateShortcut("C:\СПО\sud-helper\Помощник суды.exe", @DesktopDir & "\Помощник суды.lnk"); Создаёт ярлык
	Else
		ConsoleWrite('Приложение обновленно до последней версии'& @CRLF)
	EndIf
	DirRemove('C:\СПО\sud-helper\update', 1);удаляет папку с обновлением
	ConsoleWrite('Нет новой версии'& @CRLF)
	IniWrite($sPathToIni, 'Settings', 'lastCheckUpdate', _NowCalc());добавляет дату последней проверки обновления
Else
	ConsoleWrite("Меньше 60 минут. Всего прошло: " & $iDateCalc & @CRLF )
EndIf


;~ ------------- ////////// Модуль обновления ----------------
