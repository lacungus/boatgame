extends Node2D

var player
var opponent
var application

func _ready():	
	application = get_node("/root/application")

	player = application.get_player()
	opponent = application.get_opponent()
	
	PS2D.body_add_collision_exception(player.get_rid(), opponent.get_rid())
	
	set_process(true)

func _process(delta):
	print(is_player_dead())
	
	if (Input.is_action_pressed("ui_left")):
		player.apply_impulse( Vector2(-10, 0), Vector2(-10, 0) )

	if (Input.is_action_pressed("ui_right")):
		player.apply_impulse( Vector2(10, 0), Vector2(10, 0) )

func is_player_dead():
	return player.get_pos().y > application.get_height()
