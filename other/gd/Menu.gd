extends Control



@onready var menu = $"../Menu"




'''
_open_setting_server - открыть настройки сервера
_open_personal_account - подключиться к личному кабинету
'''
func _open_setting_server():
	
	print('Открыть страницу Настройка сервера')
	
	_PowerOverPages.close_open('Windows' , 'Menu' , 'Setting_server')


func _open_personal_account():
	
	print('Открыть страницу Личный аккаунт')
	
	client_connected_in_personal_account()




'''
client_connected_in_personal_account - подключение клиента пользователя к серверу "Личный кабинет"
'''
func client_connected_in_personal_account():
	
	#_PowerOverPages.open('Windows' , 'Loading')
	#menu.visible = false
	
	Assembly.set_assembly(_AssemblyProcess.new( multiplayer , 'Personal_account' , 8080 , '192.168.0.105' ))
	Assembly.get_assembly().create_client()


func client_disconnect_in_server_system():
	Assembly.get_assembly().close_client()

#'''
#PAGE
#
#page_loading - загрузки
#page_menu - главного меню
#page_setting_server - настроек сервера
#
#page_sing_in_personal_account - регистрация в личный аккаунт пользователя
#page_sign_in_personal_account - авторизация в личный аккаунт пользователя
#page_personal_account - персонального аккаунта пользователя
#
#page_server_under_maintenance - говорящая, что сервер на техническом обслуживании
#page_server_connection_failed - говорящая, что подключение к серверу не удалось
#
#'''
#@onready var page_loading = $"../Loading"
#@onready var page_menu = $"."
#@onready var page_setting_server = $"../Setting_server"
#
#@onready var page_sing_up_personal_account = $"../Sign_up_personal_account"
#@onready var page_sign_in_personal_account = $"../Sign_in_personal_account"
#@onready var page_personal_account = $"../Personal_account"
#
#@onready var page_server_under_maintenance = $"../Server_under_maintenance"
#@onready var page_server_connection_failed = $"../Server_connection_failed"






#'''
#PAGE PERSONAL ACCOUNT
#'''
#@onready var nick = $"../Personal_account/VBoxContainer/Nick"
#@onready var balance = $"../Personal_account/VBoxContainer/VBoxContainer/Balance"
#@onready var chart = $"../Personal_account/VBoxContainer/VBoxContainer/chart"




#'''
#_reconnect_in_personal_account_from_error_server_under_maintenance - переподключиться в "личный кабинет" из страницы "ошибка - тех. обслуживание"
#_reconnect_in_personal_account_from_error_server_connection_failed - переподключиться в "личный кабинет" из страницы "ошибка - подключение не удалось"
#'''
#func _reconnect_in_personal_account_from_error_server_under_maintenance():
	#page_server_under_maintenance.visible = false
	#page_menu.visible = true
	#_open_personal_account()
#
#func _reconnect_in_personal_account_from_error_server_connection_failed():
	#page_server_connection_failed.visible = false
	#page_menu.visible = true
	#_open_personal_account()
#
#
#
##
##'''
##close_loading_open_sing_up_personal_account - перейти из "загрузки" в "регистрация личного аккаунта"
##close_loading_open_sing_in_personal_account - перейти из "загрузки" в "авторизацию личного аккаунта"
##close_loading_open_personal_account - перейти из "загрузки" в "личный аккаунт"
##close_loading_open_error_page_server_under_maintenance - перейти из "загрузки" в "ошибка - тех. обслуживание"
##close_loading_open_error_server_connection_failed - перейти из "загрузки" в "ошибка - подключение не удалось"
##close_personal_account_open_error_server_under_maintenance - перейти из "личного кабинета" в "ошибка - тех. обслуживание"
##'''
##func close_loading_open_sing_up_personal_account():
	##timer_loading.stop()
	##page_loading.visible = false
	##page_sing_up_personal_account.visible = true
##
##func close_loading_open_sing_in_personal_account():
	##timer_loading.stop()
	##page_loading.visible = false
	##page_sign_in_personal_account.visible = true
##
##func close_loading_open_personal_account():
	##timer_loading.stop()
	##page_loading.visible = false
	##page_personal_account.visible = true
##
##func close_loading_open_error_server_under_maintenance():
	##timer_loading.stop()
	##page_loading.visible = false
	##page_server_under_maintenance.visible = true
##
##func close_loading_open_error_server_connection_failed():
	##timer_loading.stop()
	##page_loading.visible = false
	##page_server_connection_failed.visible = true
##
##func close_personal_account_open_error_server_under_maintenance():
	##page_personal_account.visible = false
	##page_server_under_maintenance.visible = true
