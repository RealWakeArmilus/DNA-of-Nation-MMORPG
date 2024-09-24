extends Control


@onready var input_nick = $BoxContainer/Box/Input/Nick
@onready var input_password = $BoxContainer/Box/Input/Password
@onready var button_sing_up = 'BoxContainer/Box/Sing_up'


func _ready():
	get_node(button_sing_up).pressed.connect(start_sing_up.bind())



'''
assembly_type - возвращает тип сборки (сервер/клиент)
'''
func assembly_type():
	if multiplayer.is_server() == false:
		
		return 'Клиент'
		
	else:
		
		return 'Сервер'




'''
start_sing_up - запускает регистрации аккаунта
'''
func start_sing_up():
	
	pass
