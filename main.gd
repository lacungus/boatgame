extends Node2D

func _ready():
	print("Ready!")
	set_process(true)

func _process(delta):
	var ball = get_node("player")
	
	if (Input.is_action_pressed("ui_left")):
		ball.apply_impulse( Vector2(-10, 0), Vector2(-10, 0) )

	if (Input.is_action_pressed("ui_right")):
		ball.apply_impulse( Vector2(10, 0), Vector2(10, 0) )
