extends Node2D

var player
var opponent
var application
var is_game_running = true
var player_pos0 
var opponent_pos0

func _ready():	
	application = get_node("/root/application")

	init_player()
	init_opponent()
	
	PS2D.body_add_collision_exception(player.get_rid(), opponent.get_rid())
	
	set_process(true)

func init_player():
	player = application.get_player()
	player_pos0 = player.get_pos()
	
	player.set_is_player(true)
	player.set_speed(application.PLAYER_SPEED)
	
func init_opponent():
	opponent = application.get_opponent()
	opponent_pos0 = opponent.get_pos()
	
	opponent.set_is_player(true)
	opponent.set_speed(application.AI_SPEED)
	
func _process(delta):
	if is_game_running:
		run(delta)
	else:
		if Input.is_action_pressed("ui_accept"):
			restart()
	
func run(delta):
	if is_player_dead():
		is_game_running = false
		get_node("status_label").set_text("Game Over! \n Press Space or Enter to restart.")
		#return
	
	if (Input.is_action_pressed("ui_left")):
		player.run_left()

	if (Input.is_action_pressed("ui_right")):
		player.run_right()

func is_player_dead():
	return player.get_pos().y > application.get_height()

func restart():
	is_game_running = true
	
	player.set_pos(player_pos0)
	opponent.set_pos(opponent_pos0)
	get_node("/root/Game/boat/top").set_rot(0)
	
	get_node("status_label").set_text("")