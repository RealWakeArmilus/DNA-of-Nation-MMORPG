extends TextureRect





func _ready():
	open_app_for_OS()


'''
open_app_for_OS - открывает приложение для конкретного ОС
'''
func open_app_for_OS():
	
	if OS.has_feature("windows"):
		
		_PowerOverPages.open_for_windows('JoinInAccount')
		
	elif OS.has_feature("android"):
		
		print('Открыть для Android - нет доступа')
		
		#_PowerOverPages.open('Android' , 'Menu')
