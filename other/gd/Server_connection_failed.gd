extends Control

'''
menu - страница главного меню
server_connection_failed - страница говорящая, что подключение к серверу не удалось
'''
@onready var menu = $"../Menu"
@onready var server_connection_failed = $"."


'''
_close_server_connection_failed -  закрыть страницу "подключение к серверу не удалось" и вернуться в меню
'''
func _close_server_connection_failed():
	server_connection_failed.visible = false
	menu.visible = true
