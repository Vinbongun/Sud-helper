ControlClick('Редактирование', '', '[CLASS:WindowsForms10.Window.8.app.0.378734a; INSTANCE:15]', "main")
WinWaitActive('Организация')
ControlClick('Организация', '', '[CLASS:WindowsForms10.Window.8.app.0.378734a; INSTANCE:6]', "main")
ControlSetText("Организация", "", "[CLASS:WindowsForms10.EDIT.app.0.378734a; INSTANCE:1]", 'ООО АйБи-Консалт') 
WinActivate("Организация")
ControlClick("Организация", '', "[CLASS:WindowsForms10.EDIT.app.0.378734a; INSTANCE:1]", "main") 
Send("{ENTER}")
