class_name _LauncherProcess
extends Node


var generation_id_launcher = _GenerationIDLauncher.new()
var json_file = Json_file.new()


'''
SIGNAL

player_connected - подключения игрока
player_disconnected - отключение игрока
server_disconnected - отключения сервера
'''
signal player_disconnected(peer_id)
signal player_connected(peer_id, id_launcher)
signal server_disconnected



'''
VARIBLE

_id_launcher - ID лаунчера

_type_server - тип сервера
_max_connected - max значение одновременных подключений

_ip - ip сервера для подключения к нему (только для клиентов и серверов для технических входов)
_port - порт для подключения и создания сервера

_multiplayer - техническая часть MultiplayerAPI
_peer - техническая информация о подключателе или сервере
'''
var _id_launcher : String
var _data_form_join_in_account : Dictionary

var _type_server : String
var _max_connected : int

var _ip : String
var _port : int

var _multiplayer : MultiplayerAPI
var _peer : ENetMultiplayerPeer = ENetMultiplayerPeer.new()

var _id_session : int




'''
set_id_launcher - установить id launcher
get_id_launcher - возвращает id launcher
'''
func set_id_launcher():
	
	var path_data_launcher = 'user://Launcher.save'
	
	var launcher = json_file.write_and_return_read( path_data_launcher , { 'ID_Launcher' : generation_id_launcher.generation_id() } )
	
	self._id_launcher = launcher['ID_Launcher']

func get_id_launcher():
	return self._id_launcher


'''
get_launcher_type - возвращает тип launcher
'''
func get_launcher_type():
	if self.get__multiplayer().is_server() == false:
		
		return 'Клиент'
		
	else:
		
		return 'Сервер'


'''
set_data_form_join_in_account - установить данные из формы "входа в аккаунт"
get_data_form_join_in_account - возвращать данные из формы "входа в аккаунт"
'''
func set_data_form_join_in_account(append_data_form_join_in_account : Dictionary):
	self._data_form_join_in_account = append_data_form_join_in_account

func get_data_form_join_in_account():
	return self._data_form_join_in_account



'''
set_type_server - установить тип сервера
get_type_server - возвращает тип сервера
'''
func set_type_server(type_server : String):
	self._type_server = type_server

func get_type_server():
	return self._type_server


'''
set_max_connected - установить максимальное значение одновременных подключений
get_max_connected - возвращает максимальное значение одновременных подключений
'''
func set_max_connected(max_connected  : int):
	self._max_connected = max_connected 

func get_max_connected():
	return self._max_connected 


'''
set_port - установить порт
get_port - возвращает порт
'''
func set_port(port  : int):
	self._port = port 

func get_port():
	return self._port 


'''
set_ip - установить ip server
get_ip - возвращает ip server
'''
func set_ip(ip : String):
	self._ip = ip 

func get_ip():
	return self._ip


'''
set__multiplayer - установить тип launcher
get__multiplayer - возвращает тип launcher
'''
func set__multiplayer(append_multiplayer : MultiplayerAPI):
	self._multiplayer = append_multiplayer

func get__multiplayer():
	return self._multiplayer


'''
get_peer - возвращает peer
'''
func get_peer():
	return self._peer


'''
set_id_session
get_id_session
'''
func set_id_session():
	self._id_session = self.get__multiplayer().get_unique_id()

func get_id_session():
	return self._id_session




func _init(append_multiplayer : MultiplayerAPI , port : int , ip : String = '' , data_form_join_in_account : Dictionary = {}, type_of_server_to_create : String = '', max_connected : int = 1000):
	self.set_id_launcher()
	self.set_data_form_join_in_account(data_form_join_in_account)
	
	self.set__multiplayer(append_multiplayer)
	
	self.set_type_server(type_of_server_to_create)
	
	self.set_port(port)
	self.set_ip(ip)
	self.set_max_connected(max_connected)




'''
FOR SERVER

create_server - запрос сборки на создание сервера


_on_server_connected_client - оповещение, что клиент подключился к серверу
_on_server_disconnected_client - оповещение, что клиент вышел из сервера
'''
func create_server():
	
	var error = self.get_peer().create_server(self.get_port(), self.get_max_connected())
	
	if error:
		
		print('Ошибка запуска сервера')
		return error
		
	self.get__multiplayer().multiplayer_peer = self.get_peer()
		
	self.get__multiplayer().peer_connected.connect(self._on_server_connected_client)
	self.get__multiplayer().peer_disconnected.connect(self._on_server_disconnected_client)
	
	Launcher.print_notification_content( 'Статус сервера: Запущен' )


func _on_server_connected_client(id_session):
	
	Launcher.print_notification_content( 'Session ID: {id_session}\nStatus: Connected'.format({ id_session = id_session }) )

func _on_server_disconnected_client(id_session):
	
	self.player_disconnected.emit(id_session)
	
	Launcher.print_notification_content( 'Session ID: {id_session}\nStatus: Disconnected'.format({ id_session = id_session }) )




'''
FOR CLIENT

create_client - запрос launcher на создание килента

!!! close_client - закрыть клиент #TODO Не известно как отключиться игроку от сервера

_on_connected_ok - оповещение пользователю что подключение к серверу удалось успешно
_on_connected_fail - оповещение пользователю что подключение к серверу не удалось
_on_server_disconnected - оповещение пользователю что сервер был отключен
'''
func create_client():
	
	var error = self.get_peer().create_client(self.get_ip(), self.get_port())
		
	if error:
		
		print('Ошибка соединения')
		print('Сервер на тех. обслуживании. Попробуйте войти чуть позже')
		
		self.get__multiplayer().multiplayer_peer = null
		
		#_PowerOverPages.close_open('Windows' , 'Loading' , 'Server_under_maintenance')
	
	self.get__multiplayer().multiplayer_peer = self.get_peer()
	
	self.get__multiplayer().connected_to_server.connect(self._on_connected_ok)
	self.get__multiplayer().connection_failed.connect(self._on_connected_fail)
	self.get__multiplayer().server_disconnected.connect(self._on_server_disconnected)


#TODO Не известно как отключиться игроку от сервера
#func close_client():
	#print('Запрос на отключение клиента от сервера')


func _on_connected_ok():
	
	self.set_id_session()
	
	Launcher.print_notification_content( 'Session ID: {id_session}\nStatus: Connected OK'.format({ id_session = self.get_id_session() }) )
	
	player_connected.emit(self.get__multiplayer().get_unique_id(), self.get_id_launcher())
	
	#_PowerOverPages.open_close_for_windows('PersonalAccount', 'Loading')

	_HandlerServerProcess.request_to_join_personal_account.rpc( self.get_id_launcher() , self.get_id_session() , self.get_type_server() , self.get_data_form_join_in_account() )

func _on_connected_fail():
	
	print('Тип launcher: Клиент. Подключение не удалось. Причина неизвестная.')
	
	self.set__multiplayer(null)
	self.set_type_server('')
	self.set_ip('')
	
	_PowerOverPages.open_close_for_windows('Server_connection_failed', 'Loading')

func _on_server_disconnected():

	print('Тип launcher: Клиент. Выход из сервера. Сервер ушел на тех. обслуживание.')
	
	self.set__multiplayer(null)
	self.set_type_server('')
	self.set_ip('')
	
	server_disconnected.emit()
	
	_PowerOverPages.open_close_for_windows('Server_under_maintenance', 'Loading')

