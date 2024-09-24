extends Control


@onready var personal_account = $"."



func _ready():
	
	if personal_account.visible == true:
		
		print('Вход в аккаунт осуществлен')
