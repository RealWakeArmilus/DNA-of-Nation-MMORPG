extends Control

'''
menu - страница главного меню
server_under_maintenance - страница говорящая, что сервер на техническом обслуживании
'''
@onready var menu = $"../Menu"
@onready var server_under_maintenance = $"."


'''
_close_server_under_maintenance - закрыть страницу "сервер на техническом обслуживании" и вернуться в меню
'''
func _close_server_under_maintenance():
	server_under_maintenance.visible = false
	menu.visible = true
