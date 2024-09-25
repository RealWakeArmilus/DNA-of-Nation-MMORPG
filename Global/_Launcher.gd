extends Node

'''
launcher - содержит в себе данные launcher
'''
var launcher : _LauncherProcess


'''
set_Launcher - устанавливает данные launcher
get_Launcher - возвращает данные launcher
'''
func set_Launcher(append_Launcher: _LauncherProcess):
	launcher = append_Launcher

func get_Launcher():
	return launcher



'''
print_notification_content - 
'''
func print_notification_content(append_content : String):
	
	if get_Launcher().get_launcher_type() == 'Сервер':
		
		print('\n--- Уведомляющий ---\n1. Launcher Type: {Launcher_type}\n2. Launcher ID: {id_Launcher}\n3. Server type: {server_type}\n4. Server Port: {server_port}\n5. Подключений: {current_connected}/{max_connected}\n---- Содержание -----\n{content}\n---------------------------\n'.format({id_Launcher = get_Launcher().get_id_launcher(), Launcher_type = get_Launcher().get_launcher_type() , server_type = get_Launcher().get_type_server() , server_port = get_Launcher().get_port() , current_connected = len(get_Launcher().get__multiplayer().get_peers()), max_connected = get_Launcher().get_max_connected() , content = append_content}))
		
	elif get_Launcher().get_launcher_type() == 'Клиент':
		
		print('\n--- Уведомляющий ---\n1. Launcher Type: {Launcher_type}\n2. Launcher ID: {id_Launcher}\n---- Содержание -----\n{content}\n---------------------------\n'.format({id_Launcher = get_Launcher().get_id_launcher(), Launcher_type = get_Launcher().get_launcher_type() , content = append_content }))
