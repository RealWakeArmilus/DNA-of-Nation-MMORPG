extends Control



'''
ELEMENT PAGE SERVER

max_connected_client - устанавливает максимальное одновременное количество подключений
total_connected_client - возвращает max одновременных подключений

type_server - устанавливает тип сервера
input_port_server - устанавливает порт сервера

'''
@onready var input_max_connected_client = $Margin/BoxContainer/Input_max_connected_client
@onready var max_connected_client = $Margin/BoxContainer/Input_max_connected_client/Max_connected_client

@onready var input_type_server = $Margin/BoxContainer/Input_type_server
@onready var input_port_server = $Margin/BoxContainer/Input_port_server


'''
_set_max_conneted_client_in_server - устанавливает максимальное количество подключений
'''
func _set_max_conneted_client_in_server():
	max_connected_client.text = str(input_max_connected_client.value)


'''
flag_create_server - флаг о запуске сервера. запущен (да/нет)
'''
var flag_create_server : bool = false


'''
_create_server - запуск сервера
'''
func _create_server():
	
	if flag_create_server == false:
		
		flag_create_server = true
		
		Assembly.set_assembly(_AssemblyProcess.new( multiplayer, input_type_server.text , int(input_port_server.text) , '' , int(max_connected_client.text) ) )
		Assembly.get_assembly().create_server()
	
	else:
		
		print('Сервер уже запущен')


'''
_close_server - закрыть сервер
'''
func _close_server():
	
	get_tree().quit()

