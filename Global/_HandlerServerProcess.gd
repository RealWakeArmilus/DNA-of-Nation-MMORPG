extends Node


var json_file : Json_file = Json_file.new()




'''
request_to_join_personal_account - запрос пользователя на вход в "Личный кабинет" на сервере @{Server_type_connected}
	append_Launcher_id : Для индификации через какой Launcher идет запрос серверу
	append_unique_session_id : Уникальный ID сессии лаунчера
	append_server_type_connected : К какому серверу нужно подключить лаунчер
	append_data_form_join_in_account : Данные из формы входа в "Аккаунт"
'''
@rpc("any_peer")
func request_to_join_personal_account(append_Launcher_id : String, append_unique_session_id : int, append_server_type_connected : String, append_data_form_join_in_account : Dictionary ):
	
	if (Launcher.get_Launcher().get_launcher_type() == 'Сервер') and (Launcher.get_Launcher().get_type_server() == 'Handler'):
		
		Launcher.print_notification_content( 
		'Launcher ID: {Launcher_id}
		\nSession ID: {unique_session_id}
		\nТема: Запрос пользователя
		\nЗапрос: Открыть "личный кабинет", через сервер @{server_type_connected}'.format({ Launcher_id = append_Launcher_id, unique_session_id = append_unique_session_id , server_type_connected = append_server_type_connected })  )
		
		if append_data_form_join_in_account['Status Join'] == 'SingUp':
			
			Launcher.print_notification_content( 
				'1 ЭТАП: Требуется регистрация "Launcher ID" пользователя в базе #Personal_accounts, на сервере @Handler
				\n(Решение): Сервер / Переходим к этапу регистрации, Launcher ID: "{Launcher_id}"'.format({ Launcher_id = append_Launcher_id }) )
				
			sing_up_personal_account( append_Launcher_id , append_unique_session_id , append_data_form_join_in_account)




'''
sing_up_personal_account - Регистрация "Launcher ID" в базе #Personal_accounts, на сервере @Handler
	Launcher_id : Для индификации какой Launcher отправляет запрос серверу
	unique_session_id : Уникальный ID сессии лаунчера
	data_form_join_in_account : Данные из формы входа в "Аккаунт"
	Result : Получение "Personal_Account_ID"
'''
func sing_up_personal_account(Launcher_id : String , unique_session_id : int , data_form_join_in_account : Dictionary):
	
	var personal_accounts = json_file.write_and_return_read_and_check_argument(
		'user://Personal_accounts.save', 
		[{ 'ID' : 1 , 'Launcher_id' : Launcher_id, 'Login' : data_form_join_in_account['Login'], 'Email' : data_form_join_in_account['Email'], 'Password' : data_form_join_in_account['Password'], 'Status' : {'Found' : true , 'Admin' : false , 'Online' : false} }], 
		'Launcher_id' , Launcher_id , 1)
	
	if json_file.check_argument_in_data_server(personal_accounts['file'] , 'ID_Launcher' , Launcher_id ):
		
		personal_accounts['file'].append( { 'ID' : personal_accounts['index'] + 1 , 'Launcher_id' : Launcher_id, 'Login' : data_form_join_in_account['Login'], 'Email' : data_form_join_in_account['Email'], 'Password' : data_form_join_in_account['Password'], 'Status' : {'Found' : true , 'Admin' : false , 'Online' : false} } )
		
		json_file.write( personal_accounts['path'] , personal_accounts['file'] )











func login_personal_account(Launcher_id : String , unique_session_id : int , data_form_join_in_account : Dictionary):
	
	var personal_accounts = json_file.write_and_return_read_and_check_argument(
		'user://Personal_accounts.save', 
		[{ 'ID' : 1 , 'Launcher_id' : Launcher_id, 'Login' : data_form_join_in_account['Login'], 'Email' : data_form_join_in_account['Email'], 'Password' : data_form_join_in_account['Password'], 'Status' : {'Found' : true , 'Admin' : false , 'Online' : false} }], 
		'Launcher_id' , Launcher_id , 1)
	
	if json_file.check_argument_in_data_server(personal_accounts['file'] , 'ID_Launcher' , Launcher_id ):
		
		Launcher.print_notification_content( 
		'1 ЭТАП: Идентификация "Launcher ID" пользователя в базе #Personal_accounts, на сервере @Handler\n
		(ВОПРОС): Зарегистрирован ли на сервере Launcher ID: "{Launcher_id}" ?\n
		(ОТВЕТ): Да. Мы нашли его Personal Account ID: {Personal_Account_ID}\n
		(Решение): Сервер / Идёт авторизация личного кабинета, Launcher ID: "{Launcher_id}", затем, проверяем статус Online'.format({ Personal_Account_ID = personal_accounts['index'] , Launcher_id = Launcher_id }) )
		
		check_status_online_personal_account(Launcher_id , unique_session_id, personal_accounts['index'] - 1)
		
	else:
		
		Launcher.print_notification_content( 
		'1 ЭТАП: Идентификация "Launcher ID" пользователя в базе #Personal_accounts, на сервере @Handler\n
		(ВОПРОС): Зарегистрирован ли на сервере Launcher ID: "{Launcher_id}" ?\n
		(ОТВЕТ): Нет. Мы не нашли его Personal Account ID\n
		(Решение): Сервер / Регистрируем личный кабинет, Launcher ID: "{Launcher_id}" как новый, затем, осуществляем вход в систему'.format({ Launcher_id = Launcher_id })
		 )
		
		personal_accounts['file'].append( { 'ID' : personal_accounts['index'] + 1 , 'ID_Launcher' : Launcher_id } )
		
		json_file.write( personal_accounts['path'] , personal_accounts['file'] )
		


'''
check_status_online_personal_account - Проверка Status Online для "Personal_Account_ID"
	Launcher_id : 
	unique_session_id : 
	personal_account_file : 
'''
func check_status_online_personal_account(Launcher_id : String , unique_session_id : int, personal_account_file : Dictionary):
	
	if personal_account_file['Status']['Online']:
		
		Launcher.print_notification_content( 
		'2 ЭТАП: Проверка Status Online для "Personal_Account_ID"\n
		(ВОПРОС): Сейчас, Personal Account ID:" {Personal_Account_ID}", Онлайн ?\n
		(ОТВЕТ): Да, Онлайн.\n
		(Решение): Сервер > Клиент / Не предоставляем доступ к личному кабинету.'.format({ Personal_Account_ID = personal_account_file['ID'] })
		 )
		
	elif personal_account_file['Status']['Online'] == false:
		
		Launcher.print_notification_content( 
		'2 ЭТАП: Проверка Status Online для "Personal_Account_ID"\n
		(ВОПРОС): Сейчас, Personal Account ID:" {Personal_Account_ID}", Онлайн ?\n
		(ОТВЕТ): Нет, не онлайн.\n
		(Решение): Сервер > Клиент / Осуществляем вход в личный кабинет'.format({ Launcher_id = Launcher_id })
		 )
		
		#open_personal_account.rpc(append_id_unique_session)