##




#
#
#'''
#check_id_client_create_personal_account - сервер "personal account" проверяет привязан ли полученный ID сборки к какому либо аккаунту
#'''
#func check_id_client_create_personal_account(append_id_client : int , append_id_unique_session : int):
	#
	#print('Тип сборки: {assembly_type}. 2 ЭТАП (ВОПРОС): Имеет ли ID Client: {id_client}. свой аккаунт в базе "личных аккаунтов" сервера?'.format({assembly_type = assembly_type(), id_client = append_id_client}))
	#
	#
	#var path_data_personal_accounts = 'user://Personal_accounts.save'
	#
	#var personal_accounts = json_file.write_and_return_read( path_data_personal_accounts , [{ 'ID' : 1 , 'ID_Client' : append_id_client,  'Nick' : 'Armilus', 'Password' : 'fy5urxu6u', 'ID Telegram chat' : '', 'Status admin' : true , 'Status log in' : false , 'Status Main' : true , 'Status Pioneer' : false , 'Status Investor' : false}] )
	#
	#var index_personal_account = json_file.check_argument_in_data_server(personal_accounts , 'ID_Client' , append_id_client , 1)
	#
	#
	#if json_file.check_argument_in_data_server(personal_accounts , 'ID_Client' , append_id_client ):
		#
		#print('Тип сборки: {assembly_type}. 2 ЭТАП (ОТВЕТ): Да, имеет. Мы нашли ID Account: {id_account}, для ID Client: {id_client}'.format( { assembly_type = assembly_type(),  id_account = index_personal_account , id_client = append_id_client} ) )
		#
		#print('Тип сборки: {assembly_type}. 2 ЭТАП (Решение): Сервер / Проверяем на вход в аккаунт, для ID Client: {id_assembly}. ID сеансса: {id_unique_session}'.format( { assembly_type = assembly_type(), id_assembly = append_id_client , id_unique_session = append_id_unique_session} ) )
		#
		#check_id_client_log_in_personal_account(append_id_client , append_id_unique_session, personal_accounts[index_personal_account - 1])
		#
	#else:
		#
		#print('Тип сборки: {assembly_type}. 2 ЭТАП (ОТВЕТ): Нет, не имеет. Мы не нашли ID Account, для ID Client: {id_client}'.format( { assembly_type = assembly_type(), id_client = append_id_client } ) )
		#
		#print('Тип сборки: {assembly_type}. 2 ЭТАП (Решение): Сервер -> Клиенту / Переход в панель регистрации, для ID Client: {id_assembly}. ID сеансса: {id_unique_session}'.format( { assembly_type = assembly_type(), id_assembly = append_id_client , id_unique_session = append_id_unique_session} ) )
		#
		#open_sign_up.rpc(append_id_unique_session)
#
#
#'''
#check_id_client_log_in_personal_account -  сервер "personal account" / проверяет осуществлен ли вход в найденный аккаунт данной сборкой клиента
#'''
#func check_id_client_log_in_personal_account(append_id_client : int , append_id_unique_session : int, append_personal_account : Dictionary):
	#
	#if append_id_client == append_personal_account['ID_Client']:
		#
		#print('Тип сборки: {assembly_type}. 3 ЭТАП (ВОПРОС): Данный ID Client: {id_client}. осуществлял вход в личный кабинет {id_account}, ранее?'.format( { assembly_type = assembly_type(), id_client = append_id_client , id_account = append_personal_account['ID'] } ) ) 
		#
		#
		#var path_data_session = 'user://Session.save'
		#
		#var sessions = json_file.write_and_return_read( path_data_session , [{ 'ID' : 1 , 'ID_Client' : append_personal_account['ID_Client'] , 'ID_Session' : append_id_unique_session }] )
		#
		#var index_session = json_file.check_argument_in_data_server(sessions , 'ID_Session' , append_id_unique_session , 1)
		#
		#
		#if json_file.check_argument_in_data_server(sessions , 'ID_Session' , append_id_unique_session ) == false:
			#
			#sessions.append( { 'ID' : index_session + 1 , 'ID_Client' : append_personal_account['ID_Client'] , 'ID_Session' : append_id_unique_session } )
			#
			#json_file.write( path_data_session , sessions )
		#
		#
		#if append_personal_account['Status log in'] == true:
			#
			#print('Тип сборки: {assembly_type}. 3 ЭТАП (ОТВЕТ): Да. Считается, что данный ID Client: {id_client}, осуществил ранее вход в ID Account: {id_account}'.format( { assembly_type = assembly_type() , id_client = append_id_client , id_account = append_personal_account['ID'] } ) )
			#
			#print('Тип сборки: {assembly_type}. 3 ЭТАП (РЕШЕНИЕ): Сервер -> Клиенту / Открыть страницу "личный кабинет" для ID Client: {id_client}'.format( { assembly_type = assembly_type() , id_client = append_id_client } ) )
			#
			#open_personal_account.rpc(append_id_unique_session)
			#
		#elif append_personal_account['Status log in'] == false:
			#
			#print('Тип сборки: {assembly_type}. 3 ЭТАП (ОТВЕТ): Нет. ID Client: {id_client}, не осуществлял ранее вход в ID Account: {id_account}'.format( { assembly_type = assembly_type() , id_client = append_id_client , id_account = append_personal_account['ID'] } ) )
			#
			#print('Тип сборки: {assembly_type}. 3 ЭТАП (РЕШЕНИЕ): Сервер -> Клиенту / Открыть страницу "авторизация" для ID Client: {id_client}'.format( { assembly_type = assembly_type() , id_client = append_id_client } ) )
			#
			#open_sign_in.rpc(append_id_unique_session)
