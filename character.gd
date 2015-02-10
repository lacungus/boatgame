extends RigidBody2D

const DIRECTION_LEFT = Vector2(-1, 0)
const DIRECTION_RIGHT = Vector2(1, 0)

# TODO rename
# velocity? max_speed? strength?
var speed

# true - played by user
# false - AI
var is_player = false

var application

func set_is_player(is_player):
	self.is_player = is_player

func get_is_player():
	return self.is_player

func set_speed(speed):
	self.speed = speed
	
func run_left():
	apply_impulse(DIRECTION_LEFT, Vector2(-self.speed, 0))

func run_right():
	apply_impulse(DIRECTION_LEFT, Vector2(self.speed, 0))

func _ready():
	application = get_node("/root/application")
	pass
