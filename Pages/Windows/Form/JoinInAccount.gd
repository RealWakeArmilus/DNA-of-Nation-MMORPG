extends BoxContainer

'''
SignUp - регистрации
'''
@onready var login = $SingUp/Input/Login
@onready var email = $SingUp/Input/Email
@onready var password = $SingUp/Input/Password
@onready var repeat_password = $"SingUp/Input/Repeat password"

@onready var input_login = $SingUp/Input/Login/InputLogin
@onready var input_email = $SingUp/Input/Email/InputEmail
@onready var input_reg_password = $SingUp/Input/Password/InputRegPassword
@onready var input_repeat_password = $"SingUp/Input/Repeat password/InputRepeatPassword"


'''
LogIn - авторизации
'''
@onready var login_or_email = $"LogIn/Input/Login or Email"
@onready var login_password = $LogIn/Input/Password

@onready var input_login_or_email = $"LogIn/Input/Login or Email/InputLoginOrEmail"
@onready var input_password = $LogIn/Input/Password/InputPassword


@onready var error = $Error

@onready var sing_up = $SingUp
@onready var log_in = $LogIn



func _exit_app():
	get_tree().quit()


func _go_to_logIn():
	error.visible = false
	sing_up.visible = false
	log_in.visible = true


func _go_to_singUp():
	error.visible = false
	log_in.visible = false
	sing_up.visible = true


func check_input(append_one, append_input, error_msm):
	
	if (append_one == append_input.text):
		
		error.visible = true
		error.text = error_msm
		
		return false
	
	error.text = error_msm
	
	return true


func _on_confirm_pressed():
	
	login.modulate = "ffffff"
	email.modulate = "ffffff"
	password.modulate = "ffffff"
	repeat_password.modulate = "ffffff"
	
	login_or_email.modulate = "ffffff"
	login_password.modulate = "ffffff"
	
	if (sing_up.visible == true) and (log_in.visible == false):
		
		if ('a' == input_login.text) and ('a' == input_email.text) and ('a' == input_reg_password.text) and (input_reg_password.text == input_repeat_password.text):
			
			create_server()
		
		elif check_input('', input_login, 'Придумайте Логин') == false:
			
			login.modulate = "ff3700"
			
		elif check_input('', input_email, 'Введите Почту') == false:
			
			email.modulate = "ff3700"
			
		elif check_input('', input_reg_password, 'Придумайте Пароль') == false:
			
			password.modulate = "ff3700"
			
		elif check_input(input_reg_password.text, input_repeat_password, 'Повтор пароля не совпадает с Паролем'):
			
			repeat_password.modulate = "ff3700"
		
		else:
			
			error.visible = true
			error.text = 'Идет регистрация аккаунта'
			
			create_client({'Status Join' : 'SingUp', 'Login' : input_login.text, 'Email' : input_email.text, 'Password' : input_reg_password.text})
	
	
	elif (log_in.visible == true) and (sing_up.visible == false):
		
		if check_input('', input_login_or_email, 'Введите Логин или Почту') == false:
			
			login_or_email.modulate = "ff3700"
			
		elif check_input('', input_password, 'Введите Пароль') == false:
			
			login_password.modulate = "ff3700"
			
		else:
			
			error.visible = true
			error.text = 'Идет авторизация аккаунта'
			
			create_client({'Status Join' : 'Login', 'Login or Email' : input_login_or_email.text, 'Password' : input_reg_password.text})


func create_server():
	Launcher.set_Launcher(_LauncherProcess.new( multiplayer , 8080 , '', {}, 'Handler') )
	Launcher.get_Launcher().create_server()
	
	_PowerOverPages.open_close_for_windows('Loading', 'JoinInAccount')

func create_client(data_form_join_in_account : Dictionary):
	Launcher.set_Launcher(_LauncherProcess.new( multiplayer , 8080 , '192.168.0.106', data_form_join_in_account, 'Handler' ))
	Launcher.get_Launcher().create_client()
		
	_PowerOverPages.open_close_for_windows('Loading', 'JoinInAccount')