#
#
#
#
#'''
#open_sign_up - Сервер -> Клиенту / разрешает пройти регистрацию (сервер отправляет конкретной сборке клиента)
#'''
#@rpc("authority")
#func open_sign_up(append_id_unique_session : int):
	#
	#if append_id_unique_session == multiplayer.get_unique_id():
		#
		#print('Тип сборки: {assembly_type}. Открыть окно регистрации личного аккаунта'.format( { assembly_type = assembly_type() } ) )
		#
		#close_loading_open_sing_up_personal_account()
#
#
#'''
#open_sign_in - Сервер -> Клиенту / разрешает пройти авторизацию (сервер отправляет конкретной сборке клиента)
#'''
#@rpc("authority")
#func open_sign_in(append_id_unique_session : int):
	#
	#if append_id_unique_session == multiplayer.get_unique_id():
		#
		#print('Тип сборки: {assembly_type}. Открыть окно авторизации личного аккаунта'.format( { assembly_type = assembly_type() } ) )
		#
		#close_loading_open_sing_in_personal_account()
#
#
#'''
#open_personal_account - Сервер -> Клиенту / разрешает открыть страницу "личного кабинета"
#'''
#@rpc("authority")
#func open_personal_account(append_id_unique_session : int):
	#
	#if append_id_unique_session == multiplayer.get_unique_id():
		#
		#print('Тип сборки: {assembly_type}. Открыть личный аккаунт'.format( { assembly_type = assembly_type() } ) )
		#
		#close_loading_open_personal_account()
		#
		#if page_personal_account.visible == true:
			#
			#print('Тип сборки: {assembly_type}. Отправляю серверу "personal account" - запрос / Получение данных своего - "личного аккаунта" и "основного м счета"'.format( { assembly_type = assembly_type() } ) )
			#
			#request_for_information_about_personal_account.rpc( multiplayer.get_unique_id() )
