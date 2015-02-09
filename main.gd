extends Node2D

var player
var opponent

func _ready():	
	player = get_node("player")
	opponent = get_node("opponent")
	
	PS2D.body_add_collision_exception(player.get_rid(), opponent.get_rid())
	
	set_process(true)

func _process(delta):
	if (Input.is_action_pressed("ui_left")):
		player.apply_impulse( Vector2(-10, 0), Vector2(-10, 0) )

	if (Input.is_action_pressed("ui_right")):
		player.apply_impulse( Vector2(10, 0), Vector2(10, 0) )
