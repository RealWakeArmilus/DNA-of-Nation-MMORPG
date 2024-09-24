extends Control


var json_file = Json_file.new()


'''
PAGE

page_loading - загрузки
page_menu - главного меню
page_setting_server - настроек сервера

page_sing_in_personal_account - регистрация в личный аккаунт пользователя
page_sign_in_personal_account - авторизация в личный аккаунт пользователя
page_personal_account - персонального аккаунта пользователя

page_server_under_maintenance - говорящая, что сервер на техническом обслуживании
page_server_connection_failed - говорящая, что подключение к серверу не удалось

'''
@onready var page_loading = $"../Loading"
@onready var page_menu = $"."

@onready var page_sing_up_personal_account = $"../Sign_up_personal_account"
@onready var page_sign_in_personal_account = $"../Sign_in_personal_account"
@onready var page_personal_account = $"../Personal_account"




'''
progress_loading
timer_loading
'''
@onready var progress_loading = $"../Loading/ProgressBar"
@onready var timer_loading = $"../Loading/Loading"




@onready var input_nick_sing_in = get_node("BoxContainer/Box/Input/Nick")
@onready var input_password_sing_in = get_node("BoxContainer/Box/Input/Password")
@onready var button_sing_in = get_node('BoxContainer/Box/Sing_in')




func _ready():
	button_sing_in.pressed.connect(start_sing_in.bind())



'''
assembly_type - Клиент & Сервер / возвращает тип сборки (сервер/клиент)
'''
func assembly_type():
	if multiplayer.is_server() == false:
		
		return 'Клиент'
		
	else:
		
		return 'Сервер'




'''
start_sing_in - Клиент / запускает авторизацию аккаунта
'''
func start_sing_in():
	
	check_id_session.rpc(multiplayer.get_unique_id(), input_nick_sing_in.text, input_password_sing_in.text)




'''
check_id_session - Клиент -> Серверу / проверка ID сессии на актуальность и связанностью с определенным ID клиентом / 
'''
@rpc("any_peer")
func check_id_session(append_id_session : int , append_nick_sing_in : String , append_password_sing_in : String):
	
	var path_data_sessions = 'user://Session.save'
	
	var sessions = json_file.read( path_data_sessions )
	
	var index_session = json_file.check_argument_in_data_server(sessions, 'ID_Session' , append_id_session , 1)
	
	
	if json_file.check_argument_in_data_server(sessions, 'ID_Session' , append_id_session):
		
		print('Тип сборки: {assembly_type}. ID сессии: {id_session}, связана с ID клиентом: {id_client}.'.format( { assembly_type = assembly_type(), id_session = append_id_session, id_client = sessions[index_session - 1]['ID_Client'] } ) )
		
		check_input_data_client_and_personal_account( append_id_session , sessions[index_session - 1]['ID_Client'] , append_nick_sing_in , append_password_sing_in )
		
	else:
		
		print('Тип сборки: {assembly_type}. ID сессии: {id_session}, не связан ни с одним ID клиентом. Дальше пустоста - "Page Sing in Personal account - 112 line"'.format( { assembly_type = assembly_type(), id_session = append_id_session } ) )


'''
check_input_data_and_personal_account - Сервер "personal account" / Проверяет вводные данные клиента с данными личных аккаунтов на соответсвие
'''
func check_input_data_client_and_personal_account(append_id_session : int , append_id_client : int , append_nick_sing_in : String , append_password_sing_in : String):
	
	print('Тип сборки: {assembly_type}. Проверка вводных данных ID сборки клиента: {id_client}, с данными найденого аккаунта в базе "личных аккаунтов" сервера'.format( { assembly_type = assembly_type(), id_client = append_id_client } ) )
	
	var path_personal_accounts = 'user://Personal_accounts.save'
	
	if not FileAccess.file_exists(path_personal_accounts):
		
		print('Тип сборки: {assembly_type}. По какой-то причине при авторизации клиента у сервера "personal account" не найден файл "user://Personal_accounts.save". Сервер был отключен - "Page Sing in Personal account - 129 line"'.format( { assembly_type = assembly_type() } ) )
		
		get_tree().quit()
	
	var personal_accounts = json_file.read( path_personal_accounts )
	
	var status_check_account : bool
	var last_id_account : int
	
	for personal_account in personal_accounts:
		
		last_id_account = personal_account['ID']
		
		if (personal_account['ID_Client'] == append_id_client) and (personal_account['Nick'] == append_nick_sing_in) and (personal_account['Password'] == append_password_sing_in):
			
			print('Тип сборки: {assembly_type}. Account: {id_client} - данный аккаунт привязан к ID сборке клиента: {id_assembly}'.format( { assembly_type = assembly_type(),  id_client = personal_account['ID'] , id_assembly = append_id_client} ) )
			
			status_check_account = true
			
			break
			
		else:
			
			print('Тип сборки: {assembly_type}. Account: {id_client} - не найден в базе аккаунтов'.format( { assembly_type = assembly_type(), id_client = personal_account['ID'] } ) )
			
			status_check_account = false
	
	
	if status_check_account == false:
		
		print('Тип сборки: {assembly_type}. Данные не совпали, для ID сборки клиента: {id_assembly}.'.format( { assembly_type = assembly_type() , id_assembly = append_id_client} ) )
		
		
	elif status_check_account == true:
		
		print('Тип сборки: {assembly_type}. Переход в личный аккаунт, для ID сборки клиента: {id_assembly}.'.format( { assembly_type = assembly_type() , id_assembly = append_id_client} ) )
		
		personal_accounts[last_id_account - 1]['Status log in'] = true
		
		json_file.write( path_personal_accounts , personal_accounts )
		
		open_personal_account.rpc(append_id_session)




'''
open_personal_account - Сервер -> Клиенту / Личный кабинет открыт (сервер отправляет конкретной сборке клиента)
'''
@rpc("authority")
func open_personal_account(append_id_unique_session : int):
	
	if append_id_unique_session == multiplayer.get_unique_id():
		
		print('Тип сборки: {assembly_type}. Открыть личный аккаунт'.format( { assembly_type = assembly_type() } ) )
		
		close_sing_in_open_personal_account()




'''
close_sing_in_open_personal_account - Клиент / перейти из "авторизации" в "личный аккаунт"
'''
func close_sing_in_open_personal_account():
	page_sign_in_personal_account.visible = false
	page_personal_account.visible = true