#
#
#
#
#'''
#request_for_information_about_personal_account - Клиент -> Серверу / запрос информации о "личном кабинете" и "основном м счете", для просмотра информации в своем личном кабинете.
#'''
#@rpc("any_peer")
#func request_for_information_about_personal_account( append_id_unique_session : int):
	#
	#print('Тип сборки: {assembly_type}. 4.3.1 Этап(Запрос): Получил от: ID Session: {id_session}. Запросил получение данных своего - "личного аккаунта" и "основного м счета".'.format( { assembly_type = assembly_type() , id_session = append_id_unique_session } ) )
	#print('Тип сборки: {assembly_type}. 4.3.1 Этап(Вопрос): Данный ID Session: {id_session}. Сейчас находится в своем личный кабинет?'.format( { assembly_type = assembly_type() , id_session = append_id_unique_session } ) )
	#
	#var path_data_session = 'user://Session.save'
	#
	#var sessions = json_file.read( path_data_session )
	#
	#var index_session = json_file.check_argument_in_data_server(sessions , 'ID_Session' , append_id_unique_session , 1)
	#
	#var id_client = sessions[index_session - 1]['ID_Client']
	#
	#
	#if json_file.check_argument_in_data_server(sessions , 'ID_Session' , append_id_unique_session ) == false:
		#
		#print('Тип сборки: {assembly_type}. 4.3.1 Этап(Ответ): Нет. ID Session: {id_session}. ПОДОЗРИТЕЛЬНЫЙ СЕАНСС. Не найден ID Session: {check_id_session} - уже будучи в личном кабинете. Снять данную сборку с подключения! '.format( { assembly_type = assembly_type() , id_session = append_id_unique_session , check_id_session = append_id_unique_session } ) )
	#
	#else:
		#
		#print('Тип сборки: {assembly_type}. 4.3.1 Этап(Ответ): Да. ID Session: {id_session}. Сейчас находится в своем личном кабинете.'.format( { assembly_type = assembly_type() , id_session = append_id_unique_session } ) )
	#
	#
	#
	#
	#print('Тип сборки: {assembly_type}. 4.3.2 Этап(Вопрос): Какой ID Client принадлежит данному ID Session: {id_session}?'.format( { assembly_type = assembly_type() , id_session = append_id_unique_session } ) )
	#
	#var path_data_personal_account = 'user://Personal_accounts.save'
	#
	#var personal_acccounts = json_file.read( path_data_personal_account )
	#
	#var index_personal_acccount = json_file.check_argument_in_data_server(sessions , 'ID_Client' , id_client , 1)
	#
	#
	#if json_file.check_argument_in_data_server(sessions , 'ID_Client' , id_client ):
		#
		#print('Тип сборки: {assembly_type}. 4.3.2 Этап(Ответ): ID Session: {id_session} привязан к ID_Client: {id_client}'.format( { assembly_type = assembly_type() , id_session = append_id_unique_session , id_client = id_client } ) )
		#
		#var data_personal_account = { 'Nick' : personal_acccounts[index_personal_acccount - 1]['Nick'] , 'Password' : personal_acccounts[index_personal_acccount - 1]['Password'] ,  }
		#
		#var data_main_account = check_main_account(id_client)
		#
		#print('Тип сборки: {assembly_type}. 4.3.2 Этап(Решение): Сервер -> Клиент / Передаю ID Session: {id_session}. Информацию о личном кабинете: {personal_account}. Информацию о основном счете: {main_account}'.format( { assembly_type = assembly_type(), id_session = append_id_unique_session , personal_account = data_personal_account , main_account = data_main_account } ) )
		#
		#transfer_data_personal_account_and_data_main_account.rpc(data_personal_account, data_main_account)
		#
	#else:
		#
		#print('Тип сборки: {assembly_type}. 4.3.2 Этап(Ответ): Ошибка. ID Session: {id_session}. ПОДОЗРИТЕЛЬНЫЙ СЕАНСС. Не найден ID Client: {id_client} - уже будучи в личном кабинете. Снять данную сборку с подключения! '.format( { assembly_type = assembly_type() , id_session = append_id_unique_session , id_client = id_client } ) )
#
#
#
#
#'''
#check_main_account - возвращает информацию об "основном счете" из базы сервера "personal account"
#'''
#func check_main_account(id_client : int):
	#
	#var path_data_main_account = 'user://Main_account_{id_client}.save'.format({ id_client = id_client })
	#
	#var time = Time.get_datetime_dict_from_system()
	#
	#return json_file.write_and_return_read( path_data_main_account , [{ 'ID' : 1 , 'Date' : { 'Day' : time['day'], 'Month' : time['month'], 'Year' : time['year'] } , 'Time' : { 'Hour' : time['hour'], 'Minute' : time['minute'], 'Second' : time['second'] } , 'Balance' : { 'Total UDNA' : 0 , 'Entered UDNA' : 0 , 'Withdrawn UDNA' : 0 } , 'Tourney' : { 'Wins' : 0 , 'Defeats' : 0 , 'Wins UDNA' : 0 , 'lost UDNA' : 0 } }] )
#
#
#
#
#'''
#transfer_data_personal_account - Клиент / Получаю информацию о своем "личном кабинете" и "основном м счете"
#'''
#@rpc("authority")
#func transfer_data_personal_account_and_data_main_account(data_personal_account : Dictionary , data_main_account : Array):
	#
	#print('Тип сборки: {assembly_type}. Получаю от сервера "Personal account" / Данные своего личного кабинета. Данные личного кабинета: {personal_account}. Данные основного счета: {main_account}'.format( { assembly_type = assembly_type(), personal_account = data_personal_account, main_account = data_main_account } ) )
	#
	#nick.text = '@' + data_personal_account['Nick']
	#balance.text = 'Balance: {total} UDNA'.format({ total = str(data_main_account[-1]['Balance']['Total UDNA']) })
	#
	#var records = []
	#
	#for record in data_main_account:
		#
		#chart.add_child(load("res://Chart/line_chart.tscn").instantiate())
		#
		#records.append(record['Tourney']['Wins'])
	#
	#var index_child = 0
	#
	#for child in chart.get_children():
		#
		#index_child += 1
		#
		#get_node(child.get_path()).value = records[index_child - 1]
	#pass
