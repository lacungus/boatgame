extends Node2D

func _ready():	
	var player = get_node("player")
	var opponent = get_node("opponent")
	
	PS2D.body_add_collision_exception(player.get_rid(), opponent.get_rid())
	
	set_process(true)

func _process(delta):
	var ball = get_node("player")
	
	if (Input.is_action_pressed("ui_left")):
		ball.apply_impulse( Vector2(-10, 0), Vector2(-10, 0) )

	if (Input.is_action_pressed("ui_right")):
		ball.apply_impulse( Vector2(10, 0), Vector2(10, 0) )
