extends CharacterBody2D

@onready var anim = $anim

enum ITEM {NULL, STICK}

var current_item : ITEM = ITEM.NULL

func animated_check(first_result, second_result, third_result, fourth_result, fifth_result):
	if velocity == Vector2.ZERO:
		anim.play(first_result)
	elif velocity.x > 0:
		anim.play(second_result)
	elif velocity.x < 0:
		anim.play(third_result)
	elif velocity.y > 0:
		anim.play(fourth_result)
	elif velocity.y < 0:
		anim.play(fifth_result)


const speed = 175
var direction = Vector2.ZERO

var current_action = ''

func _physics_process(_delta):
	velocity = Vector2.ZERO
	direction = Vector2(Input.get_axis('ui_left', 'ui_right'), Input.get_axis('ui_up', 'ui_down'))
	velocity = direction.normalized() * speed
	
	if current_item == ITEM.NULL:
	
		animated_check('idle', 'walk_right', 'walk_left', 'walk_down', 'walk_up')
		
	elif current_item == ITEM.STICK:
	
		animated_check('idle_with_a_stick', 'walk_right_with_a_stick', 'walk_left_with_a_stick', 'walk_down', 'walk_up')
	
	move_and_slide()
