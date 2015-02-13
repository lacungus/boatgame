extends RigidBody2D

const VECTOR_LEFT = Vector2(-1, 0)
const VECTOR_RIGHT = Vector2(1, 0)

# TODO rename
# velocity
var velocity

var ai

var application

var is_player

func run(direction):
	if direction == null:
		return
	if direction == application.DIRECTION_LEFT:
		apply_impulse(VECTOR_LEFT, Vector2(-self.velocity, 0))
		return
	if direction == application.DIRECTION_RIGHT:
		apply_impulse(VECTOR_RIGHT, Vector2(self.velocity, 0))
		return
	print("Unknown direction: " + direction)
	
func get_is_player():
	return is_player
	
func run_left():
	run(application.DIRECTION_LEFT)

func run_right():
	run(application.DIRECTION_RIGHT)

func _ready():
	application = get_node("/root/application")
	ai.set_character(self)
	set_fixed_process(true)
	
func _fixed_process(delta):
	var decision = ai.make_decision()
	run(decision)
	
func is_dead():
	return get_pos().y > application.get_height()

func set_ai(ai):
	self.ai = ai
	
func set_velocity(velocity):
	self.velocity = velocity

func set_is_player(is_player):
	self.is_player = is_player
