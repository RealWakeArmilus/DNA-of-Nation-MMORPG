extends Control

@onready var avatar = get_node('/root/Map/Avatar')

enum ITEM {NULL, STICK}

func _on_null():
	avatar.current_item = ITEM.NULL

func _on_stick():
	avatar.current_item = ITEM.STICK
